import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/loginScreen.dart';
import 'package:origin/signupscreen.dart';

class ResetPasswrod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();


}
class InitState extends State<ResetPasswrod>{

  final formkey = GlobalKey<FormState>();

  final TextEditingController emailid = TextEditingController();


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
                    gradient: LinearGradient(
                        colors: [(new Color(0xFFFFB300)), (new Color(0xFFFFB300))],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Image.asset("assets/splash.png"),
                          height: 90,
                          width: 90,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, top: 20),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(left: 20,right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)
                    )],
                  ),
                  alignment: Alignment.center,
                ),

                Container(
                    margin: EdgeInsets.only(left: 20,right: 20, top: 42),
                    padding: EdgeInsets.only(left: 20,right: 20),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(50),
                    //   color: Colors.grey[200],
                    //   boxShadow: [BoxShadow(
                    //       offset: Offset(0, 10),
                    //       blurRadius: 50,
                    //       color: Color(0xffEEEEEE)
                    //   )],
                    // ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: emailid,
                      cursorColor: Color(0xFFFFB300),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email_rounded,
                          color: Color(0xFFFFB300),

                        ),
                        labelText: "Enter Your Email",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amber
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amber
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amber
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return ' Enter your email address';
                          }
                          // Check if the entered email has the right format
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          // Return null if the entered email is valid
                          return null;
                        }


                    )),

                GestureDetector
                  (
                  onTap: () async{
                    if(formkey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: emailid.text.trim(),);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }

                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User Not Found')));
                        }
                      }
                    }

                  },
                  child: Container
                    (
                    margin: EdgeInsets.only(left: 60, right: 60, top: 25),
                    padding: EdgeInsets.only(left: 40,right: 40),
                    alignment: Alignment.center,
                    height: 44,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [(new Color(0xFFFFB300)), (new Color(0xFFFFB300))],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [BoxShadow(
                            offset: Offset(0,8),
                            blurRadius: 30,
                            color: Color(0xFFFFB300)
                        )]
                    ),
                    child: Text
                      (
                      "Reset Password",
                      style: TextStyle
                        (
                          color: Colors.black

                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}