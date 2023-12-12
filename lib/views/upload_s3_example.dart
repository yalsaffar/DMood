import 'package:flutter/material.dart';
import 'package:dmood/services/s3_handler.dart';

class UploadS3Example extends StatefulWidget {
  @override
  _UploadS3ExampleState createState() => _UploadS3ExampleState();
}

class _UploadS3ExampleState extends State<UploadS3Example> {
  final TextEditingController _fileNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload S3 Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _fileNameController,
                decoration: InputDecoration(
                  labelText: 'Enter File Name for Upload',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String customFileName = _fileNameController.text.trim();
                uploadImage(customFileName);
              },
              child: Text('Upload Photo'),
            ),
          ],
        ),
      ),
    );
  }}