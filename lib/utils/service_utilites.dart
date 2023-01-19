import 'package:flutter/material.dart';
import 'package:origin/model/responses/language.dart';
import 'package:origin/resources/assets_manager.dart';
import '../resources/color_manager.dart';
import 'package:origin/user_preferences/global_variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/styles_manager.dart';

class ServiceUtils {
  static printLog(String msg) {}

  static showErrorMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: getRegularStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade600,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
  }

  static showSuccessMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: getRegularStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
  }

  // languageList for Localization
  static List<Language> languageList = [
    Language(
        name: 'English',
        langCode: 'en',
        image: ImageAssets.englishIcon,
        isChecked: true),
    Language(
        name: 'Arabic',
        langCode: 'ar',
        image: ImageAssets.arabicIcon,
        isChecked: false)
  ];

  getHeaderWithBackArrowAndTitle(BuildContext context, String title,
      void Function() onBackClick, String lngCode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onBackClick,
          child: SizedBox(
            height: 21,
            width: 21,
            child: SvgPicture.asset(
              lngCode == LanguageCode.languageCodeArabic
                  ? ImageAssets.backMirrorArrowBlack
                  : ImageAssets.backArrowBlack,
              fit: BoxFit.fitHeight,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: getSemiBoldStyle(fontSize: 18.0, color: ColorManager.black),
        ),
      ],
    );
  }
}
