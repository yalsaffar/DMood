import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:dmood/services/dynamo_db_posts_handler.dart';
import 'package:dmood/services/s3_photo_getter.dart';
import 'package:dmood/views/home_page.dart';
import 'package:dmood/views/mood_tracker_screen.dart';
import 'package:dmood/views/post_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:dmood/app.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmood/services/dynamo_db_handler.dart';


// ignore: must_be_immutable
class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
  
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _firstName = '';
  String _lastName = '';
  String _location = '';
  String _email = '';
  List<Map<String, AttributeValue>> _userPosts = [];
  


 @override
void initState() {
  super.initState();
  _initializeData();
}
  Future<void> _initializeData() async {
  await _loadUserData();
  await _loadUserPosts();
}
  Future<void> _loadUserPosts() async {
    final posts = await PostsHandler().getUserPosts('all_posts_test2', _email);
    setState(() {
      _userPosts = posts;
    });
  }

Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    if (email != null) {
      _email = email;
      final userData = await DynamoDBHandler().getUserInfo('Dmood_users', email);
      setState(() {
        _firstName = userData?['firstName']?.s ?? '';
        _lastName = userData?['lastName']?.s ?? '';
        _location = userData?['location']?.s ?? '';
      });
    }
  }
GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Profile'),
    ),
      body: SingleChildScrollView(
      child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/img_avatar.png'),
          ),
          SizedBox(height: 20),
          Text(
            _firstName + ' ' + _lastName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _location,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFollowersFollowing('220 '),
              _buildFollowersFollowing('150 '),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildClickableIcon(Icons.camera_alt, () {
                // Handle Instagram icon click
              }),
              _buildClickableIcon(Icons.facebook, () {
                // Handle Facebook icon click
              }),
            ],
          ),
          SizedBox(height: 16), 
          Text(
            'Shots',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, 
            ),
          ),
          SizedBox(height: 20),
          _buildPostsGrid(),
        ],
      ),
    ),
  ),
      bottomNavigationBar: _buildBottomAppBar(context),
  );
}


  Widget _buildFollowersFollowing(String text) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Followers',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildClickableIcon(IconData icon, Function() onPressed) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: Colors.blue, // Change color as needed
      iconSize: 40,
    );
  }
   


 


void _showPostPopup(BuildContext context, String imagePath, String caption, String postDate, int likeCount, bool isUpvoted, String postId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PostPopUp(
        imagePath: imagePath,
        caption: caption,
        likeCount: likeCount,
        userName: _firstName,
        userLastName: _lastName,
        postDate: postDate,
        isUpvoted: isUpvoted,
        postId: postId,
        onDelete: (String postId) async {
          await PostsHandler().deletePost('all_posts_test2', _email, postId);          
          Navigator.of(context).pop(); // Close the popup after deletion
          //  refresh the list of posts
          await _loadUserPosts();
        },
      );
    },
  );
}





 /// Section Widget
  Widget _buildBottomAppBar(BuildContext context) {
    return CustomBottomAppBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Iconlylighthome:
        return "/";
      case BottomBarEnum.Explore:
        return "/";
      case BottomBarEnum.Iconlylightplus:
         return AppRoutes.moodTrackerScreen;
      case BottomBarEnum.Notification:
        return "/";
      case BottomBarEnum.User:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeContainerScreen:
      return HomePage();

      case AppRoutes.moodTrackerScreen:
        return MoodTrackerPage();
      default:
        return DefaultWidget();
    }
  }


  Widget _buildPostImage(Map<String, AttributeValue> post) {
  final imagePath = post['post_image_url']?.s ?? '';
  // Retrieve additional post details
  final caption = post['post_caption']?.s ?? 'No caption';
  final postDate = post['post_date']?.s ?? 'Unknown date';
  final likeCount = post['post_likes']?.n ?? '42';
  final isUpvoted = post['vote']?.boolValue ?? true;
  final postId = post['post_id']?.s ?? 'None';

  return FutureBuilder<String>(
    future: ImageService.retrieveImageUrl(imagePath),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return GestureDetector(
          onTap: () => _showPostPopup(context, snapshot.data!, caption, postDate, int.parse(likeCount), isUpvoted, postId),
          child: Container(
            margin: EdgeInsets.all(4),
            child: Image.network(
              snapshot.data!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}


  Widget _buildPostsGrid() {
  int postCount = _userPosts.length;
  int rowCount = (postCount / 3).ceil(); // Calculate the number of rows needed

  return Column(
    children: List.generate(rowCount, (rowIndex) {
      int startIndex = rowIndex * 3;
      int endIndex = startIndex + 3;
      List<Widget> rowItems = _userPosts
          .sublist(startIndex, endIndex > postCount ? postCount : endIndex)
          .map((post) => _buildPostImage(post))
          .toList();

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowItems,
      );
    }),
  );
}
}