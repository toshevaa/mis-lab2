import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  MealCard({required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                meal.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    meal.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

