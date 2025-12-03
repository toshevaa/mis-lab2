import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mis_lab2/screens/home_screen.dart';
import 'package:mis_lab2/services/firebase_messaging_service.dart';
import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  try {
    final fcmService = FirebaseMessagingService();
    await fcmService.initialize();
  } catch (e) {
  }

  runApp(RecipesApp());
}

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: HomeScreen(),
    );
  }
}
