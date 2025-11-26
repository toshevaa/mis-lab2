class Meal {
  final String id;
  final String name;
  final String thumbnail;

  Meal({required this.id, required this.name, required this.thumbnail});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
    );
  }
}

class MealDetail {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final String youtube;
  final List<String> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().isNotEmpty) {
        ingredients.add('$ingredient - $measure');
      }
    }
    return MealDetail(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      instructions: json['strInstructions'],
      youtube: json['strYoutube'] ?? '',
      ingredients: ingredients,
    );
  }
}
