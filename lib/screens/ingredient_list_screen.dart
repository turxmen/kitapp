import 'package:flutter/material.dart';
import 'package:kitgendev/components/food_item.dart';
import 'package:kitgendev/components/inventory_item.dart'; // Import your inventory_item.dart
import 'package:kitgendev/components/add_items.dart'; // Import the AddItemsScreen
import 'package:kitgendev/components/app_bar.dart'; // Import app_bar.dart
class ItemListScreen extends StatefulWidget {
  final List<InventoryItem> inventoryItems; // Add this

  const ItemListScreen(
      {super.key, required this.inventoryItems}); // Update constructor

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<InventoryItem> _inventoryItems = [];
  List<FoodItem> _displayedItems = [];

  @override
  void initState() {
    super.initState();
    _displayedItems = widget.inventoryItems.cast<FoodItem>(); // Initialize with all items

    // Assume _inventoryItems is passed from AddItemsScreen
    // and is available here. No need to load again.
    _sortInventoryItems();
  }
  void _updateDisplayedItems(List<dynamic> filteredItems) {
    setState(() {
      _displayedItems = filteredItems.cast<FoodItem>();
    });
  }

  void _sortInventoryItems() {
    setState(() {
      _inventoryItems.sort((a, b) => a.daysToExpiry.compareTo(b.daysToExpiry));
    });
  }

  void _addItemToShoppingList(InventoryItem item) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to shopping list'),
        duration: const Duration(seconds: 2),
        //TODO Add the logic to add the item to the shopping list
      ),
    );

  void _removeItemFromInventory(InventoryItem item) {
    setState(() {
      _inventoryItems.remove(item);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InventoryAppBar(
        inventoryItems: widget.inventoryItems.cast<FoodItem>(),
        onSearch: _updateDisplayedItems,
      ),
      body: _inventoryItems.isEmpty // Conditionally render content
          ? Center(
              // Empty state
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Your inventory is empty!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate to AddItemsScreen and wait for the result
                      final updatedInventory = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddItemsScreen(userInventory: _inventoryItems),
                        ),
                      );

                      // Update inventory items after returning from AddItemsScreen
                      if (updatedInventory != null) {
                        setState(() {
                          _inventoryItems = updatedInventory;
                          _sortInventoryItems(); // Sort after updating
                        });
                      }
                    },
                    child: const Text('Add Items'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _inventoryItems.length,
              itemBuilder: (context, index) {
                final item = _inventoryItems[index];
                return ListTile(
                  leading: Icon(
                    _getIconForCategory(item.category),
                    color: Color(
                        int.parse(item.colorCode.replaceFirst('#', '0xaa'))),
                  ),
                  title: Text(item.name),
                  subtitle: Text(
                    'You have ${item.quantity} ${item.unit} remaining and it may expire in ${item.daysToExpiry} days',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Remove Item"),
                                content: const Text(
                                    "Do you want to add this item to your shopping list?"),
                                actions: [
                                  TextButton(
                                    child: const Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _removeItemFromInventory(item);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Yes"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _addItemToShoppingList(item);
                                      _removeItemFromInventory(item);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          _addItemToShoppingList(item);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final updatedInventory = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddItemsScreen(userInventory: _inventoryItems),
            ),
          );
          if (updatedInventory != null) {
            setState(() {
              _inventoryItems = updatedInventory;
              _sortInventoryItems(); // Sort after updating
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    // You can get the category information from your food_item.dart
    // and map categories to icons here, similar to the previous example
    switch (category) {
      case 'Vegetables':
        return Icons.local_florist;
      case 'Fruits':
        return Icons.apple;
      case 'Dairy':
        return Icons.local_cafe;
      case 'Meat':
        return Icons.local_dining;
      default:
        return Icons.fastfood;
    }
  }
}
