import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/dynamo_db_handler.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DynamoDBHandler _dbHandler = DynamoDBHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DynamoDB Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('DynamoDB in Flutter'),
        ),
        body: Center(
          // Your app content
        ),
      ),
    );
  }
}
