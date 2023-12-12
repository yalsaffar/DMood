import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart'; // AWS DynamoDB API
import 'package:dmood/services/dynamo_db_posts_handler.dart'; // Import your PostsHandler class
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';
import 'package:dmood/services/s3_handler.dart';
import 'dart:io';

class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  final _formKey = GlobalKey<FormState>();
  final _postsHandler = PostsHandler();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  // Initialize your PostsHandler

  int upVotes = 0;
  int downVotes = 0;
  String moodNote = '';
  XFile? mediaFile;
  String mood = '';
  String post_id = '';
  String _imageUrl = '';
  String fullurl = ''; // For storing the mood (upvote/downvote)

  void _handleVote(bool isUpVote) {
    setState(() {
      mood = isUpVote ? 'upvote' : 'downvote';
    });
  }

  String getFileName(String filePath) {
    // Split the path by the directory separator
    List<String> parts = filePath.split(Platform.pathSeparator);

    // Return the last part of the array
    return parts.isNotEmpty ? parts.last : '';
  }

  Future<XFile?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  void _handleMediaUpload() async {
    final image = await pickImage();
    String imageurl = getFileName(image!.path);
    _retrieveImageUrl(imageurl);
    setState(() {
      _imageUrl = imageurl;
    });
  }

  // Use the image URL as needed

  // Upload the file and get the URL
  // final String _imageUrl = await uploadImage(_imageUrl);

  void _submitForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String currentDateTime =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    final postData = {
      'email': AttributeValue(s: email),
      'vote': AttributeValue(s: mood),
      'post_caption': AttributeValue(s: moodNote),
      'post_date': AttributeValue(s: currentDateTime.split(' – ')[0]),
      'post_time': AttributeValue(s: currentDateTime.split(' – ')[1]),
      'post_id': AttributeValue(s: _imageUrl),
      'post_image_url': AttributeValue(s: "public/" + _imageUrl),
    };

    try {
      await _postsHandler.addNewPost('all_posts_test2', postData);
      _showDialog('Success', 'Your mood has been successfully recorded.');
    } catch (e) {
      _showDialog('Error', 'Failed to record your mood: $e');
    }
  }

  Future<void> _retrieveImageUrl(String fileName) async {
    try {
      // Replace with your actual S3 bucket base URL
      uploadImage(fileName);
      String baseUrl =
          'https://dmood-bucket10714-dev.s3.us-west-1.amazonaws.com/public/';
      String completeUrl = baseUrl + fileName;
      setState(() {
        fullurl = completeUrl;
        print(fullurl); // Directly set the complete URL
      });
    } catch (e) {
      print('Error forming URL: $e');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: SingleChildScrollView(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                CircleAvatar(
                  radius: isSmallScreen ? 40 : 60,
                  backgroundImage: AssetImage('assets/images/img_avatar.png'),
                ),
                SizedBox(height: 10),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'How are you feeling today?',
                      textStyle: TextStyle(
                          fontSize: isSmallScreen ? 18.0 : 24.0,
                          fontWeight: FontWeight.bold),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
                SizedBox(height: 20),
                // Upvote and Downvote Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _handleVote(true),
                      icon: Icon(Icons.thumb_up),
                      label: Text('Upvote'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _handleVote(false),
                      icon: Icon(Icons.thumb_down),
                      label: Text('Downvote'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _handleMediaUpload();
                    },
                    child: Text('Upload Image')),
                SizedBox(height: 20),
                Image.network(fullurl, fit: BoxFit.cover),

                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mood Notes',
                    ),
                    onChanged: (value) {
                      moodNote = value;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit Mood'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }
}

String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
    case BottomBarEnum.Iconlylighthome:
      return AppRoutes.homeContainerScreen;
    case BottomBarEnum.Explore:
      return AppRoutes.explorePage;
    case BottomBarEnum.Iconlylightplus:
      return AppRoutes.moodTrackerScreen;
    case BottomBarEnum.Notification:
      return AppRoutes.notificationsScreen;
    case BottomBarEnum.User:
      return AppRoutes.userProfileScreen;
    default:
      return AppRoutes.homePage;
  }
}

Widget _buildBottomAppBar(BuildContext context) {
  return CustomBottomAppBar(onChanged: (BottomBarEnum type) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
  });
}
