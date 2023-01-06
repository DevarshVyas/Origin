
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/ui/screens/login/loginScreen.dart';

import '../../resources/string_manager.dart';
import '../../user_preferences/user_preferences.dart';

class LogoutAlertDialog{
  static signoutalertdialog(BuildContext context){
    return  AlertDialog(
        backgroundColor: Colors.grey.shade200,
        title: const Text(StringManager.exit),
        actions: [
          TextButton(
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser !=
                    null) {
                  await FirebaseAuth.instance.signOut();

                }
                await UserPreferences.clearDetailsOnSignOut();
                print('Signout :   ${await UserPreferences.getUserEmail()}');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                        (route) => false);
              },
              child: const Text(StringManager.Yes)),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(StringManager.No))
        ]);
  }
}