import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/loginScreen.dart';
import 'package:origin/signupscreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();


}
class InitState extends State<SignUpScreen>{

  final formkey = GlobalKey<FormState>();

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
                        "Register",
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
              margin: EdgeInsets.only(left: 20,right: 20, top: 22),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      return 'Enter your email address';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
                  }


              )),

            Container(
              margin: EdgeInsets.only(left: 20,right: 20, top: 20),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: pass,
                obscureText: isObscure,
                cursorColor: Color(0xFFFFB300),
                decoration: InputDecoration(
                    hintText: "Enter your password",
                  icon: Icon(
                    Icons.lock,
                    color: Color(0xFFFFB300),
                  ),

                    suffixIcon: IconButton(

                        focusColor: Color(0xFFFFB300),

                        icon: Icon(isObscure ? Icons.visibility :Icons.visibility_off),
                        color: Colors.amber,
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
                  labelText: "Enter your password",
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
                    RegExp regex =
                    RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password';
                      } else {
                        return null;
                      }
                    }
                  }),
            ),

            Container(
              margin: EdgeInsets.only(left: 20,right: 20, top: 25),
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
              child:TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: isObscure,
                cursorColor: Color(0xFFFFB300),
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  icon: Icon(
                    Icons.lock,
                    color: Color(0xFFFFB300),
                  ),
                    suffixIcon: IconButton(

                        focusColor: Color(0xFFFFB300),

                        icon: Icon(isObscure ? Icons.visibility :Icons.visibility_off),
                        color: Colors.amber,
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
                  labelText: "Enter your confirm password",
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
                    RegExp regex =
                    RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (value!.isEmpty) {
                      return 'Enter your confirm password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password';
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
                  try{
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailid.text.trim(), password: pass.text.trim());
                    if (userCredential != null)
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }

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
                margin: EdgeInsets.only(left: 50, right: 50, top: 35),
                padding: EdgeInsets.only(left: 20,right: 20),
                alignment: Alignment.center,
                height: 54,
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [(new Color(0xFFFFB300)), (new Color(0xFFFFB300))],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xFFFFB300)
                    )]
                ),
                child: Text
                  (
                  "SIGN UP",
                  style: TextStyle
                    (
                      color: Colors.black

                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already an user ?"),
                  SizedBox(
                    height: 30,
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context)
                    },
                    child: Text(
                      "Login Now",
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