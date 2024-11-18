import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kitgendev/components/food_item.dart'; // Import your food_item.dart
import 'package:kitgendev/components/inventory_item.dart'; // Import your inventory_item.dart
import 'package:kitgendev/components/styles.dart'; // Import the styles.dart
import 'package:kitgendev/main.dart';
class AddItemsScreen extends StatefulWidget {
  final List<InventoryItem> userInventory;

  const AddItemsScreen({super.key, required this.userInventory});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  List<String> uniqueCategories = [];
  String? _selectedCategory;
  List<String> _subcategories = [];
  List<FoodItem> _filteredItems = [];


  @override
  void initState() {
    super.initState();
print(geminiApiKey); 
    _initializeData();
  }

  void _initializeData() {
    // Get unique categories
    uniqueCategories =
        commonItems.map((item) => item['category'] as String).toSet().toList();

    // Set initial category (if available)
    if (uniqueCategories.isNotEmpty) {
      _selectedCategory = uniqueCategories.first;
    }

    _filterItems(); // Initial filtering
  }

  void _filterItems() {
    setState(() {
      _filteredItems = commonItems
          .where((item) => item['category'] == _selectedCategory)
          .map((item) => FoodItem.fromJson(item))
          .toList();

      // Get unique subcategories for the selected category
      _subcategories =
          _filteredItems.map((item) => item.subcategory ?? '').toSet().toList();
    });
  }

  void _addItemToInventory(FoodItem item) {
    InventoryItem newItem = InventoryItem.fromFoodItem(item);
    setState(() {
      widget.userInventory.add(newItem);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} added to inventory')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredient List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, widget.userInventory);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Menu
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: uniqueCategories
                  .map((category) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategory = category;
                            _filterItems();
                          });
                        },
                        style: AppTheme.categoryButtonStyle(
                            _selectedCategory == category), // Use AppTheme
                        child: Text(category),
                      ))
                  .toList(),
            ),
          ),
// In AddItemsScreen
          ElevatedButton(
            onPressed: () {
              // Show the manual entry modal/bottom sheet
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                      // Manual entry form UI
                      // ...
                      );
                },
              );
            },
            child: const Text('Not in the list? Add yours'),
          ),
          // Subcategory Menu (if available)
          if (_subcategories.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _subcategories
                    .map((subcategory) => ElevatedButton(
                          onPressed: () {
                            // TODO: Implement filtering by subcategory
                          },
                          child: Text(subcategory),
                        ))
                    .toList(),
              ),
            ),

          // Food Item Cards
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return StatefulBuilder(
                  builder: (context, setState) {
                    List<String> uniqueStorageLocations = commonItems
                        .map((item) => item['storageLocation'] as String)
                        .toSet()
                        .toList();

                    return Card(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: AppTheme.cardDecoration(
                          Color(int.parse(
                              item.colorCode.replaceFirst('#', '0xaa'))),
                        ),
                        child: Row(
                          // Use Row for horizontal layout
                          children: [
                            // Left side: Details
                            Expanded(
                              // Expand details to take available space
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(item.name),
                                        IconButton(
                                          icon: Icon(
                                            item.isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:
                                                Colors.red, // Customize color
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              item.isFavorite =
                                                  !item.isFavorite;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Storage: '),
                                        DropdownButton<String>(
                                          value: item.storageLocation,
                                          items: uniqueStorageLocations
                                              .map((location) =>
                                                  DropdownMenuItem(
                                                      value: location,
                                                      child: Text(location)))
                                              .toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              if (newValue != null) {
                                                item.storageLocation = newValue;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                        'Expires in: ${item.daysToExpiry} days'),
                                    Row(
                                      children: [
                                        // Quantity adjustment
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              if (item.defaultQuantity > 1) {
                                                // Prevent going below 1
                                                item.defaultQuantity--;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                            '${item.defaultQuantity} ${item.unit}'), // Display quantity
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              item.defaultQuantity++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Right side: Image with + button
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    item.imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.white, size: 30),
                                  onPressed: () => _addItemToInventory(item),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
