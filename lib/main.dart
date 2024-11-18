import 'package:flutter/material.dart';
import 'package:kitgendev/screens/ingredient_list_screen.dart';
import 'package:kitgendev/screens/recipes_screen.dart' as recipes;
import 'package:kitgendev/screens/main_home_screen.dart';
import 'package:kitgendev/screens/plan_screen.dart' as plan;
import 'package:kitgendev/screens/social_screen.dart';
import 'package:kitgendev/components/styles.dart';
import 'package:kitgendev/components/inventory_item.dart';
import 'package:kitgendev/components/app_bar.dart';

const String geminiApiKey = 'AIzaSyDw2PDSPu4fqWB_2yptwQZr90Ty_Pm07IQ';

// import 'package:path_provider/path_provider.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// Ensure that Flutter bindings are initialized
/* PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String packageName = packageInfo.packageName;
   String envFilePath = '';
  if (Platform.isAndroid) {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    envFilePath = '${appDocDir.path}/.env';
  } else if (Platform.isWindows) {
    envFilePath = 'C:\\projects\\kitgendev\\.env';
  } else {
   // Handle other platforms if needed
  } */

// Load environment variables await dotenv.load(fileName: envFilePath);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KitGenius',
      theme: ThemeData(
        canvasColor: AppTheme.appBackgroundColor,
        appBarTheme: AppTheme.appBarTheme,
        bottomNavigationBarTheme: AppTheme.bottomNavigationBarTheme,
        scaffoldBackgroundColor: AppTheme.appBackgroundColor,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<InventoryItem> _inventoryItems = [];
  late List<Widget> _screens; // Declare _screens here

  @override
  void initState() {
    super.initState();
    _screens = [
      ItemListScreen(inventoryItems: _inventoryItems),
      const recipes.RecipesScreen(),
      const MainHomeScreen(),
      const plan.PlanScreen(),
      const SocialScreen(),
    ]; // Initialize _screens in initState()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens, // No need for mapping here
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Social',
          ),
        ],
      ),
    );
  }
}

 