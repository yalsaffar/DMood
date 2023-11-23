import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'models/mood_tracker_page.dart'; // Import your new page
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(color: Colors.grey),
        ),
      ),
      home: MoodTrackerPage(),
    );
  }
}
