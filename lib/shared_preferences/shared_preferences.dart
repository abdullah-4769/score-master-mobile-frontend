import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  // Keys
  static const String _keyUserId = 'userId';
  static const String _keyUserProfile = 'userProfile';
  static const String _keyAuthToken = 'auth_token';
  static const String _keyUserName = 'user_name';
  static const String _keyUserRole = 'user_role';

  // Save User ID
  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, userId);
    log('[SharedPref] Saved userId: $userId');
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(_keyUserId);
    log('ℹ [SharedPref] Fetched userId: $userId');
    return userId;
  }

  // Save User Profile (JSON)
  static Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonProfile = jsonEncode(profile);
    await prefs.setString(_keyUserProfile, jsonProfile);
    log('[SharedPref] Saved userProfile: $jsonProfile');
  }

  static Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(_keyUserProfile);
    log('[SharedPref] Fetched userProfile: $profileString');
    return profileString != null ? jsonDecode(profileString) : null;
  }

  // Save Auth Token
  static Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAuthToken, token);
    log('[SharedPref] Saved token: $token');
  }

  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAuthToken);
  }

  // Save User Name
  static Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    log('[SharedPref] Saved userName: $name');
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // Save User Role
  static Future<void> setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserRole, role);
    log('[SharedPref] Saved userRole: $role');
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserRole);
  }

  // Remove All
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserProfile);
    await prefs.remove(_keyAuthToken);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserRole);
    log('[SharedPref] Cleared all user data');
  }

  //
  // // In SharedPrefServices
  // static Future<String?> getUserName() async {
  //   final profile = await getUserProfile();
  //   return profile?['name'];
  // }

}
