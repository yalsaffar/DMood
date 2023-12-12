import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart'; // AWS DynamoDB API
import 'package:dmood/services/dynamo_db_posts_handler.dart'; // Import your PostsHandler class
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';

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
  String post_id = ''; // For storing the mood (upvote/downvote)

  void _handleVote(bool isUpVote) {
    setState(() {
      mood = isUpVote ? 'upvote' : 'downvote';
    });
  }

  void _handleMediaUpload() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      mediaFile = image;
    });
  }

  String generateUniqueId(String userId) {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    return "$userId-$timestamp";
  }

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
      'post_id': AttributeValue(s: generateUniqueId(email!)),
      if (mediaFile != null) 'media_url': AttributeValue(s: mediaFile!.path),
    };

    try {
      await _postsHandler.addNewPost('all_posts_test2', postData);
      _showDialog('Success', 'Your mood has been successfully recorded.');
    } catch (e) {
      _showDialog('Error', 'Failed to record your mood: $e');
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
                  onPressed: _handleMediaUpload,
                  child: Text('Upload Media'),
                ),
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
                Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: Center(
                      child: Text('Mood History Visualization Placeholder')),
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
