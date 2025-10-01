import 'package:get/get.dart';

class ResponsiveFont {
  
  // Default font sizes
  static const double defaultFontSize = 14;
  static const double smallFontSize = 10;

  // Languages that need smaller font
  static const List<String> smallFontLanguages = ['fr', 'es', 'de', 'it', 'ar', 'af'];

  // Get responsive font size (uses default 14 / 10)
  static double getFontSize() {
    return smallFontLanguages.contains(Get.locale?.languageCode) ? smallFontSize : defaultFontSize;
  }

  // Get responsive font size with optional custom sizes
  static double getFontSizeCustom({double defaultSize = defaultFontSize, double smallSize = smallFontSize}) {
    return smallFontLanguages.contains(Get.locale?.languageCode) ? smallSize : defaultSize;
  }
}
