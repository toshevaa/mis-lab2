import 'package:flutter/material.dart';
import 'package:mis_lab2/services/api_service.dart';
import 'package:mis_lab2/widgets/category_card.dart';
import 'package:mis_lab2/models/category.dart';
import 'package:mis_lab2/screens/category_meals_screen.dart';
import 'package:mis_lab2/screens/random_meal_screen.dart';
import 'package:mis_lab2/screens/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Category> categories = [];
  List<Category> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    final data = await apiService.fetchCategories();
    setState(() {
      categories = data;
      filteredCategories = data;
    });
  }

  void filterCategories(String query) {
    final filtered = categories
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() => filteredCategories = filtered);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes App'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FavoritesScreen())),
          ),
          IconButton(
            icon: Icon(Icons.casino),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => RandomMealScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search categories...',
                  border: OutlineInputBorder()),
              onChanged: filterCategories,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              itemCount: filteredCategories.length,
              itemBuilder: (_, index) {
                final category = filteredCategories[index];
                return CategoryCard(
                  category: category,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            CategoryMealsScreen(category.name)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}