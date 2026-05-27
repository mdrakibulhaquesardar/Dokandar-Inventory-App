import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class ExpenseRemoteRepository {
  final _client = ApiClient.instance;

  Future<List<Map<String, dynamic>>> getAllExpenses() async {
    try {
      final response = await _client.get(ApiEndpoints.expenses);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('ExpenseRemoteRepository.getAllExpenses error: $e');
      return [];
    }
  }

  Future<bool> createExpense(Map<String, dynamic> expenseData) async {
    try {
      final response = await _client.post(
        ApiEndpoints.expenses,
        data: expenseData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('ExpenseRemoteRepository.createExpense error: $e');
      return false;
    }
  }

  Future<bool> updateExpense(
    String id,
    Map<String, dynamic> expenseData,
  ) async {
    try {
      final response = await _client.put(
        ApiEndpoints.expenseById(id),
        data: expenseData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('ExpenseRemoteRepository.updateExpense error: $e');
      return false;
    }
  }

  Future<bool> deleteExpense(String id) async {
    try {
      final response = await _client.delete(ApiEndpoints.expenseById(id));
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('ExpenseRemoteRepository.deleteExpense error: $e');
      return false;
    }
  }
}
