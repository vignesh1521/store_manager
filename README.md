# 🛒 Supermarket Inventory Management System

A simple supermarket inventory management system using **Python**, **MySQL**, and **XAMPP**.

---

## 📌 Prerequisites

Ensure you have the following installed before proceeding:

1. **XAMPP** (to run MySQL Database) – [Download XAMPP](https://www.apachefriends.org/download.html)
2. **Python** (v3.10 or later) – [Download Python](https://www.python.org/downloads/)
3. **Required Python Libraries**:
   - `mysql-connector-python`
   - `pandas`
   - `tabulate`

You can install the required libraries using:

```
pip install mysql-connector-python pandas tabulate
```

---

## 🚀 Setup Instructions

### 1️⃣ Start MySQL in XAMPP

1. Open **XAMPP Control Panel**.
2. Start **Apache** and **MySQL**.
3. Click on **MySQL Admin**, which opens phpMyAdmin.

### 2️⃣ Create the Database & Table

1. Open **phpMyAdmin** (or use a MySQL client like MySQL Workbench).
2. Create a new database named `store`.
3. Import the `store.sql` file provided in this project:
   - Click **Import**.
   - Select `store.sql`.

### 3️⃣ Configure Database Connection (Already Connected In the File)

1. Open `main.py` (your Python script).
2. Ensure your **database connection** matches your MySQL setup:

```python
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="store"
)
```

- If your MySQL password is not empty, update `password="your_password"`.

### 4️⃣ Run the Application

1. Open a terminal and navigate to the project directory:

```sh
cd /path/to/your/project
```

2. Run the script:

```sh
python main.py
```

3. Follow the on-screen prompts to interact with the inventory system.

---

## 📜 Features

✅ **View Items** – Display all available inventory items. ✅ **Add Items** – Insert new products into inventory. ✅ **Purchase Items** – Simulate item purchase & update stock. ✅ **Search Items** – Look up specific items. ✅ **Edit Items** – Modify product details. ✅ **Delete Items** – Remove items from inventory. ✅ **Inventory Report** – Display total inventory, total worth, and group items by type.

---

## 🛠 Troubleshooting

- **Can't connect to MySQL?**

  - Ensure XAMPP MySQL is running.
  - Check `localhost/phpmyadmin` to confirm the database exists.

- **ModuleNotFoundError for MySQL Connector?**

  - Run `pip install mysql-connector-python`.


