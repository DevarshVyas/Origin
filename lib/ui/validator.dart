// ignore_for_file: body_might_complete_normally_nullable

import '../resources/string_manager.dart';

class Validation {
  static String? getUsernameValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringManager.vusername;
    }
    // Return null if the entered email is valid
    return null;
  }
  static String? getEmailValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringManager.enemail;
    }
    // Check if the entered email has the right format
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return StringManager.vemail;
    }
    // Return null if the entered email is valid
    return null;
  }
  static String? getPasswordValidation(String? value) {
    if (value!.isEmpty) {
      return StringManager.labelpass;
    }
    if (value.length < 6) {
      return StringManager.labelpass;
    }
    if (value.length > 20) {
      return StringManager.loginpass;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return StringManager.labelpass;
    }
  }
  static String? getConfirmPassValidations(String? value, String pass) {
    if (value != pass) {
      return StringManager.cnfpass;
    } else {
      return null;
    }
  }
}