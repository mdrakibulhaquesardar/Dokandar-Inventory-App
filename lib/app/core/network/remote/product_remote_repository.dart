import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class ProductRemoteRepository {
  final _client = ApiClient.instance;

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    try {
      final response = await _client.get(ApiEndpoints.products);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('ProductRemoteRepository.getAllProducts error: $e');
      return [];
    }
  }

  Future<bool> createProduct(Map<String, dynamic> productData) async {
    try {
      final response = await _client.post(
        ApiEndpoints.products,
        data: productData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('ProductRemoteRepository.createProduct error: $e');
      return false;
    }
  }

  Future<bool> updateProduct(
    String id,
    Map<String, dynamic> productData,
  ) async {
    try {
      final response = await _client.put(
        ApiEndpoints.productById(id),
        data: productData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('ProductRemoteRepository.updateProduct error: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final response = await _client.delete(ApiEndpoints.productById(id));
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('ProductRemoteRepository.deleteProduct error: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await _client.get(
        ApiEndpoints.searchProducts,
        queryParams: {'q': query},
      );
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('ProductRemoteRepository.searchProducts error: $e');
      return [];
    }
  }
}
