
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/main_text.dart';

class AccountInfoClumn extends StatelessWidget {
  const AccountInfoClumn({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor, this.text,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;
  final String?text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      BoldText(
                                            text: "account_information".tr,
    
        selectionColor: AppColors.blueColor,
        fontSize: 16 * widthScaleFactor,
      ),
      SizedBox(height: 20 * heightScaleFactor),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12 * widthScaleFactor),
        child: Container(
          height: 177 * heightScaleFactor,
          width: 376 * widthScaleFactor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24 * widthScaleFactor),
            border: Border.all(color: AppColors.greyColor, width: 1.5 * widthScaleFactor),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * widthScaleFactor),
            child: Column(
              children: [
                SizedBox(height: 15 * heightScaleFactor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainText(
                                                                                     text:  "email".tr,
    
                      
    
      fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 12*widthScaleFactor,
    
    ),
    
                    ),
                    BoldText(
                      text: "john.smith@company.com",
                      
    
     fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 12*widthScaleFactor,
    
    ),
                      selectionColor: AppColors.blueColor,
                    ),
                  ],
                ),
                SizedBox(height: 10 * heightScaleFactor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainText(
                                                                                      text:  "phone".tr,
    
                      
    
     fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 12*widthScaleFactor,
    
    ),
                    ),
                    BoldText(
                      text: "+1 (555) 987-6543",
                      
    
     fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 12*widthScaleFactor,
    
    ),
                      selectionColor: AppColors.blueColor,
                    ),
                  ],
                ),
                SizedBox(height: 10 * heightScaleFactor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainText(
                   text: "join_date".tr,
                      
    
     fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 12*widthScaleFactor,
    
    ),
                    ),
                    BoldText(
                      text: "September 8, 2024",
                      
    
     fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 12*widthScaleFactor,
    
    ),
                      selectionColor: AppColors.blueColor,
                    ),
                  ],
                ),
                SizedBox(height: 10 * heightScaleFactor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainText(
                      text: text?? "Facilitator Level",
                      
    
     fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 12*widthScaleFactor,
    
    ),
                    ),
                    CreateContainer(
                      text: "Level 3",
                      top: 7,
                      right: -19,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    
      ],
    );
  }
}