const express = require('express');
const app = express();
const port = 8000;
const cors = require('cors');
const db = require('./db')
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

// Fetch all items
app.get('/items', (req, res) => {
    db.query('SELECT * FROM store_items ORDER BY item_no DESC', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Add new item
app.post('/items', (req, res) => {
    const { name, type, quantity, price } = req.body;
    db.query('INSERT INTO store_items (name, type, quantity, price) VALUES (?, ?, ?, ?)',
        [name, type, quantity, price],
        (err) => {
            if (err) return res.status(500).send(err);
            res.send('Item added successfully');
        });
});

// Update an item
app.post('/update/items/:id', (req, res) => {
    const { id } = req.params;
    const { name, type, quantity, price } = req.body;
    db.query('UPDATE store_items SET name = ?,type=?, quantity=?, price=? WHERE item_no=?',
        [name, type, quantity, price, id],
        (err) => {
            if (err) return res.status(500).send("Item alredy in store");
            res.send('Item updated successfully');
        });
});


app.post("/purchase-items", (req, res) => {
    const { items } = req.body;

    if (!items || !Array.isArray(items) || items.length === 0) {
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

        items.forEach((cartItem) => {
            const storeItem = storeItems.find(item => item.name === cartItem.name);

            if (!storeItem || storeItem.quantity < cartItem.quantity) {
                outOfStockItems.push(cartItem.name);
            } else {
                storeItem.quantity -= cartItem.quantity; // Deduct purchased items
                totalAmount += cartItem.quantity * cartItem.price;

                // Prepare update query
                updates.push({ item_no: storeItem.item_no, newQuantity: storeItem.quantity });
            }
        });

        if (outOfStockItems.length > 0) {
            return res.status(400).json({ error: "Some items are out of stock", items: outOfStockItems });
        }

        // Update quantities in the database
        updates.forEach(update => {
            db.query("UPDATE store_items SET quantity = ? WHERE item_no = ?", [update.newQuantity, update.item_no], (err) => {
                if (err) {
                    console.error("Error updating item:", err);
                }
            });
        });

        res.json({ message: "Purchase successful", total: totalAmount });
    });
});



app.post('/delete/:id', (req, res) => {
    const { id } = req.params;
    db.query('DELETE FROM store_items WHERE item_no=?', [id], (err) => {
        if (err) return res.status(500).send(err);
        res.send('Item deleted successfully');
    });
});

// Start server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});