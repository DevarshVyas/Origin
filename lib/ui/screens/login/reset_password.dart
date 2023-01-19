// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/resources/string_manager.dart';
import '../../../controller/auth_provider.dart';
import '../../../resources/assets_manager.dart';
import '../../../utils/common_utilites.dart';

class ResetPasswrod extends StatefulWidget {
  static const String id = 'resetpass';
  const ResetPasswrod({super.key});
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ResetPasswrod> {
  final Auth _auth = Auth();
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailid = TextEditingController();
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Form(
      key: formkey,
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: ColorManager.darkPrimary),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 90,
                      width: 90,
                      child: Image.asset(ImageAssets.splashLogo),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, top: 20),
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        StringManager.resetpass,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 42),
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                child: TextFormField(
                    controller: emailid,
                    cursorColor: ColorManager.darkPrimary,
                    decoration: CommonUtilites.getTextInputDecor(
                        StringManager.enemail, Icons.email,
                        colorIcon: ColorManager.darkPrimary,
                        colorBorder: ColorManager.darkPrimary),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return StringManager.labelemail;
                      }
                      // Check if the entered email has the right format
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return StringManager.vemail;
                      }
                      // Return null if the entered email is valid
                      return null;
                    })),
            GestureDetector(
              onTap: () async {
                if (formkey.currentState!.validate()) {
                  await _auth.ResetPasss(
                    emailid: emailid.text,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 60, right: 60, top: 25),
                padding: const EdgeInsets.only(left: 40, right: 40),
                alignment: Alignment.center,
                height: 44,
                decoration: BoxDecoration(
                    color: ColorManager.darkPrimary,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 8),
                          blurRadius: 30,
                          color: ColorManager.darkPrimary)
                    ]),
                child: const Text(
                  StringManager.resetpass,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
