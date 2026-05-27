import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class CategoryRemoteRepository {
  final _client = ApiClient.instance;

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      final response = await _client.get(ApiEndpoints.categories);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('CategoryRemoteRepository.getAllCategories error: $e');
      return [];
    }
  }

  Future<bool> createCategory(Map<String, dynamic> categoryData) async {
    try {
      final response = await _client.post(
        ApiEndpoints.categories,
        data: categoryData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('CategoryRemoteRepository.createCategory error: $e');
      return false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      final response = await _client.delete(ApiEndpoints.categoryById(id));
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('CategoryRemoteRepository.deleteCategory error: $e');
      return false;
    }
  }
}
