const mysql = require('mysql2'); 
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'store'
});

db.connect(err => {
    if (err) {
        console.error('Database connection failed:', err);
    } else {
        console.log('Database Connected');
    }
});
module.exports = db ;