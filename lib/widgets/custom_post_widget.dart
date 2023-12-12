import 'package:flutter/material.dart';

class CustomPostWidget extends StatelessWidget {
  final String username;
  final Future<String> userImageFuture;
  final Future<String> postImageFuture;
  final String description;
  final String location;
  final String date;
  final String time;
  final String vote;
  final int likes;

  CustomPostWidget({
    required this.username,
    required this.userImageFuture,
    required this.postImageFuture,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.vote,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: FutureBuilder<String>(
              future: userImageFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!),
                  );
                }
                return CircleAvatar(
                  backgroundImage: AssetImage('assets/default_user.png'),
                );
              },
            ),
            title: Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('$location · $date · $time'),
            trailing: Icon(
              vote == 'upvote' ? Icons.thumb_up : Icons.thumb_down,
              color: vote == 'upvote' ? Colors.green : Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(description, style: TextStyle(fontSize: 16)),
          ),
          FutureBuilder<String>(
            future: postImageFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.startsWith('http')) {
                return Image.network(snapshot.data!, fit: BoxFit.contain);
              }
              return Image.asset('assets/images/placeholder.png', fit: BoxFit.contain);
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$likes Likes', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up, color: Colors.grey),
                      onPressed: () {/* Handle like */},
                    ),
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.grey),
                      onPressed: () {/* Handle comment */},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
