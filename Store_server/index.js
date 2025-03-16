const express = require('express');
const app = express();
const port = 8000;
const cors = require('cors');
const db = require('./db')
const {generateJWT,authMiddleware} = require('./jwt_users');
app.use(express.json());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use((req, res, next) => {
    res.setHeader('X-Powered-By', 'Node.js');
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
});


app.post('/api/login', (req, res) => {

    try {

        let { mail_id, password } = req.body
        if (mail_id == "" || password == "") {
            throw new Error("Maild not found");
        }
        let query = `select * from user_details where mail_id=?`;
        db.query(query, [mail_id], (err, result) => {
            if (err) {
                return res.status(500).json({
                    status: "failed",
                    msg: "unknown error occured"
                })
            }

            if (result.length == 0) {
                res.json({
                    status: "Login Failed",
                    msg: "Mail id or password is in correct"
                })
                return;
            }
            if (password == result[0].user_token) {
                const jwt_token = generateJWT(result[0].user_id);
                res.json({
                    status: "success",
                    auth_token: jwt_token
                })
                return;
            }

            else {
                res.json({
                    status: "Login Failed",
                    msg: "Mail id or password is in correct"
                })
                return;
            }
        })
    } catch (err) {
        res.json({
            status: "failed",
            msg: "Enter all the fields"
        })
    }

})


// Fetch all items
app.get('/items', authMiddleware,(req, res) => {
    db.query('SELECT * FROM store_items ORDER BY item_no DESC', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});
// Add new item
app.post('/items',authMiddleware, (req, res) => {
    const { name, type, quantity, price } = req.body;
    db.query('INSERT INTO store_items (name, type, quantity, price) VALUES (?, ?, ?, ?)',
        [name, type, quantity, price],
        (err) => {
            if (err) return res.status(500).send(err);
            res.send('Item added successfully');
        });
});
// Update an item
app.post('/update/items/:id',authMiddleware, (req, res) => {
    const { id } = req.params;
    const { name, type, quantity, price } = req.body;
    db.query('UPDATE store_items SET name = ?,type=?, quantity=?, price=? WHERE item_no=?',
        [name, type, quantity, price, id],
        (err) => {
            if (err) return res.status(500).send("Item alredy in store");
            res.send('Item updated successfully');
        });
});
app.post("/purchase-items",authMiddleware, (req, res) => {
    const { customer_id, items } = req.body;
    if (!customer_id || !items || !Array.isArray(items) || items.length === 0) {
        return res.status(400).json({ error: "Invalid purchase request" });
    }

    let totalAmount = 0;
    let outOfStockItems = [];

    // Fetch latest store items
    db.query("SELECT * FROM store_items", (err, storeItems) => {
        if (err) {
            return res.status(500).json({ error: "Database error" });
        }

        let updates = [];
        let purchases = [];

        items.forEach((cartItem) => {
            const storeItem = storeItems.find(item => item.name === cartItem.name);

            if (!storeItem || storeItem.quantity < cartItem.quantity) {
                outOfStockItems.push(cartItem.name);
            } else {
                storeItem.quantity -= cartItem.quantity; // Deduct purchased items
                totalAmount += cartItem.quantity * cartItem.price;

                // Prepare update query
                updates.push({ item_no: storeItem.item_no, newQuantity: storeItem.quantity });

                // Prepare insert query for purchases
                purchases.push([customer_id, cartItem.name, cartItem.quantity, cartItem.price]);
            }
        });

        if (outOfStockItems.length > 0) {
            return res.status(400).json({ error: "Some items are out of stock", items: outOfStockItems });
        }

        // Update store inventory
        updates.forEach(update => {
            db.query("UPDATE store_items SET quantity = ? WHERE item_no = ?", [update.newQuantity, update.item_no], (err) => {
                if (err) {
                    console.error("Error updating item:", err);
                }
            });
        });

        // Store the purchases
        if (purchases.length > 0) {
            db.query("INSERT INTO purchases (customer_id, item_name, quantity, price) VALUES ?", [purchases], (err) => {
                if (err) {
                    console.error("Error inserting purchases:", err);
                    return res.status(500).json({ error: "Failed to store purchase records" });
                }
                res.json({ message: "Purchase successful", total: totalAmount });
            });
        } else {
            res.json({ message: "Purchase successful but no items recorded" });
        }
    });
});
app.post('/delete/:id',authMiddleware, (req, res) => {
    const { id } = req.params;
    db.query('DELETE FROM store_items WHERE item_no=?', [id], (err) => {
        if (err) return res.status(500).send(err);
        res.send('Item deleted successfully');
    });
});
app.get("/search", authMiddleware,(req, res) => {
    const searchTerm = req.query.q;

    if (!searchTerm) {
        return res.status(400).json({ message: "Search term is required" });
    }

    const query = `
        SELECT * FROM customers 
        WHERE name LIKE ? 
        OR mobile LIKE ? 
        OR locality LIKE ?
    `;

    const searchValue = `%${searchTerm}%`;

    db.query(query, [searchValue, searchValue, searchValue], (err, results) => {
        if (err) {
            return res.status(500).json({ message: "Database query error", error: err });
        }
        res.json(results);
    });
});
app.post("/customers",authMiddleware, (req, res) => {
    const { name, mobile, locality } = req.body;

    if (!name || !mobile || !locality) {
        return res.status(400).json({ error: "All fields are required." });
    }

    // Check if mobile number already exists
    const checkSql = "SELECT id FROM customers WHERE mobile = ?";
    db.query(checkSql, [mobile], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Database error while checking mobile number." });
        }
        if (results.length > 0) {
            return res.status(400).json({ error: "Customer already exists." });
        }

        // If not found, insert new customer
        const insertSql = "INSERT INTO customers (name, mobile, locality) VALUES (?, ?, ?)";
        db.query(insertSql, [name, mobile, locality], (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).json({ error: "Failed to add customer." });
            }
            res.json({ message: "Customer added successfully!", customerId: result.insertId });
        });
    });
});
// Fetch all customers
app.get("/customers",authMiddleware, (req, res) => {
    const sql = "SELECT * FROM customers";
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to fetch customers." });
        }
        res.json(results);
    });
});
// Delete a customer by ID
app.post("/delete/customer/:id",authMiddleware, (req, res) => {
    const customerId = req.params.id;
    const sql = "DELETE FROM customers WHERE id = ?";
    db.query(sql, [customerId], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to delete customer." });
        }
        res.json({ message: "Customer deleted successfully!" });
    });
});
// Update a customer by ID
app.post("/update/customers/:id",authMiddleware, (req, res) => {
    const customerId = req.params.id;
    const { name, phone, locality } = req.body;

    if (!name || !phone || !locality) {
        return res.status(400).json({ error: "All fields are required." });
    }

    const sql = "UPDATE customers SET name = ?, mobile = ?, locality=? WHERE id = ?";
    db.query(sql, [name, phone, locality, customerId], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Failed to update customer." });
        }
        res.json({ message: "Customer updated successfully!" });
    });
});
app.get("/purchases", authMiddleware,(req, res) => {
    const sql = `
SELECT customers.name AS customer_name, 
       purchases.item_name, 
       purchases.quantity, 
       purchases.price, 
       purchases.total_price, 
       purchases.purchase_date
FROM purchases
JOIN customers ON purchases.customer_id = customers.id
ORDER BY purchases.purchase_date DESC;



    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.log(err);
            return res.status(500).json({ error: "Failed to fetch purchases." });
        }
        res.json(results);
    });
});
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});