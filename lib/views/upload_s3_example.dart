import 'dart:io';
import 'package:dmood/services/s3_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final ImagePicker _picker = ImagePicker();
  String _uploadedFileURL = '';
  final S3Handler _s3Handler = S3Handler(); // Initialize your S3Handler

  Future<void> _pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    String fileName = path.basename(image.path);
    String bucketName = 'dmood-bucket'; // Replace with your actual bucket name

    // Upload file
    String? fileUrl = await _s3Handler.uploadFileToS3(image.path, bucketName, fileName);
    if (fileUrl != null) {
      setState(() {
        _uploadedFileURL = fileUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image to S3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: Text('Pick and Upload Image'),
            ),
            SizedBox(height: 20),
            _uploadedFileURL.isNotEmpty
                ? Text('Uploaded to: $_uploadedFileURL')
                : Text('No image uploaded yet'),
          ],
        ),
      ),
    );
  }
}
