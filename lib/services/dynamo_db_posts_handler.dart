import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostsHandler {
  late final DynamoDB _dynamoDb;

  PostsHandler() {
    final credentials = AwsClientCredentials(
      accessKey: dotenv.env['aws_access_key_id']!,
      secretKey: dotenv.env['aws_secret_access_key']!,
    );

    _dynamoDb = DynamoDB(region: dotenv.env['aws_region']!, credentials: credentials);
  }

  Future<void> addNewPost(String tableName, Map<String, AttributeValue> postData) async {
    await _dynamoDb.putItem(
      tableName: tableName,
      item: postData,
    );
  }

  Future<void> updatePost(String tableName, String email, String postId, Map<String, AttributeValueUpdate> updateData) async {
    var key = <String, AttributeValue>{
      'email': AttributeValue(s: email),
      'post_id': AttributeValue(s: postId)
    };
    await _dynamoDb.updateItem(
      tableName: tableName,
      key: key,
      attributeUpdates: updateData,
    );
  }

  Future<Map<String, AttributeValue>?> getPostInfo(String tableName, String email, String postId) async {
    final response = await _dynamoDb.getItem(
      tableName: tableName,
      key: {
        'email': AttributeValue(s: email),
        'post_id': AttributeValue(s: postId)
      },
    );
    return response.item;
  }

  Future<List<Map<String, AttributeValue>>> getUserPosts(String tableName, String email) async {
    final response = await _dynamoDb.query(
      tableName: tableName,
      keyConditionExpression: 'email = :email',
      expressionAttributeValues: {
        ':email': AttributeValue(s: email)
      },
    );
    return response.items ?? [];
  }

  Future<void> deletePost(String tableName, String email, String postId) async {
    await _dynamoDb.deleteItem(
      tableName: tableName,
      key: {
        'email': AttributeValue(s: email),
        'post_id': AttributeValue(s: postId)
      },
    );
  }
}
