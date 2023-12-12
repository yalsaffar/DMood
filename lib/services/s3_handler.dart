import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';

Future<void> uploadImage(String customFileName) async {
  // Select a file from the device
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    withData: false,
    // Ensure to get file stream for better performance
    withReadStream: true,
    allowedExtensions: ['jpg', 'png', 'gif'],
  );

  if (result == null) {
    safePrint('No file selected');
    return;
  }

  // Upload file with its filename as the key
  final platformFile = result.files.single;
  try {
    final result = await Amplify.Storage.uploadFile(
      localFile: AWSFile.fromStream(
        platformFile.readStream!,
        size: platformFile.size,
      ),
      key: customFileName, // Use customFileName instead of platformFile.name
      onProgress: (progress) {
        safePrint('Fraction completed: ${progress.fractionCompleted}');
      },
    ).result;
    safePrint('Successfully uploaded file: ${result.uploadedItem.key}');
  } on StorageException catch (e) {
    safePrint('Error uploading file: $e');
    rethrow;
  }
}
