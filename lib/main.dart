import 'package:dmood/views/view_s3_example.dart';
import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart'; // Make sure this path is correct
import 'package:dmood/views/upload_s3_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    if (!_amplifyConfigured) {
      try {
        await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);
        await Amplify.configure(amplifyconfig);

        setState(() {
          _amplifyConfigured = true;
        });
      } catch (e) {
        print("An error occurred configuring Amplify: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: _amplifyConfigured ? RetrieveImagePage() : CircularProgressIndicator(),

    );
  }
}
