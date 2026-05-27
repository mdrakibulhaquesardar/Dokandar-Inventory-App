import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class SaleRemoteRepository {
  final _client = ApiClient.instance;

  Future<List<Map<String, dynamic>>> getAllSales() async {
    try {
      final response = await _client.get(ApiEndpoints.sales);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('SaleRemoteRepository.getAllSales error: $e');
      return [];
    }
  }

  Future<bool> createSale(Map<String, dynamic> saleData) async {
    try {
      final response = await _client.post(ApiEndpoints.sales, data: saleData);
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('SaleRemoteRepository.createSale error: $e');
      return false;
    }
  }

  Future<bool> updateSale(String id, Map<String, dynamic> saleData) async {
    try {
      final response = await _client.put(
        ApiEndpoints.saleById(id),
        data: saleData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('SaleRemoteRepository.updateSale error: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getSalesToday() async {
    try {
      final response = await _client.get(ApiEndpoints.salesToday);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('SaleRemoteRepository.getSalesToday error: $e');
      return [];
    }
  }
}
