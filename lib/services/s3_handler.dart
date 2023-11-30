import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:amazon_s3_cognito/amazon_s3_cognito.dart';
import 'package:amazon_s3_cognito/image_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart' as path;

class S3Handler {
  late String awsAccessKeyId;
  late String awsSecretAccessKey;
  late String awsRegion;

  S3Handler() {
    dotenv.load();
    awsAccessKeyId = dotenv.env['aws_access_key_id']!;
    awsSecretAccessKey = dotenv.env['aws_secret_access_key']!;
    awsRegion = dotenv.env['aws_region']!;
  }

  Future<String?> uploadFileToS3(String filePath, String bucketName, String fileName) async {
    try {
      File file = File(filePath);
      Uint8List fileData = await file.readAsBytes();

      final fileUrl = await AmazonS3Cognito.upload(
        awsAccessKeyId,
        awsSecretAccessKey,
        awsRegion,
        bucketName,
        fileData as ImageData,
      );
      return getS3ObjectUrl(bucketName, fileName);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String getS3ObjectUrl(String bucketName, String objectName) {
    return 'https://$bucketName.s3.amazonaws.com/$objectName';
  }

  // Other methods can be implemented similarly if needed
}
