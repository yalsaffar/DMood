import 'package:flutter/material.dart';
import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:dmood/services/dynamo_db_posts_handler.dart'; // Import your PostsHandler class

class PostFormPage extends StatefulWidget {
  @override
  _PostFormPageState createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _postsHandler = PostsHandler(); // Initialize your PostsHandler

  String _email = '';
  String _postCaption = '';
  String _photoUrl = '';
  String _postDate = '';
  String _postTime = '';
  String _postId = '';
  String _vote = '';


 void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    
    // Prepare data for DynamoDB
    final postData = {
      'email': AttributeValue(s: _email),
      'post_caption': AttributeValue(s: _postCaption),
      'post_image_url': AttributeValue(s: _photoUrl),
      'post_date': AttributeValue(s: _postDate),
      'post_time': AttributeValue(s: _postTime),
      'post_id': AttributeValue(s: _postId),
      'vote': AttributeValue(s: _vote) // Add this line
    };


    try {
      // Call addNewPost method
      await _postsHandler.addNewPost('all_posts_test2', postData);
      
      // Show a success message
      _showDialog('Success', 'The post has been successfully added.');
    } catch (e) {
      // Show an error message
      _showDialog('Error', 'Failed to add the post: $e');
    }
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
    return Scaffold(
      appBar: AppBar(title: Text('Create a Post')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) => value!.isEmpty ? 'Please enter email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Post Caption'),
                onSaved: (value) => _postCaption = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vote'),
                onSaved: (value) => _vote = value!,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Photo URL'),
                onSaved: (value) => _photoUrl = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Post Date (YYYY-MM-DD)'),
                onSaved: (value) => _postDate = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Post Time (HH:MM)'),
                onSaved: (value) => _postTime = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Post ID'),
                onSaved: (value) => _postId = value!,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
