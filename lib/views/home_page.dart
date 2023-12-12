import 'package:dmood/services/dynamo_db_handler.dart';
import 'package:dmood/services/dynamo_db_posts_handler.dart';
import 'package:dmood/services/s3_photo_getter.dart';
import 'package:dmood/widgets/custom_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:dmood/app.dart';
import 'package:dmood/routes/app_routes.dart';
import 'package:dmood/widgets/custom_bottom_app_bar.dart';

//ExplorePage
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Map<String, dynamic>>>? _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _fetchAllPosts();
  }

  Future<List<Map<String, dynamic>>> _fetchAllPosts() async {
    var posts = await PostsHandler().getAllPosts("all_posts_test2");
    List<Map<String, dynamic>> fullPosts = [];

    for (var post in posts) {
      var email = post['email']?.s ?? '';
      var userInfo = await DynamoDBHandler().getUserInfo('Dmood_users', email);
      var firstName = userInfo?['firstName']?.s ?? '';
      var lastName = userInfo?['lastName']?.s ?? '';
      var profileImageUrl = ImageService.retrieveImageUrl('public/$firstName$lastName' + "profile.jpg");
      var postImageUrl = ImageService.retrieveImageUrl(post['post_image_url']?.s ?? '');
      fullPosts.add({
        'username': '$firstName $lastName',
        'userImage': profileImageUrl,
        'postImage': postImageUrl,
        'description': post['post_caption']?.s ?? 'No caption',
        'location': post['location']?.s ?? 'No location',
        'date': post['post_date']?.s ?? 'No date',
        'time': post['post_time']?.s ?? 'No time',
        'vote': post['vote']?.s ?? 'upvote',
        'likes': post['likes']?.n ?? 0,

        // Add other post details as needed
      });
    }

    return fullPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true, // Add this line to center the title
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var post = snapshot.data![index];
                return CustomPostWidget(
                  username: post['username'],
                  userImageFuture: post['userImage'],
                  postImageFuture: post['postImage'],
                  description: post['description'],
                  location: post['location'],
                  date: post['date'],
                  time: post['time'],
                  vote: post['vote'],
                  likes: post['likes'],
                );
              },
            );
          } else {
            return Center(child: Text("No posts found"));
          }
        },
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
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
}