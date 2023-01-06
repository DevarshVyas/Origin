import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:origin/dashboard.dart';
import 'package:origin/reset_password.dart';
import 'signupscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class InitState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController emailidcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  bool _isObscure = false;

  String userEmail = "";

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
                    color: Colors.amber,
                    gradient: LinearGradient(
                        colors: [
                          (new Color(0xFFFFB300)),
                          (new Color(0xFFFFB300))
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
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
                          "Login",
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
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(50),
                  //   color: Colors.grey[200],
                  //   boxShadow: [
                  //     BoxShadow(
                  //         offset: Offset(0, 10),
                  //         blurRadius: 50,
                  //         color: Color(0xffEEEEEE))
                  //   ],
                  // ),
                  alignment: Alignment.center,
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailidcontroller,
                      cursorColor: Color(0xFFFFB300),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email_rounded,
                          color: Color(0xFFFFB300),
                        ),
                        labelText: "Enter Email",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(10.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // Return null if the entered email is valid
                        return null;
                      })),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(50),
                  //   color: Colors.grey[200],
                  //   boxShadow: [
                  //     BoxShadow(
                  //         offset: Offset(0, 10),
                  //         blurRadius: 50,
                  //         color: Color(0xffEEEEEE))
                  //   ],
                  // ),
                  alignment: Alignment.center,
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passcontroller,
                      obscureText: _isObscure,
                      cursorColor: Color(0xFFFFB300),
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        icon: Icon(
                          Icons.lock,
                          color: Color(0xFFFFB300),
                        ),
                        suffixIcon: IconButton(
                            focusColor: Color(0xFFFFB300),
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Colors.amber,
                            onPressed: () {
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
                        labelText: "Enter your password",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(10.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        } else {
                          if (!regex.hasMatch(value!)) {
                            return 'Enter valid password';
                          } else {
                            return null;
                          }
                        }
                      })),
              Container(
                margin: EdgeInsets.only(top: 20, right: 20),
                alignment: Alignment.centerRight,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: GestureDetector(
                  child: Text("Forgot Password?"),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswrod())),
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: emailidcontroller.text.trim(),
                              password: passcontroller.text.trim());
                      if (userCredential != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User Not Found')));
                      }
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 50, right: 50, top: 40),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                        colors: [
                          (new Color(0xFFFFB300)),
                          (new Color(0xFFFFB300))
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 8),
                            blurRadius: 30,
                            color: Color(0xFFFFB300))
                      ]),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?"),
                    SizedBox(
                      height: 30,
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()))
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(color: Color(0xFF000000)),
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  await signInWithGoogle();

                  setState(() {});
                },
                icon: Image.asset(
                  'assets/google.png',
                  height: 42,
                  width: 52,
                ),
//testing
                label: Text('Sign in with Google'),
                backgroundColor: Colors.amber,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    userEmail = googleUser!.email;

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
///////