import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../../routes/app_pages.dart';

/// GetX service that manages remote authentication state.
/// Tokens are persisted in flutter_secure_storage (hardware-backed keystore).
class AuthService extends GetxService {
  static AuthService get instance => Get.find<AuthService>();

  final _storage = const FlutterSecureStorage();

  final RxBool isLoggedIn = false.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userId = ''.obs;
  final RxString storeId = ''.obs;

  /// Call once during app startup.
  Future<AuthService> init() async {
    await _checkLoginStatus();
    return this;
  }

  // ── Public API ──────────────────────────────────────────────────────────────

  Future<bool> login(String email, String password) async {
    try {
      final response = await ApiClient.instance.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      final body = response.data;
      if (body != null && body['success'] == true) {
        final data = body['data'] as Map<String, dynamic>;
        await _saveTokens(
          data['accessToken'] as String,
          data['refreshToken'] as String,
        );
        await _saveUserData(data['user'] as Map<String, dynamic>);
        isLoggedIn.value = true;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String storeName,
    required String storeAddress,
    required String storePhone,
    required String businessType,
  }) async {
    try {
      final response = await ApiClient.instance.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'storeName': storeName,
          'storeAddress': storeAddress,
          'storePhone': storePhone,
          'businessType': businessType,
        },
      );
      final body = response.data;
      if (body != null && body['success'] == true) {
        final data = body['data'] as Map<String, dynamic>;
        await _saveTokens(
          data['accessToken'] as String,
          data['refreshToken'] as String,
        );
        await _saveUserData(data['user'] as Map<String, dynamic>);
        isLoggedIn.value = true;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> refreshToken() async {
    try {
      final rt = await _storage.read(key: 'refresh_token');
      if (rt == null) return false;

      final response = await ApiClient.instance.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {'refreshToken': rt},
      );
      final body = response.data;
      if (body != null && body['success'] == true) {
        final data = body['data'] as Map<String, dynamic>;
        await _saveTokens(
          data['accessToken'] as String,
          data['refreshToken'] as String,
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final rt = await _storage.read(key: 'refresh_token');
      await ApiClient.instance.post(
        ApiEndpoints.logout,
        data: {'refreshToken': rt},
      );
    } catch (_) {}

    await _storage.deleteAll();
    isLoggedIn.value = false;
    userName.value = '';
    userEmail.value = '';
    userId.value = '';
    storeId.value = '';
    Get.offAllNamed(Routes.LOGIN);
  }

  // ── Private helpers ─────────────────────────────────────────────────────────

  Future<void> _checkLoginStatus() async {
    final token = await _storage.read(key: 'access_token');
    isLoggedIn.value = token != null;
    if (isLoggedIn.value) {
      await _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    userName.value = await _storage.read(key: 'user_name') ?? '';
    userEmail.value = await _storage.read(key: 'user_email') ?? '';
    userId.value = await _storage.read(key: 'user_id') ?? '';
    storeId.value = await _storage.read(key: 'store_id') ?? '';
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> _saveUserData(Map<String, dynamic> user) async {
    final name = user['name']?.toString() ?? '';
    final email = user['email']?.toString() ?? '';
    final id = user['id']?.toString() ?? '';
    final store = user['storeId']?.toString() ?? '';

    await _storage.write(key: 'user_name', value: name);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_id', value: id);
    await _storage.write(key: 'store_id', value: store);

    userName.value = name;
    userEmail.value = email;
    userId.value = id;
    storeId.value = store;
  }
}
