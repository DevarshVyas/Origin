// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/resources/string_manager.dart';
import 'package:origin/ui/dialogs/logut_dialog.dart';
import 'package:origin/ui/screens/home/Language/language_screen.dart';
import 'package:origin/ui/screens/home/pages/home.dart';
import 'package:origin/ui/screens/home/pages/vendor.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
  Dashboard({super.key});
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Dashboard> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;

  List<Widget> litems = [
    const Home(),
    Vendor(),
    const Center(
      child: Text(
        StringManager.list,
      ),
    ),
    const Center(
      child: Text(
        StringManager.categories,
      ),
    ),
    const Center(
      child: Text(
        StringManager.more,
      ),
    ),
  ];

  final items = const [
    Icon(
      Icons.home_filled,
      size: 30,
    ),
    Icon(
      Icons.person_pin,
      size: 30,
    ),
    Icon(
      Icons.list,
      size: 30,
    ),
    Icon(
      Icons.category,
      size: 30,
    ),
    Icon(
      Icons.more,
      size: 30,
    ),
  ];
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.header),
          backgroundColor: ColorManager.darkPrimary,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.location_on)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: litems[index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            unselectedItemColor: Colors.grey,
            fixedColor: ColorManager.darkPrimary,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt), label: 'Vendors'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment), label: 'Lists'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'More'),
            ]),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: ColorManager.darkPrimary,
                  ),
                  accountName: Text('$userName'),
                  accountEmail: Text('$userEmail')),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text(StringManager.payment),
                textColor: ColorManager.darkPrimary,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.home_filled),
                title: const Text(StringManager.address),
                textColor: ColorManager.darkPrimary,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(StringManager.house),
                textColor: ColorManager.darkPrimary,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text(StringManager.Language),
                textColor: ColorManager.darkPrimary,
                onTap: () {
                  Navigator.pushNamed(context,LanguageScreen.id);
                },
              ),
              ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text(StringManager.logout),
                  textColor: ColorManager.darkPrimary,
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return LogoutAlertDialog.signoutalertdialog(context);
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
