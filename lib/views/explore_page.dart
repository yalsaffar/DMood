import 'package:flutter/material.dart';
import 'package:dmood/widgets/post_widget.dart'; // Import your PostWidget here

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: ListView(
        children: [
          PostWidget(
            username: 'Daniel_Craig',
            userImageAsset: 'assets/images/img_avatar.png',
            postImageAsset: 'assets/images/london.jpg',
            description: 'Last day in London :( '
            
          ),
          PostWidget(
            username: 'Chuck.Bartowski',
            userImageAsset: 'assets/images/img_avatar.png',
            postImageAsset: 'assets/images/bodrum.jpg',
            description: 'View of the day <3 ',
            
          ),
          
        ],
      ),
    );
  }
}
