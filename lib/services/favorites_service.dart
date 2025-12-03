import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _userId = 'default_user';

  Future<List<String>> getFavorites() async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .get();

      return doc.docs.map((d) => d.id).toList();
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }

  Future<void> addFavorite(String recipeId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(recipeId)
          .set({
        'addedAt': FieldValue.serverTimestamp(),
      });
      print('Added $recipeId to favorites');
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  Future<void> removeFavorite(String recipeId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(recipeId)
          .delete();
      print('Removed $recipeId from favorites');
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  Future<bool> isFavorite(String recipeId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(recipeId)
          .get();

      return doc.exists;
    } catch (e) {
      print('Error checking favorite: $e');
      return false;
    }
  }

  Future<bool> toggleFavorite(String recipeId) async {
    final isFav = await isFavorite(recipeId);

    if (isFav) {
      await removeFavorite(recipeId);
      return false;
    } else {
      await addFavorite(recipeId);
      return true;
    }
  }
}