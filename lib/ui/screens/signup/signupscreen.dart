// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origin/resources/assets_manager.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/resources/string_manager.dart';
import 'package:origin/ui/validator.dart';
import 'package:origin/utils/common_utilites.dart';
import '../../../controller/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signupscreen';
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SigmupState();
}

class SigmupState extends State<SignUpScreen> {
  final Auth _auth = Auth();

  final formkey = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();
  final TextEditingController emailid = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController cnfpass = TextEditingController();

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
                      child: Text(
                        StringManager.Regtxt,
                        style:
                            TextStyle(fontSize: 20, color: ColorManager.white),
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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 22),
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                child: CommonUtilites.getTextEmailFormField(
                    email: username,
                    labelText: StringManager.vusername,
                    iconData: Icons.person,
                    colorBorder: ColorManager.darkPrimary,
                    colorIcon: ColorManager.darkPrimary,
                    validate: ((p0) => Validation.getUsernameValidation(p0)))),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 22),
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                child: CommonUtilites.getTextEmailFormField(
                    email: emailid,
                    labelText: StringManager.enemail,
                    iconData: Icons.mail,
                    colorBorder: ColorManager.darkPrimary,
                    colorIcon: ColorManager.darkPrimary,
                    validate: ((p0) => Validation.getEmailValidation(p0)))),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: CommonUtilites.getTextpassFormField(
                password: pass,
                labelText: StringManager.labelpass,
                iconData: Icons.lock,
                isObscure: isObscure,
                onTap: () {
                  setState(() {
                    //refresh UI
                    if (isObscure) {
                      //if passenable == true, make it false
                      isObscure = false;
                    } else {
                      isObscure = true; //if passenable == false, make it true
                    }
                  });
                },
                colorBorder: ColorManager.darkPrimary,
                colorIcon: ColorManager.darkPrimary,
                validate: ((p0) => Validation.getPasswordValidation(p0)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
              padding: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: CommonUtilites.getTextpassFormField(
                password: pass,
                labelText: StringManager.labelpass,
                iconData: Icons.lock,
                isObscure: isObscure,
                onTap: () {
                  setState(() {
                    //refresh UI
                    if (isObscure) {
                      //if passenable == true, make it false
                      isObscure = false;
                    } else {
                      isObscure = true; //if passenable == false, make it true
                    }
                  });
                },
                colorBorder: ColorManager.darkPrimary,
                colorIcon: ColorManager.darkPrimary,
                validate: ((p0) =>
                    Validation.getConfirmPassValidations(p0, pass.text)),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (formkey.currentState!.validate()) {
                  await _auth.SignUp(
                      emailid: emailid.text,
                      username: username.text,
                      pass: pass.text,
                      context: context);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 50, right: 50, top: 35),
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                height: 54,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorManager.darkPrimary,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: ColorManager.darkPrimary)
                    ]),
                child: Text(
                  StringManager.signup,
                  style: TextStyle(color: ColorManager.white),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(StringManager.Alreadyusr),
                  const SizedBox(
                    height: 30,
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: const Text(
                      StringManager.loginin,
                      style: TextStyle(color: Color(0xFF000000)),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
