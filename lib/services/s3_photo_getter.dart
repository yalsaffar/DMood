//import 'package:amplify_flutter/amplify_flutter.dart';

class ImageService {
  // Replace with your actual S3 bucket base URL
  static final String _baseUrl = 'https://dmood-bucket10714-dev.s3.us-west-1.amazonaws.com/';

  static Future<String> retrieveImageUrl(String fileName) async {
    try {
      return _baseUrl + fileName;
    } catch (e) {
      print('Error retrieving image URL: $e');
      rethrow;
    }
  }
}
