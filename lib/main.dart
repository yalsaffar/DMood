import 'package:flutter/material.dart';
import 'models/sign_in_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() {
  dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInPage(),
    );
  }
}