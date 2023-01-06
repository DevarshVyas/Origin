import 'package:flutter/material.dart';
import 'package:origin/ui/screens/home/dashboard.dart';

class Home extends StatelessWidget {
  const Home({Key? key})  : super(key: key);
  @override
  Widget build(BuildContext context) {

    ListView listView = ListView();




    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const[
          Text('Home Page', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          SizedBox(height: 100,),
          Text('Home Page content', style: TextStyle(fontSize: 30, color: Colors.white),),
        ],
      ),
    );
  }
  
}