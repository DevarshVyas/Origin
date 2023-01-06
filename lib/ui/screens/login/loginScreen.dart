import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:origin/controller/auth_provider.dart';
import 'package:origin/resources/assets_manager.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/resources/string_manager.dart';
import 'package:origin/ui/screens/login/reset_password.dart';
import 'package:origin/ui/screens/signup/signupscreen.dart';
import 'package:origin/utils/common_utilites.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

@override
class InitState extends State<LoginScreen>
{
  // ignore: prefer_final_fields



  Auth _auth = Auth();

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
                            color: Colors.black,
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
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailidcontroller,
                      cursorColor: ColorManager.darkPrimary,
                      decoration: CommonUtilites.getTextInputDecor(StringManager.enemail, Icons.email, colorIcon: ColorManager.darkPrimary, colorBorder: ColorManager.darkPrimary),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return StringManager.enemail;
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return StringManager.vemail;
                        }
                        // Return null if the entered email is valid
                        return null;
                      })),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passcontroller,
                      obscureText: _isObscure,
                      cursorColor: ColorManager.darkPrimary,
                      decoration: CommonUtilites.getTextInputDecorPass(StringManager.labelpass, Icons.lock,
                          isLocked: _isObscure,colorBorder: ColorManager.darkPrimary,colorIcon: ColorManager.darkPrimary,(){
                            setState(() {
                              //refresh UI
                              if (_isObscure) {
                                //if passenable == true, make it false
                                _isObscure = false;
                              } else {
                                _isObscure =
                                true; //if passenable == false, make it true
                              }
                            });
                                }),
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                        if (value!.isEmpty) {
                          return StringManager.labelpass;
                        } else {
                          if (!regex.hasMatch(value)) {
                            return StringManager.vpass;
                          } else {
                            return null;
                          }
                        }
                      })),
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

