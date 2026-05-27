import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class StoreRemoteRepository {
  final _client = ApiClient.instance;

  Future<Map<String, dynamic>?> getStore() async {
    try {
      final response = await _client.get(ApiEndpoints.store);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return body['data'] as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      debugPrint('StoreRemoteRepository.getStore error: $e');
      return null;
    }
  }

  Future<bool> updateStore(Map<String, dynamic> storeData) async {
    try {
      final response = await _client.put(
        ApiEndpoints.store,
        data: storeData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('StoreRemoteRepository.updateStore error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getStoreStats() async {
    try {
      final response = await _client.get(ApiEndpoints.storeStats);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return body['data'] as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      debugPrint('StoreRemoteRepository.getStoreStats error: $e');
      return null;
    }
  }
}
