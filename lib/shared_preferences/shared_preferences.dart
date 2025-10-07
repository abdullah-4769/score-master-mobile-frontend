

// lib/shared_preferences/shared_preferences.dart

import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  // === Preference Keys ===
  static const String _keyUserId = 'userId';
  static const String _keyUserProfile = 'userProfile';
  static const String _keyAuthToken = 'auth_token';
  static const String _keyUserName = 'user_name';
  static const String _keyUserRole = 'user_role';
  static const String _keySessionId = 'session_id';
  static const String _keyGameId = 'gameFormatId'; // updated key name
  static const String _keyTeamId = 'team_id';

  // === User ID Methods ===
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


  // === User Profile Methods ===
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

  // === Auth Token Methods ===
  static Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAuthToken, token);
    log('[SharedPref] Saved token: $token');
  }

  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_keyAuthToken);
    log('ℹ [SharedPref] Fetched token: $token');
    return token;
  }

  // === User Name Methods ===
  static Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    log('[SharedPref] Saved userName: $name');
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyUserName);
    log('ℹ [SharedPref] Fetched userName: $name');
    return name;
  }

  // === User Role Methods ===
  static Future<void> setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserRole, role);
    log('[SharedPref] Saved userRole: $role');
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString(_keyUserRole);
    log('ℹ [SharedPref] Fetched userRole: $role');
    return role;
  }

  // === Session ID Methods ===
  static Future<void> saveSessionId(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySessionId, sessionId);
    log('[SharedPref] Saved sessionId: $sessionId');
  }

  static Future<int?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionId = prefs.getInt(_keySessionId);
    log('ℹ [SharedPref] Fetched sessionId: $sessionId');
    return sessionId;
  }

  static Future<void> clearSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySessionId);
    log('[SharedPref] Cleared sessionId');
  }

  // === Game Format ID Methods ===
  static Future<void> saveGameId(int gameFormatId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGameId, gameFormatId);
    log('[SharedPref] Saved gameFormatId: $gameFormatId');
  }

  static Future<int?> getGameId() async {
    final prefs = await SharedPreferences.getInstance();
    final gameId = prefs.getInt(_keyGameId);
    log('ℹ [SharedPref] Fetched gameFormatId: $gameId');
    return gameId;
  }

  static Future<void> clearGameId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyGameId);
    log('[SharedPref] Cleared gameFormatId');
  }

  // === Team ID Methods ===
  static Future<void> saveTeamId(int teamId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTeamId, teamId);
    log('[SharedPref] Saved teamId: $teamId');
  }

  static Future<int?> getTeamId() async {
    final prefs = await SharedPreferences.getInstance();
    final teamId = prefs.getInt(_keyTeamId);
    log('ℹ [SharedPref] Fetched teamId: $teamId');
    return teamId;
  }

  static Future<void> clearTeamId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyTeamId);
    log('[SharedPref] Cleared teamId');
  }

  // === Clear All Data ===
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserProfile);
    await prefs.remove(_keyAuthToken);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserRole);
    await prefs.remove(_keySessionId);
    await prefs.remove(_keyGameId);
    await prefs.remove(_keyTeamId);
    log('[SharedPref] Cleared all user data');
  }
}
