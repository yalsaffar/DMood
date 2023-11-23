import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


// STRUCTURE MAKES SENSE, BUT HAVE NOT TEST IT ENTIRLY YET
class DynamoDBHandler {
  late final DynamoDB _dynamoDb;

  DynamoDBHandler() {
    final credentials = AwsClientCredentials(
      accessKey: dotenv.env['aws_access_key_id']!,
      secretKey: dotenv.env['aws_secret_access_key']!,
    );
      
    _dynamoDb = DynamoDB(region: dotenv.env['aws_region']!, credentials: credentials);
  }

   Future<void> addNewUser(String tableName, Map<String, AttributeValue> userData) async {
    await _dynamoDb.putItem(
      tableName: tableName,
      item: userData,
    );
  }

  Future<void> updateUser(String tableName, String email, Map<String, AttributeValueUpdate> updateData) async {
    var key = <String, AttributeValue>{'email': AttributeValue(s: email)};
    await _dynamoDb.updateItem(
      tableName: tableName,
      key: key,
      attributeUpdates: updateData,
    );
  }

  Future<Map<String, AttributeValue>?> getUserInfo(String tableName, String email) async {
    final response = await _dynamoDb.getItem(
      tableName: tableName,
      key: {'email': AttributeValue(s: email)},
    );
    return response.item;
  }

  Future<List<Map<String, AttributeValue>>> getAllUsers(String tableName) async {
    final response = await _dynamoDb.scan(tableName: tableName);
    return response.items ?? [];
  }

  Future<void> deleteUser(String tableName, String email) async {
    await _dynamoDb.deleteItem(
      tableName: tableName,
      key: {'email': AttributeValue(s: email)},
    );
  }

  Future<List<String>> listAllTables() async {
    final response = await _dynamoDb.listTables();
    return response.tableNames ?? [];
  }
}