import 'package:flutter/foundation.dart';
import '../../network/api_client.dart';
import '../../network/api_endpoints.dart';

class EmployeeRemoteRepository {
  final _client = ApiClient.instance;

  Future<List<Map<String, dynamic>>> getAllEmployees() async {
    try {
      final response = await _client.get(ApiEndpoints.employees);
      final body = response.data as Map<String, dynamic>?;
      if (body != null && body['success'] == true) {
        return List<Map<String, dynamic>>.from(
          body['data'] as List<dynamic>,
        );
      }
      return [];
    } catch (e) {
      debugPrint('EmployeeRemoteRepository.getAllEmployees error: $e');
      return [];
    }
  }

  Future<bool> createEmployee(Map<String, dynamic> employeeData) async {
    try {
      final response = await _client.post(
        ApiEndpoints.employees,
        data: employeeData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('EmployeeRemoteRepository.createEmployee error: $e');
      return false;
    }
  }

  Future<bool> updateEmployee(
    String id,
    Map<String, dynamic> employeeData,
  ) async {
    try {
      final response = await _client.put(
        ApiEndpoints.employeeById(id),
        data: employeeData,
      );
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('EmployeeRemoteRepository.updateEmployee error: $e');
      return false;
    }
  }

  Future<bool> deleteEmployee(String id) async {
    try {
      final response = await _client.delete(ApiEndpoints.employeeById(id));
      final body = response.data as Map<String, dynamic>?;
      return body?['success'] == true;
    } catch (e) {
      debugPrint('EmployeeRemoteRepository.deleteEmployee error: $e');
      return false;
    }
  }
}
