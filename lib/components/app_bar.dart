import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        width: 150,
        height: 100,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Image.asset('assets/logo.png'),
        ),
      ),
      title: const Text('KitGenius'),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Navigate to Shopping List screen
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Navigate to Notifications screen
          },
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // Navigate to Profile/Settings screen
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class InventoryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<dynamic> inventoryItems; // Changed to dynamic
  final ValueChanged<List<dynamic>> onSearch; // Changed to dynamic

  const InventoryAppBar({
    super.key,
    required this.inventoryItems,
    required this.onSearch,
  });

  @override
  State<InventoryAppBar> createState() => _InventoryAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _InventoryAppBarState extends State<InventoryAppBar> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    List<dynamic> filteredItems = widget.inventoryItems.where((item) {
      // Assuming 'name' is a property of the items in inventoryItems
      final itemName = item['name'].toLowerCase();
      final searchText = _searchController.text.toLowerCase();
      return itemName.contains(searchText);
    }).toList();
    widget.onSearch(filteredItems);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search inventory...',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Show the manual entry modal/bottom sheet
          },
          child: const Text('Not in the list? Add yours'),
        ),
      ],
    );
  }
}
