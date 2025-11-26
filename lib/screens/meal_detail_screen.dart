import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;
  MealDetailScreen({required this.mealId});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService apiService = ApiService();
  MealDetail? mealDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMealDetail();
  }

  void loadMealDetail() async {
    final data = await apiService.fetchMealDetail(widget.mealId);
    setState(() {
      mealDetail = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetail?.name ?? 'Loading...'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                mealDetail!.thumbnail,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 12),

            Text(
              mealDetail!.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            if (mealDetail!.youtube.isNotEmpty)
              ElevatedButton.icon(
                icon: Icon(Icons.play_circle_fill, color: Colors.red),
                label: Text('Watch on YouTube'),
                onPressed: () async {
                  final Uri url = Uri.parse(mealDetail!.youtube);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url,
                        mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not open YouTube link')),
                    );
                  }
                },
              ),

            SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Instructions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Text(mealDetail!.instructions,
                      style: TextStyle(fontSize: 14, height: 1.5)),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ingredients',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  ...mealDetail!.ingredients.map((i) => Text(i)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
