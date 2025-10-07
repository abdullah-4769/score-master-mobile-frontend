import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/filter_useable_container.dart';

class AdditionalSettingColumn extends StatelessWidget {
  const AdditionalSettingColumn({
    super.key,
    required this.scaleFactor,
    required this.widthScaleFactor,
  });

  final double scaleFactor;
  final double widthScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
                                
    BoldText(
      text: "additional_settings".tr,
      selectionColor: AppColors.blueColor,
      fontSize: 16 * scaleFactor,
    ),
                          SizedBox(height: 20 * scaleFactor),
    FilterUseableContainer(
       fontSze: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 12*widthScaleFactor
    
    
                          ),
      isSelected: true, text: 'allow_late_joiners'.tr, onTap: () {}),
                          SizedBox(height: 10 * scaleFactor),
    FilterUseableContainer(
       fontSze: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 12*widthScaleFactor
    
    
                          ),
      isSelected: false, text: 'send_email_invitations'.tr, onTap: () {}),
                          SizedBox(height: 10 * scaleFactor),
                         FilterUseableContainer(
                          fontSze: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 12*widthScaleFactor
    
    
                          ),
                          isSelected: false, text: 'record_session_review'.tr, onTap: () {}),
    
          ],
        );
  }
}