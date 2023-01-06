import 'package:flutter/material.dart';
import 'package:origin/resources/assets_manager.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/resources/string_manager.dart';
import 'package:origin/utils/common_utilites.dart';
import '../../../controller/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();


}
class InitState extends State<SignUpScreen>{

  Auth _auth = Auth();

  final formkey = GlobalKey<FormState>();


  final TextEditingController username = TextEditingController();
  final TextEditingController emailid = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController cnfpass = TextEditingController();

  bool isObscure= false;


  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Form(
      key: formkey,
      child: Scaffold
        (
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: ColorManager.darkPrimary
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
                          child: Text(
                            StringManager.Regtxt,
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorManager.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20, top: 70),
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: const [BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)
                    )],
                  ),
                  alignment: Alignment.center,
                ),

                Container(
                    margin: const EdgeInsets.only(left: 20,right: 20, top: 22),
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    alignment: Alignment.center,
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: username,
                        cursorColor: ColorManager.darkPrimary,
                        decoration:
                        CommonUtilites.getTextInputDecor(StringManager.username, Icons.person_add,colorBorder: ColorManager.darkPrimary, colorIcon: ColorManager.darkPrimary),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return StringManager.username;
                          }
                          // Check if the entered email has the right format
                          // Return null if the entered email is valid
                          return null;
                        }
                    )),


                Container(
                    margin: const EdgeInsets.only(left: 20,right: 20, top: 22),
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    alignment: Alignment.center,
                    child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailid,
                        cursorColor: ColorManager.darkPrimary,
                        decoration:
                        CommonUtilites.getTextInputDecor(StringManager.enemail, Icons.email,colorBorder: ColorManager.darkPrimary, colorIcon: ColorManager.darkPrimary),
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
                        }
                    )),

                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.center,
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: pass,
                      obscureText: isObscure,
                      cursorColor: ColorManager.darkPrimary,
                      decoration: CommonUtilites.getTextInputDecorPass(StringManager.labelpass, Icons.lock,
                          isLocked: isObscure,colorBorder: ColorManager.darkPrimary,colorIcon: ColorManager.darkPrimary,(){
                            setState(() {
                              //refresh UI
                              if (isObscure) {
                                //if passenable == true, make it false
                                isObscure = false;
                              } else {
                                isObscure =
                                true; //if passenable == false, make it true
                              }
                            });
                          }),
                      validator: (value) {
                        RegExp regex =
                        RegExp(
                            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
                        if (value!.isEmpty) {
                          return StringManager.labelpass;
                        } else {
                          if (!regex.hasMatch(value)) {
                            return StringManager.vpass;
                          } else {
                            return null;
                          }
                        }
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20, top: 25),
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.center,
                  child:TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: isObscure,
                      cursorColor: ColorManager.darkPrimary,
                      decoration:
                      InputDecoration(
                        hintText: StringManager.hintcnf,
                        icon: Icon(
                          Icons.lock,
                          color: ColorManager.darkPrimary,
                        ),
                        suffixIcon: IconButton(

                            focusColor: ColorManager.darkPrimary,

                            icon: Icon(isObscure ? Icons.visibility :Icons.visibility_off),
                            color:  ColorManager.darkPrimary,
                            onPressed: () {
                              setState(() { //refresh UI
                                if(isObscure){ //if passenable == true, make it false
                                  isObscure = false;
                                }else{
                                  isObscure = true; //if passenable == false, make it true
                                }
                              });
                            }
                        ),
                        labelText: StringManager.cnfpass,
                        enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                                color:  ColorManager.darkPrimary
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:  ColorManager.darkPrimary
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:  ColorManager.darkPrimary
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),

                      ),
                      validator: (value) {
                        RegExp regex =
                        RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (value!.isEmpty) {
                          return StringManager.cnfpass;
                        } else {
                          if (!regex.hasMatch(value)) {
                            return StringManager.vpass;
                          } else {
                            return null;
                          }
                        }
                      }  ),
                ),

                GestureDetector
                  (
                  onTap: () async{
                    if(formkey.currentState!.validate()){
                      await _auth.SignUp( emailid: emailid.text,username:username.text, pass: pass.text, context: context);
                    }
                  },
                  child: Container
                    (
                    margin: const EdgeInsets.only(left: 50, right: 50, top: 35),
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    alignment: Alignment.center,
                    height: 54,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:  ColorManager.darkPrimary,
                        boxShadow:  [BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color:  ColorManager.darkPrimary
                        )]
                    ),
                    child:  Text
                      (
                      StringManager.signup,
                      style: TextStyle
                        (
                          color: ColorManager.white
                      ),
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
                        onTap: () => {
                          Navigator.pop(context)
                        },
                        child: const Text( StringManager.loginin,
                          style: TextStyle(
                              color: Color(0xFF000000)
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }


}