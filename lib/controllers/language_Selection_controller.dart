// import 'package:get/get.dart';

// class LanguageSelectionController extends GetxController {
//   final selectLangauge = (-1).obs; // default -1

//   void select(int index) {
//     selectLangauge.value = index; // ✅ .value se update karna hoga
//   }
// }
import 'package:get/get.dart';
import 'package:scorer/localization/translation_Service.dart';
// import 'translation_service.dart';

class LanguageSelectionController extends GetxController {
  var selectLangauge = 0.obs;

  // Map index to language code + country code
  final languages = [
    {'lang': 'en', 'country': 'US'},
    {'lang': 'es', 'country': 'ES'},
    {'lang': 'fr', 'country': 'FR'},
    {'lang': 'de', 'country': 'DE'},
    {'lang': 'it', 'country': 'IT'},
    {'lang': 'ar', 'country': 'AR'},
    // Agar African add karna ho
    {'lang': 'af', 'country': 'ZA'},
  ];

  void select(int index) {
    selectLangauge.value = index;

    // Change locale using TranslationService
    final langCode = languages[index]['lang']!;
    final countryCode = languages[index]['country']!;
    TranslationService.changeLocale(langCode, countryCode);
  }
}
