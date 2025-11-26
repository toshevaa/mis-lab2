import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    final data = jsonDecode(response.body);
    return (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    final data = jsonDecode(response.body);
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }

  Future<MealDetail> fetchMealDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    final data = jsonDecode(response.body);
    return MealDetail.fromJson(data['meals'][0]);
  }

  Future<MealDetail> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));
    final data = jsonDecode(response.body);
    return MealDetail.fromJson(data['meals'][0]);
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    final data = jsonDecode(response.body);
    if (data['meals'] == null) return [];
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }
}
