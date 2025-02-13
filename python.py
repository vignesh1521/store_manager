#-----------------SUPERMARKET MANAGEMENT SYSTEM--------------------
items = [
    {'name': 'milk', 'quantity': 10, 'price': 100},
    {'name': 'bread', 'quantity': 15, 'price': 50},
    {'name': 'butter', 'quantity': 8, 'price': 200},
    {'name': 'eggs', 'quantity': 30, 'price': 5},
    {'name': 'cheese', 'quantity': 12, 'price': 150},
    {'name': 'apples', 'quantity': 20, 'price': 30},
    {'name': 'bananas', 'quantity': 25, 'price': 20},
    {'name': 'chicken', 'quantity': 5, 'price': 300},
    {'name': 'rice', 'quantity': 18, 'price': 80},
    {'name': 'pasta', 'quantity': 10, 'price': 70},
    {'name': 'tomatoes', 'quantity': 22, 'price': 40},
    {'name': 'oranges', 'quantity': 15, 'price': 35},
    {'name': 'grapes', 'quantity': 10, 'price': 60},
    {'name': 'watermelon', 'quantity': 5, 'price': 100},
    {'name': 'pineapple', 'quantity': 7, 'price': 90},
    {'name': 'mangoes', 'quantity': 12, 'price': 80},
    {'name': 'strawberries', 'quantity': 8, 'price': 120},
    {'name': 'pears', 'quantity': 14, 'price': 40},
    {'name': 'kiwi', 'quantity': 9, 'price': 70},
    {'name': 'pomegranates', 'quantity': 6, 'price': 150},
    {'name': 'cherries', 'quantity': 10, 'price': 200},
    {'name': 'soap', 'quantity': 20, 'price': 25},
    {'name': 'toothpaste', 'quantity': 15, 'price': 50},
    {'name': 'shampoo', 'quantity': 10, 'price': 100},
    {'name': 'painkillers', 'quantity': 30, 'price': 10},
    {'name': 'band-aids', 'quantity': 25, 'price': 5},
    {'name': 'antiseptic', 'quantity': 12, 'price': 80},
    {'name': 'cold syrup', 'quantity': 8, 'price': 60},
    {'name': 'cough drops', 'quantity': 20, 'price': 15},
    {'name': 'face wash', 'quantity': 18, 'price': 70},
    {'name': 'moisturizer', 'quantity': 10, 'price': 120}
]

while True:
    display=input("press enter to continue.")
    print('------------------Welcome to the supermarket------------------')
    print('1. View items\n2. Add items for sale\n3. Purchase items\n4. Search items \n5. Edit items\n6. Report \n7. Exit')
    choice = input('Enter the number of your choice : ')
    if choice == '1' :
        print('------------------View Items------------------')
        print('The number of items in the inventory are : ',len(items))
        while len(items) != 0:
            print('Here are all the items available in the supermarket.')
            print("-----------------------------------------")
            for item in items:
                for key, value in item.items():
                    print(key, ':', value)
                print("-----------------------------------------")
            break

    elif choice == '2' :
        print('------------------Add items------------------')
        print('To add an item fill in the form')
        # while True:
        #     try:
        #         number_items = int(input('Enter the number of items you want to add in the inventory : '))
        #         break
        #     except ValueError:
        #         print('Number of items should only be in digits')
        # for num in range(number_items):
        item = {}
        item['name'] = input('Item name : ')
        while True:
            try:
                item['quantity'] = int(input('Item quantity : '))
                break
            except ValueError:
                print('Quantity should only be in digits')
        while True:
            try:
                item['price'] = int(input('Price $ : '))
                break
            except ValueError:
                print('Price should only be in digits')
        print('Item has been successfully added.')
        items.append(item)

    elif choice == '3' :
        print('------------------purchase items------------------')
        for item in items:
            print(item['name'])
            print('-----------')
        purchase_item = input('which item do you want to purchase? Enter name : ')
        item_status=False
        for item in items:
            if purchase_item.lower() == item['name'].lower() :
                item_status=True
        for item in items:
            if item_status:
                if purchase_item.lower() == item['name'].lower() :
                    if item['quantity'] != 0 :
                        print('Pay', item['price'] , 'at checkout counter.')
                        item['quantity'] -= 1
                    else: 
                        print('item out of stock.')
            else:
                print("item not found")
                break

    elif choice == '4' :
        print('------------------search items------------------')
        find_item = input('Enter the item\'s name to search in inventory : ')
        item_status=False
        for item in items:
            if find_item.lower() == item['name'].lower() :
                item_status=True
        for item in items:
            if item_status:
                if item['name'].lower() == find_item.lower():
                    print('The item named ' + find_item + ' is displayed below with its details')
                    print(item)
            else:
                print("item not found")
                break

    elif choice == '5' :
        print('------------------edit items------------------')
        item_name = input('Enter the name of the item that you want to edit : ')
        item_status=False
        store_item=[]
        for item in items:
            store_item.append(item["name"])
            if item_name.lower() == item['name'].lower() :
                item_status=True
        print(store_item)
        for item in items:
            if item_status:
                if item_name.lower() == item['name'].lower():
                    print('Here are the current details of ' + item_name)
                    print(item)
                    while True:
                        updated_name=  input('Item name : ')
                        if(updated_name not in store_item):
                            item['name']=updated_name
                            break
                        else:
                            print(updated_name+" already in stock....")
                    while True:
                        try:
                            item['quantity'] = int(input('Item quantity : '))
                            break
                        except ValueError:
                            print('Quantity should only be in digits')
                    while True:
                        try:
                            item['price'] = int(input('Price $ : '))
                            break
                        except ValueError:
                            print('Price should only be in digits')
                    print('Item has been successfully updated.')
                    print(item)
            else:
                print('Item not found')
    elif choice =='6':
        print('------------------reoport------------------')
        for item in items:
            print(item)
    elif choice == '7' :
        print('------------------exited------------------')
        break

    else: 
         print('You entered an invalid option')
