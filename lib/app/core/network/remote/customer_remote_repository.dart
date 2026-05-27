import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class CustomerRemoteRepository {
  final _client = ApiClient.instance;

  Future<List<Map<String, dynamic>>> getAllCustomers() async {
    try {
      final response = await _client.get(ApiEndpoints.customers);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('CustomerRemoteRepository.getAllCustomers error: $e');
      return [];
    }
  }

  Future<bool> createCustomer(Map<String, dynamic> customerData) async {
    try {
      final response = await _client.post(
        ApiEndpoints.customers,
        data: customerData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('CustomerRemoteRepository.createCustomer error: $e');
      return false;
    }
  }

  Future<bool> updateCustomer(
    String id,
    Map<String, dynamic> customerData,
  ) async {
    try {
      final response = await _client.put(
        ApiEndpoints.customerById(id),
        data: customerData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('CustomerRemoteRepository.updateCustomer error: $e');
      return false;
    }
  }

  Future<bool> deleteCustomer(String id) async {
    try {
      final response = await _client.delete(ApiEndpoints.customerById(id));
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('CustomerRemoteRepository.deleteCustomer error: $e');
      return false;
    }
  }
}
