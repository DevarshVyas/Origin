import 'package:flutter/material.dart';

class Vendor extends StatelessWidget {
  const Vendor({Key? key})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const[
          Text('Vendor Page', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          CircleAvatar(
            radius: 70,
            child: Icon(Icons.person_pin, size: 120,),
          ),
          SizedBox(height: 100,),
          Text('Vendor Page content', style: TextStyle(fontSize: 30, color: Colors.white),),
        ],
      ),
    );
  }

}