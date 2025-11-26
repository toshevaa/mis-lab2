import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class CategoryMealsScreen extends StatefulWidget {
  final String category;

  CategoryMealsScreen(this.category);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  final ApiService apiService = ApiService();
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  void loadMeals() async {
    final data = await apiService.fetchMealsByCategory(widget.category);
    setState(() {
      meals = data;
      filteredMeals = data;
    });
  }

  void filterMeals(String query) {
    final filtered = meals.where(
          (m) => m.name.toLowerCase().contains(query.toLowerCase()),
    ).toList();

    setState(() => filteredMeals = filtered);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search meals...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search)),
              onChanged: filterMeals,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
              itemCount: filteredMeals.length,
              itemBuilder: (_, index) {
                final meal = filteredMeals[index];
                return MealCard(
                  meal: meal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: meal.id)),
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
