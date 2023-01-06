

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/resources/string_manager.dart';
import 'package:origin/ui/screens/home/dashboard.dart';

import 'package:origin/ui/screens/login/loginScreen.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user != null) {
         if(mounted){
           Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                 builder: (context) => Dashboard(),
               ));
         }
        } else {
          if(mounted){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          }
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorManager.darkPrimary
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,

              ),
              SpinKitWave(
                itemBuilder: (BuildContext context, int index){
                  return DecoratedBox(decoration: BoxDecoration(
                      color: index.isEven ? Colors.white : ColorManager.darkPrimary
                  ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(StringManager.origin),
      ),

    );
  }
}


