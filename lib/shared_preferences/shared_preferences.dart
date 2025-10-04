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
  static const String _keyGameId = 'game_id';
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
    return prefs.getString(_keyAuthToken);
  }

  // === User Name Methods ===
  static Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    log('[SharedPref] Saved userName: $name');
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // === User Role Methods ===
  static Future<void> setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserRole, role);
    log('[SharedPref] Saved userRole: $role');
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserRole);
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
    log('[SharedPref] Fetched sessionId: $sessionId');
    return sessionId;
  }

  // === Game ID Methods ===
  static Future<void> saveGameId(int gameId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGameId, gameId);
    log('[SharedPref] Saved gameId: $gameId');
  }

  static Future<int?> getGameId() async {
    final prefs = await SharedPreferences.getInstance();
    final gameId = prefs.getInt(_keyGameId);
    log('[SharedPref] Fetched gameId: $gameId');
    return gameId;
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
    log('[SharedPref] Fetched teamId: $teamId');
    return teamId;
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







// import 'dart:convert';
// import 'dart:developer';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefServices {
//   // Keys
//   static const String _keyUserId = 'userId';
//   static const String _keyUserProfile = 'userProfile';
//   static const String _keyAuthToken = 'auth_token';
//   static const String _keyUserName = 'user_name';
//   static const String _keyUserRole = 'user_role';
//   static const String _keySessionId = 'session_id'; // NEW
//
//   // Save User ID
//   static Future<void> saveUserId(int userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_keyUserId, userId);
//     log('[SharedPref] Saved userId: $userId');
//   }
//
//   static Future<int?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getInt(_keyUserId);
//     log('ℹ [SharedPref] Fetched userId: $userId');
//     return userId;
//   }
//
//   // Save User Profile (JSON)
//   static Future<void> saveUserProfile(Map<String, dynamic> profile) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonProfile = jsonEncode(profile);
//     await prefs.setString(_keyUserProfile, jsonProfile);
//     log('[SharedPref] Saved userProfile: $jsonProfile');
//   }
//
//   static Future<Map<String, dynamic>?> getUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final profileString = prefs.getString(_keyUserProfile);
//     log('[SharedPref] Fetched userProfile: $profileString');
//     return profileString != null ? jsonDecode(profileString) : null;
//   }
//
//   // Save Auth Token
//   static Future<void> setAuthToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyAuthToken, token);
//     log('[SharedPref] Saved token: $token');
//   }
//
//   static Future<String?> getAuthToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAuthToken);
//   }
//
//   // Save User Name
//   static Future<void> setUserName(String name) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserName, name);
//     log('[SharedPref] Saved userName: $name');
//   }
//
//   static Future<String?> getUserName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserName);
//   }
//
//   // Save User Role
//   static Future<void> setUserRole(String role) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserRole, role);
//     log('[SharedPref] Saved userRole: $role');
//   }
//
//   static Future<String?> getUserRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserRole);
//   }
//
//   // Save Session ID - NEW
//   static Future<void> saveSessionId(int sessionId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_keySessionId, sessionId);
//     log('[SharedPref] Saved sessionId: $sessionId');
//   }
//
//   static Future<int?> getSessionId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final sessionId = prefs.getInt(_keySessionId);
//     log('[SharedPref] Fetched sessionId: $sessionId');
//     return sessionId;
//   }
//
//   // Remove All
//   static Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUserId);
//     await prefs.remove(_keyUserProfile);
//     await prefs.remove(_keyAuthToken);
//     await prefs.remove(_keyUserName);
//     await prefs.remove(_keyUserRole);
//     await prefs.remove(_keySessionId); // NEW
//     log('[SharedPref] Cleared all user data');
//   }
// }

// import 'dart:convert';
// import 'dart:developer';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefServices {
//   // Keys
//   static const String _keyUserId = 'userId';
//   static const String _keyUserProfile = 'userProfile';
//   static const String _keyAuthToken = 'auth_token';
//   static const String _keyUserName = 'user_name';
//   static const String _keyUserRole = 'user_role';
//
//   // Save User ID
//   static Future<void> saveUserId(int userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_keyUserId, userId);
//     log('[SharedPref] Saved userId: $userId');
//   }
//
//   static Future<int?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getInt(_keyUserId);
//     log('ℹ [SharedPref] Fetched userId: $userId');
//     return userId;
//   }
//
//   // Save User Profile (JSON)
//   static Future<void> saveUserProfile(Map<String, dynamic> profile) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonProfile = jsonEncode(profile);
//     await prefs.setString(_keyUserProfile, jsonProfile);
//     log('[SharedPref] Saved userProfile: $jsonProfile');
//   }
//
//   static Future<Map<String, dynamic>?> getUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final profileString = prefs.getString(_keyUserProfile);
//     log('[SharedPref] Fetched userProfile: $profileString');
//     return profileString != null ? jsonDecode(profileString) : null;
//   }
//
//   // Save Auth Token
//   static Future<void> setAuthToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyAuthToken, token);
//     log('[SharedPref] Saved token: $token');
//   }
//
//   static Future<String?> getAuthToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAuthToken);
//   }
//
//   // Save User Name
//   static Future<void> setUserName(String name) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserName, name);
//     log('[SharedPref] Saved userName: $name');
//   }
//
//   static Future<String?> getUserName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserName);
//   }
//
//   // Save User Role
//   static Future<void> setUserRole(String role) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserRole, role);
//     log('[SharedPref] Saved userRole: $role');
//   }
//
//   static Future<String?> getUserRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserRole);
//   }
//
//   // Remove All
//   static Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUserId);
//     await prefs.remove(_keyUserProfile);
//     await prefs.remove(_keyAuthToken);
//     await prefs.remove(_keyUserName);
//     await prefs.remove(_keyUserRole);
//     log('[SharedPref] Cleared all user data');
//   }
//
//   //
//   // // In SharedPrefServices
//   // static Future<String?> getUserName() async {
//   //   final profile = await getUserProfile();
//   //   return profile?['name'];
//   // }
//
// }
