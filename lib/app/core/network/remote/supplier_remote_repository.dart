import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class SupplierRemoteRepository {
  final _client = ApiClient.instance;

  Future<List<Map<String, dynamic>>> getAllSuppliers() async {
    try {
      final response = await _client.get(ApiEndpoints.suppliers);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('SupplierRemoteRepository.getAllSuppliers error: $e');
      return [];
    }
  }

  Future<bool> createSupplier(Map<String, dynamic> supplierData) async {
    try {
      final response = await _client.post(
        ApiEndpoints.suppliers,
        data: supplierData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('SupplierRemoteRepository.createSupplier error: $e');
      return false;
    }
  }

  Future<bool> updateSupplier(
    String id,
    Map<String, dynamic> supplierData,
  ) async {
    try {
      final response = await _client.put(
        ApiEndpoints.supplierById(id),
        data: supplierData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('SupplierRemoteRepository.updateSupplier error: $e');
      return false;
    }
  }

  Future<bool> deleteSupplier(String id) async {
    try {
      final response = await _client.delete(ApiEndpoints.supplierById(id));
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('SupplierRemoteRepository.deleteSupplier error: $e');
      return false;
    }
  }
}
