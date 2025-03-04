import mysql.connector
import pandas as pd
from tabulate import tabulate

# Database Connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="store"
)
db = conn.cursor()

if conn.is_connected():
    print("Database Connected")
else:
    print("Connection Error")


# Function to fetch and display items
def fetch_and_display_items(query="SELECT name, type, quantity, price FROM store_items ORDER BY type"):
    db.execute(query)
    items = db.fetchall()
    if items:
        df = pd.DataFrame(items, columns=['Name', 'Type', 'Quantity', 'Price'])
        print(tabulate(df, headers='keys', tablefmt='grid'))
    else:
        print("No items found.")


# Function to check if an item exists
def item_exists(name):
    db.execute("SELECT COUNT(*) FROM store_items WHERE LOWER(name) = %s", (name.lower(),))
    return db.fetchone()[0] > 0


# Function to view items
def view_items():
    print('------------------ View Items ------------------')
    fetch_and_display_items()


# Function to add items
def add_items():
    while True:
        print('------------------ Add Items ------------------')
        item_name = input("Item name: ").strip().lower()

        if item_exists(item_name):
            print("Item already exists. Try adding a different item.")
            continue

        item_type = input("Enter item type: ").capitalize()

        while True:
            try:
                quantity = int(input('Item quantity: '))
                price = int(input('Price ₹: '))
                break
            except ValueError:
                print("Quantity and price should be digits.")

        db.execute("INSERT INTO store_items (name, type, quantity, price) VALUES (%s, %s, %s, %s)",
                   (item_name, item_type, quantity, price))
        conn.commit()
        print(f'Item "{item_name}" added successfully.')

        if input("Add another item? (yes/no): ").strip().lower() != "yes":
            break


# Function to purchase items
def purchase_items():
    print('------------------ Purchase Items ------------------')
    fetch_and_display_items("SELECT name, price, quantity FROM store_items")

    purchase_item = input('Enter the item name you want to purchase: ').strip().lower()
    db.execute("SELECT quantity, price FROM store_items WHERE LOWER(name) = %s", (purchase_item,))
    item = db.fetchone()

    if not item:
        print("Item not found.")
        return

    available_quantity, price = item
    if available_quantity == 0:
        print('Item out of stock.')
        return

    while True:
        try:
            purchase_quantity = int(input(f'How many units? (Available: {available_quantity}): '))
            if purchase_quantity <= 0 or purchase_quantity > available_quantity:
                print("Invalid quantity. Try again.")
                continue
            break
        except ValueError:
            print("Please enter a valid number.")

    total_cost = purchase_quantity * price
    print(f'Total amount: ₹{total_cost}. Proceed to checkout.')

    db.execute("UPDATE store_items SET quantity = quantity - %s WHERE LOWER(name) = %s",
               (purchase_quantity, purchase_item))
    conn.commit()
    print(f'Successfully purchased {purchase_quantity} units of {purchase_item}.')


# Function to search for items
def search_items():
    while True:
        print('------------------ Search Items ------------------')
        search_item = input("Enter the item's name to search: ").strip().lower()

        db.execute("SELECT name, type, quantity, price FROM store_items WHERE LOWER(name) = %s", (search_item,))
        item = db.fetchall()

        if item:
            df = pd.DataFrame(item, columns=['Name', 'Type', 'Quantity', 'Price'])
            print(tabulate(df, headers='keys', tablefmt='grid'))
        else:
            print("Item not found.")

        if input("Search another item? (yes/no): ").strip().lower() != "yes":
            break


# Function to edit items
def edit_items():
    while True:
        print('------------------ Edit Items ------------------')
        edit_item = input('Enter the name of the item you want to edit: ').strip().lower()

        db.execute("SELECT name, type, quantity, price FROM store_items WHERE LOWER(name) = %s", (edit_item,))
        item = db.fetchone()

        if not item:
            print('Item not found.')
            return

        df = pd.DataFrame([item], columns=['Name', 'Type', 'Quantity', 'Price'])
        print(tabulate(df, headers='keys', tablefmt='grid'))

        while True:
            new_name = input("New Item Name: ").strip().lower()
            if new_name == edit_item or not item_exists(new_name):
                break
            print("Item name already exists. Try a different name.")

        new_type = input("Enter new item type: ").capitalize()

        while True:
            try:
                new_quantity = int(input('New Quantity: '))
                new_price = int(input('New Price ₹: '))
                break
            except ValueError:
                print('Quantity and price should be digits.')

        db.execute("UPDATE store_items SET name = %s, type = %s, quantity = %s, price = %s WHERE LOWER(name) = %s",
                   (new_name, new_type, new_quantity, new_price, edit_item))
        conn.commit()
        print(f'Item "{edit_item}" updated successfully.')

        if input("Edit another item? (yes/no): ").strip().lower() != "yes":
            break

# Function to generate inventory report
def inventory_report():
    print('------------------ Inventory Report ------------------')

    # Total items in inventory
    db.execute("SELECT COUNT(*) FROM store_items")
    total_items = db.fetchone()[0]

    # Total worth of items in inventory
    db.execute("SELECT SUM(quantity * price) FROM store_items")
    total_worth = db.fetchone()[0] or 0  # Handle None if inventory is empty

    # Grouped by item type
    db.execute("""
        SELECT type, COUNT(name) AS item_count, SUM(quantity * price) AS total_worth
        FROM store_items
        GROUP BY type
    """)
    grouped_data = db.fetchall()

    # Display Summary
    print(f"\n📦 Total Items in Inventory: {total_items}")
    print(f"💰 Total Worth of Inventory: ₹{total_worth}\n")

    if grouped_data:
        df = pd.DataFrame(grouped_data, columns=['Item Type', 'Item Count', 'Total Worth'])
        print(tabulate(df, headers='keys', tablefmt='grid'))
    else:
        print("No items in inventory.")
# Function to delete an item
def delete_item():
    print('------------------ Delete Item ------------------')
    
    item_name = input('Enter the name of the item to delete: ').strip().lower()

    # Check if the item exists
    db.execute("SELECT name, type, quantity, price FROM store_items WHERE name = %s", (item_name,))
    item = db.fetchone()

    if item:
        # Display item details
        df = pd.DataFrame([item], columns=['Name', 'Type', 'Quantity', 'Price'])
        print(tabulate(df, headers='keys', tablefmt='grid'))
        
        # Confirm deletion
        confirm = input(f"Are you sure you want to delete '{item_name}'? (yes/no): ").strip().lower()
        if confirm == 'yes':
            db.execute("DELETE FROM store_items WHERE name = %s", (item_name,))
            conn.commit()
            print(f"✅ '{item_name}' has been successfully deleted from inventory.")
        else:
            print("❌ Deletion canceled.")
    else:
        print("⚠️ Item not found in inventory.")



# Main program loop
while True:
    print('------------------ Welcome to the Supermarket ------------------')
    print('1. View items\n2. Add items for sale\n3. Purchase items\n4. Search items\n5. Edit items\n6. Report\n7. Delete item\n8. Exit')
    
    choice = input('Enter the number of your choice: ').strip()
    
    if choice == '1':
        view_items()
    elif choice == '2':
        add_items()
    elif choice == '3':
        purchase_items()
    elif choice == '4':
        search_items()
    elif choice == '5':
        edit_items()
    elif choice == '6':
        inventory_report()
    elif choice =='7':
        delete_item()
    elif choice == '8':
        print('------------------ Exited ------------------')
        break
    else:
        print('Invalid option. Please try again.')

# Close connection
db.close()
conn.close()
