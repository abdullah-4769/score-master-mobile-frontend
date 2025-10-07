import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationService {
  static const String defaultLangCode = 'en';
  static const String defaultCountryCode = 'US';

  Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language_code') ?? defaultLangCode;
    final countryCode = prefs.getString('country_code') ?? defaultCountryCode;
    return Locale(langCode, countryCode);
  }

  static Future<void> saveLocale(String langCode, String countryCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
    await prefs.setString('country_code', countryCode);
  }

  static Future<void> changeLocale(String langCode, String countryCode) async {
    await Get.updateLocale(Locale(langCode, countryCode));
    await saveLocale(langCode, countryCode);
  }
}
