// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:origin/controller/auth_provider.dart';
import 'package:origin/resources/assets_manager.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/resources/string_manager.dart';
import 'package:origin/ui/screens/login/reset_password.dart';
import 'package:origin/ui/screens/signup/signupscreen.dart';
import 'package:origin/utils/common_utilites.dart';

import '../../validator.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';
  const LoginScreen({super.key});
  @override
  State<StatefulWidget> createState() => LoginState();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

@override
class LoginState extends State<LoginScreen> {
  // ignore: prefer_final_fields

  final Auth _auth = Auth();

  final formkey = GlobalKey<FormState>();

  final TextEditingController emailidcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  bool _isObscure = false;

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
                height: 300,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: ColorManager.darkPrimary,
                ),
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
                          StringManager.loginin,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  child: CommonUtilites.getTextEmailFormField(
                      email: emailidcontroller,
                      labelText: StringManager.enemail,
                      iconData: Icons.mail,
                      colorBorder: ColorManager.darkPrimary,
                      colorIcon: ColorManager.darkPrimary,
                      validate: ((p0) => Validation.getEmailValidation(p0)))
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  child: CommonUtilites.getTextpassFormField(
                    password: passcontroller,
                    labelText: StringManager.labelpass,
                    iconData: Icons.lock,
                    isObscure: _isObscure,
                    onTap: () {
                      setState(() {
                        //refresh UI
                        if (_isObscure) {
                          //if passenable == true, make it false
                          _isObscure = false;
                        } else {
                          _isObscure = true; //if passenable == false, make it true
                        }
                      });
                    },
                    colorBorder: ColorManager.darkPrimary,
                    colorIcon: ColorManager.darkPrimary,
                    validate: ((p0) => Validation.getPasswordValidation(p0)),
                  ),),
              Container(
                margin: const EdgeInsets.only(top: 20, right: 20),
                alignment: Alignment.centerRight,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: GestureDetector(
                  child: const Text(StringManager.forgotpass),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswrod())),
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    await _auth.Login(
                        email: emailidcontroller.text,
                        password: passcontroller.text,
                        context: context);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 50, right: 50, top: 40),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorManager.darkPrimary,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 8),
                            blurRadius: 30,
                            color: ColorManager.darkPrimary)
                      ]),
                  child: Text(
                    StringManager.loginin,
                    style: TextStyle(color: ColorManager.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(StringManager.account),
                    const SizedBox(
                      height: 30,
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()))
                      },
                      child: const Text(
                        StringManager.Regtxt,
                        style: TextStyle(color: Color(0xFF000000)),
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {});
                },
                icon: Image.asset(
                  ImageAssets.googleLogo,
                  height: 42,
                  width: 52,
                ),
                label: const Text(StringManager.signingoogle),
                backgroundColor: ColorManager.darkPrimary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
