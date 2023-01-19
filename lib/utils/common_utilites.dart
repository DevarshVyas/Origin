import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/string_manager.dart';

class CommonUtilites {
  static Widget getTextEmailFormField(
      {required TextEditingController email,
      required String labelText,
      required IconData iconData,
      Color colorBorder = Colors.black,
      Color colorIcon = Colors.black,
      required String? Function(String?)? validate}) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: email,
        cursorColor: ColorManager.darkPrimary,
        decoration: CommonUtilites.getTextInputDecor(labelText, iconData,
            colorBorder: colorBorder, colorIcon: colorIcon),
        validator: validate);
  }

  static Widget getTextpassFormField(
      {required TextEditingController password,
      required String labelText,
      required IconData iconData,
      required bool isObscure,
      required Function onTap,
      Color colorBorder = Colors.black,
      Color colorIcon = Colors.black,
      required String? Function(String?)? validate}) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: password,
        obscureText: isObscure,
        cursorColor: ColorManager.darkPrimary,
        decoration:
            CommonUtilites.getTextInputDecorPass(labelText, iconData, onTap,colorIcon: colorIcon,colorBorder: colorBorder),
        validator: validate);
  }

  static getTextInputDecor(
    String labelText,
    IconData iconData, {
    Color colorBorder = Colors.black,
    Color colorIcon = Colors.black,
  }) {
    return InputDecoration(
      icon: Icon(iconData, color: colorIcon),
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorBorder,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorder),
          borderRadius: BorderRadius.circular(10.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorder),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  static getTextInputDecorPass(
      String labelTextpass, IconData iconData, Function onLockedClick,
      {Color colorBorder = Colors.black,
      Color colorIcon = Colors.black,
      bool isLocked = true}) {
    return InputDecoration(
      hintText: StringManager.loginpass,
      icon: Icon(
        iconData,
        color: colorIcon,
      ),
      labelText: labelTextpass,
      suffixIcon: IconButton(
          focusColor: ColorManager.darkPrimary,
          icon: Icon(isLocked ? Icons.visibility : Icons.visibility_off),
          color: ColorManager.darkPrimary,
          onPressed: () {
            onLockedClick();
          }),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.darkPrimary),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.darkPrimary),
          borderRadius: BorderRadius.circular(10.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.darkPrimary),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
