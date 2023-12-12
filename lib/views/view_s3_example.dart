import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class RetrieveImagePage extends StatefulWidget {
  @override
  _RetrieveImagePageState createState() => _RetrieveImagePageState();
}

class _RetrieveImagePageState extends State<RetrieveImagePage> {
  final TextEditingController _fileNameController = TextEditingController();
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Image'),
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
                  labelText: 'Enter File Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String fileName = _fileNameController.text.trim();
                await _retrieveImageUrl(fileName);
              },
              child: Text('Retrieve Image'),
            ),
            SizedBox(height: 20),
            _imageUrl.isNotEmpty 
                ? Image.network(_imageUrl) 
                : Text('Image will be displayed here'),
          ],
        ),
      ),
    );
  }

  Future<String> getDownloadUrl({
  required String key,
}) async {
  try {
    final result = await Amplify.Storage.getUrl(
      key: key,
      options: const StorageGetUrlOptions(
        pluginOptions: S3GetUrlPluginOptions(
          validateObjectExistence: true,
          expiresIn: Duration(days: 1),
        ),
      ),
    ).result;
    return result.url.toString();
  } on StorageException catch (e) {
    safePrint('Could not get a downloadable URL: ${e.message}');
    rethrow;
  }
}



  Future<void> _retrieveImageUrl(String fileName) async {
  try {
    // Replace with your actual S3 bucket base URL
    String baseUrl = 'https://dmood-bucket10714-dev.s3.us-west-1.amazonaws.com/';
    String completeUrl = baseUrl + fileName;

    setState(() {
      _imageUrl = completeUrl; // Directly set the complete URL
    });
  } catch (e) {
    print('Error forming URL: $e');
  }
}


  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }
}
