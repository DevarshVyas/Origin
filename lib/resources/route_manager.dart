
import 'package:flutter/cupertino.dart';
import 'package:origin/ui/screens/home/Language/language_screen.dart';
import 'package:origin/ui/screens/home/dashboard.dart';
import 'package:origin/ui/screens/home/product_page.dart';
import 'package:origin/ui/screens/login/loginScreen.dart';
import 'package:origin/ui/screens/login/reset_password.dart';
import 'package:origin/ui/screens/signup/signupscreen.dart';
import 'package:origin/ui/screens/splash/splashScreen.dart';

final Map<String, WidgetBuilder> routes = {
  Dashboard.id: (context) => Dashboard(),
  LanguageScreen.id: (context) => LanguageScreen(),
  Splash.id: (context) => Splash(),
  SignUpScreen.id: (context) => SignUpScreen(),
  LoginScreen.id: (context) => LoginScreen(),
  ResetPasswrod.id: (context) => ResetPasswrod(),
  Home.id: (context) => Home(),
  Productpage.id: (context) => Productpage(title: '', wishid: '',),


};

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
