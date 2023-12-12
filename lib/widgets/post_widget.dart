import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostWidget extends StatefulWidget {
  final String username;
  final String userImageAsset;
  final String postImageAsset;
  final String description;
  


   PostWidget({
    Key? key,
    required this.username,
    required this.userImageAsset,
    required this.postImageAsset,
    required this.description,
    
    
  }) : super(key: key);

    @override
  _PostWidgetState createState() => _PostWidgetState();

}

 class _PostWidgetState extends State<PostWidget> {
  bool liked = false;
  bool showCommentField = false;
  TextEditingController commentController = TextEditingController();
  List<String> comments = [];
  String selectedComment = '';


  @override
Widget build(BuildContext context) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(widget.userImageAsset),
          ),
          title: Text(widget.username),
          trailing: Icon(Icons.more_vert),
        ),
        SizedBox(height: 10),
        Image.network(
          widget.postImageAsset,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        liked = !liked;
                      });
                    },
                    child: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: liked ? Colors.red : null,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Like'),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showCommentField = true;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble_outline),
                        SizedBox(width: 8),
                        Text('Comment'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (comments.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: comments
                      .map(
                        (comment) => Text(
                          comment,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
        if (showCommentField)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showCommentField = false;
                      comments.add(commentController.text);
                      selectedComment = commentController.text;
                      commentController.clear();
                      print('Comment added: ${commentController.text}');
                    });
                  },
                  child: Text('Post'),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                widget.description
              ),
              SizedBox(height: 8),
                      if (selectedComment.isNotEmpty)
                        Text(
                          'Comment: $selectedComment',
                        ),
            
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    ),
  );
}

}
