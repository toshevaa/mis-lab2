import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import 'meal_detail_screen.dart';

class RandomMealScreen extends StatefulWidget {
  @override
  _RandomMealScreenState createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  final ApiService apiService = ApiService();
  MealDetail? mealDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRandomMeal();
  }

  void loadRandomMeal() async {
    final data = await apiService.fetchRandomMeal();
    setState(() {
      mealDetail = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Meal')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : MealDetailScreen(mealId: mealDetail!.id),

    );
  }
}
