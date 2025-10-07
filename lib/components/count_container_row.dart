import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';

class CountController extends GetxController {
  final RxInt count = 0.obs;
  final RxInt minValue;
  final RxInt maxValue;

  CountController({int initialValue = 0, int min = 0, int max = 99})
      : minValue = RxInt(min), maxValue = RxInt(max) {
    count.value = initialValue.clamp(min, max);
  }

  void increment() {
    if (count.value < maxValue.value) {
      count.value++;
    }
  }

  void decrement() {
    if (count.value > minValue.value) {
      count.value--;
    }
  }

  void reset() {
    count.value = minValue.value;
  }

  void setValue(int value) {
    count.value = value.clamp(minValue.value, maxValue.value);
  }

  bool get canIncrement => count.value < maxValue.value;
  bool get canDecrement => count.value > minValue.value;
}

class CountContainerRow extends StatelessWidget {
  final double scaleFactor;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final Function(int)? onCountChanged;

  const CountContainerRow({
    super.key,
    required this.scaleFactor,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 99,
    this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    final CountController controller = Get.put(
      CountController(
        initialValue: initialValue,
        min: minValue,
        max: maxValue,
      ),
      tag: _getUniqueTag(),
    );

    // Listen for count changes and call callback
    ever(controller.count, (value) {
      onCountChanged?.call(value);
    });

    return _buildResponsiveLayout(context, controller);
  }

  String _getUniqueTag() {
    return 'CountController_${initialValue}_${minValue}_${maxValue}';
  }

  Widget _buildResponsiveLayout(BuildContext context, CountController controller) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final padding = mediaQuery.padding;

    // Responsive scaling based on screen size
    final double responsiveScale = _getResponsiveScale(screenWidth, screenHeight);
    final double actualScale = scaleFactor * responsiveScale;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: _getContainerHeight(screenHeight, actualScale),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Decrement Button
              _buildDecrementButton(controller, actualScale, maxWidth),

              // Count Display
              _buildCountDisplay(controller, actualScale, maxWidth),

              // Increment Button
              _buildIncrementButton(controller, actualScale, maxWidth),
            ],
          ),
        );
      },
    );
  }

  double _getResponsiveScale(double screenWidth, double screenHeight) {
    if (screenWidth < 360) return 0.8; // Small mobile
    if (screenWidth < 400) return 0.9; // Medium mobile
    if (screenWidth < 600) return 1.0; // Large mobile
    if (screenWidth < 900) return 1.1; // Tablet
    if (screenWidth < 1200) return 1.2; // Small desktop
    if (screenWidth < 1800) return 1.3; // Large desktop
    return 1.4; // Ultra-wide
  }

  double _getContainerHeight(double screenHeight, double actualScale) {
    final baseHeight = 116 * actualScale;
    final maxHeight = screenHeight * 0.15; // Maximum 15% of screen height

    return baseHeight > maxHeight ? maxHeight : baseHeight;
  }

  Widget _buildDecrementButton(CountController controller, double actualScale, double maxWidth) {
    return Obx(() {
      final isEnabled = controller.canDecrement;
      final buttonWidth = maxWidth * 0.3; // 30% of available width

      return Expanded(
        child: GestureDetector(
          onTap: isEnabled ? controller.decrement : null,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 116 * actualScale,
            margin: EdgeInsets.symmetric(horizontal: 4 * actualScale),
            decoration: BoxDecoration(
              color: isEnabled ? AppColors.forwardColor : AppColors.forwardColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24 * actualScale),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 13 * actualScale,
                backgroundColor: isEnabled ? AppColors.whiteColor : AppColors.whiteColor.withOpacity(0.3),
                child: Icon(
                  Icons.remove,
                  color: isEnabled ? AppColors.forwardColor : AppColors.forwardColor.withOpacity(0.5),
                  size: _getIconSize(actualScale),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCountDisplay(CountController controller, double actualScale, double maxWidth) {
    return Expanded(
      child: SizedBox(
        height: 116 * actualScale,
        child: Obx(() => Center(
          child: BoldText(
            text: controller.count.value.toString().padLeft(2, '0'),
            fontSize: _getFontSize(actualScale, maxWidth),
            selectionColor: AppColors.blueColor,
            textAlign: TextAlign.center,
          ),
        )),
      ),
    );
  }

  Widget _buildIncrementButton(CountController controller, double actualScale, double maxWidth) {
    return Obx(() {
      final isEnabled = controller.canIncrement;
      final buttonWidth = maxWidth * 0.3; // 30% of available width

      return Expanded(
        child: GestureDetector(
          onTap: isEnabled ? controller.increment : null,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 116 * actualScale,
            margin: EdgeInsets.symmetric(horizontal: 4 * actualScale),
            decoration: BoxDecoration(
              color: isEnabled ? AppColors.forwardColor : AppColors.forwardColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24 * actualScale),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 13 * actualScale,
                backgroundColor: isEnabled ? AppColors.whiteColor : AppColors.whiteColor.withOpacity(0.3),
                child: Icon(
                  Icons.add,
                  color: isEnabled ? AppColors.forwardColor : AppColors.forwardColor.withOpacity(0.5),
                  size: _getIconSize(actualScale),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  double _getIconContainerSize(double actualScale, double maxWidth) {
    final baseSize = 36.5 * actualScale;
    final maxSize = maxWidth * 0.2; // Maximum 20% of button width
    return baseSize > maxSize ? maxSize : baseSize;
  }

  double _getIconSize(double actualScale) {
    return 24 * actualScale;
  }

  double _getFontSize(double actualScale, double maxWidth) {
    final baseFontSize = 40 * actualScale;
    final maxFontSize = maxWidth * 0.15; // Maximum 15% of available width
    return baseFontSize > maxFontSize ? maxFontSize : baseFontSize;
  }
}

// Usage example with additional features
class CountContainerRowWithLabel extends StatelessWidget {
  final String label;
  final double scaleFactor;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final Function(int)? onCountChanged;

  const CountContainerRowWithLabel({
    super.key,
    required this.label,
    required this.scaleFactor,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 99,
    this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16 * scaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8 * scaleFactor),
        CountContainerRow(
          scaleFactor: scaleFactor,
          initialValue: initialValue,
          minValue: minValue,
          maxValue: maxValue,
          onCountChanged: onCountChanged,
        ),
      ],
    );
  }
}