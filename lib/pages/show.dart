import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  const Display({Key? key})  : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const[
          Text('List Page', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          CircleAvatar(
            radius: 70,
            child: Icon(Icons.home_filled, size: 120,),
          ),
          SizedBox(height: 100,),
          Text('List Page content', style: TextStyle(fontSize: 30, color: Colors.white),),
        ],
      ),
    );
  }

}