import 'package:kitgendev/components/food_item.dart'; // Import your food_item.dart

class InventoryItem {
  final String id;
  final String category;
  final String name;
  final String imageUrl;
  double quantity; // Changed to double to match FoodItem
  final String unit;
  final String storageLocation;
  int daysToExpiry; // Changed to int
  final String colorCode;
  final String? subcategory;
  bool isFavorite;
  final String? generalSeason;
  final bool seasonality;
  final String? storageTips;
  final List<Map<String, dynamic>> bestUsedIn;

  InventoryItem({
    required this.id,
    required this.category,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.unit,
    required this.storageLocation,
    required this.daysToExpiry,
    required this.colorCode,
    this.subcategory,
    this.isFavorite = false,
    this.generalSeason,
    this.seasonality = true,
    this.storageTips,
    this.bestUsedIn = const [],
  });

  // Factory constructor to create an InventoryItem from a FoodItem
  factory InventoryItem.fromFoodItem(FoodItem foodItem) {
    return InventoryItem(
      id: foodItem.id.toString(),
      category: foodItem.category,
      name: foodItem.name,
      imageUrl: foodItem.imageUrl,
      quantity: foodItem.defaultQuantity, // No need to convert to int
      unit: foodItem.unit,
      storageLocation: foodItem.storageLocation,
      daysToExpiry: foodItem.daysToExpiry,
      colorCode: foodItem.colorCode,
      subcategory: foodItem.subcategory,
      isFavorite: foodItem.isFavorite,
      generalSeason: foodItem.generalSeason,
      seasonality: foodItem.seasonality,
      storageTips: foodItem.storageTips,
      bestUsedIn: foodItem.bestUsedIn,
    );
  }
}
