import 'package:dmood/app.dart';
import 'package:flutter/material.dart';
import '../services/dynamo_db_handler.dart';
import 'sign_up_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoggedIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    print('Login attempt started.');
    final _dynamoDBHandler = DynamoDBHandler();

    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      print('Valid form. Attempting to log in with $email.');

      try {
        final userInfo =
            await _dynamoDBHandler.getUserInfo('Dmood_users', email);
        print('User info retrieved: $userInfo');

        if (userInfo != null && userInfo['password']?.s == password) {
          print('Login successful');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeContainerScreen()),
            (Route<dynamic> route) => false,
          );
          _showDialog('Login Success', 'Signed in!!!');
        } else {
          print('Wrong email or password');
          _showDialog('Login Failed', 'Wrong email or password');
        }
      } catch (e) {
        print('An error occurred during login: $e');
        _showDialog('Error', 'An error occurred. Please try again.');
      }
    } else {
      print('Form is not valid');
    }
  }

  void _showDialog(String title, String content) {
    print('Showing dialog: $title');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                print('Dialog closed.');
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 120),
              SizedBox(height: 50),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value != null && value.isEmpty
                    ? 'Email cannot be empty'
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
                validator: (value) => value != null && value.isEmpty
                    ? 'Password cannot be empty'
                    : null,
              ),
              SizedBox(height: 16),
              TextButton(
                child: Text('FORGOT PASSWORD'),
                onPressed: () {
                  // Add your forgot password logic here
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('LOG IN'),
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('OR LOG IN BY'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.g_translate),
                    onPressed: () {
                      // Add your Google login logic here
                    },
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () {
                      // Add your Facebook login logic here
                    },
                  ),
                ],
              ),
              TextButton(
                child: Text('SIGN UP'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
              ),
              if (_isLoggedIn)
                Text(
                  'Logged in!!!',
                  style: TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
