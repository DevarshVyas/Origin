import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:origin/ui/screens/home/product_card.dart';
import 'package:origin/resources/assets_manager.dart';
import '../../../resources/color_manager.dart';

class Productpage extends StatefulWidget {
  Productpage({Key? key, required this.title, required this.wishid})
      : super(key: key);

  final String title;
  String wishid;
  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  final ref = FirebaseDatabase.instance.ref('product');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
                color: ColorManager.darkPrimary, fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorManager.darkPrimary,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.qr_code)),
          ],
        ),
        body: Stack(children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.store_mall_directory,
                              color: ColorManager.darkPrimary,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Go to Store',
                              style: TextStyle(
                                color: ColorManager.darkPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: ColorManager.darkPrimary)),
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 20,
                          right: 23,
                        ),
                        width: 180,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: ColorManager.darkPrimary,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.person_add,
                            color: ColorManager.darkPrimary,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                Expanded(
                    child: FirebaseAnimatedList(
                        query: ref,
                        defaultChild: Text('Loading'),
                        itemBuilder: (context, snapshot, animation, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20),
                            child: Productcard(
                              snapshot: snapshot,
                              wishid: widget.wishid,
                            ),
                          );
                        }))
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorManager.darkPrimary,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.assignment,
                        color: ColorManager.white,
                      ),
                      Container(
                        height: 48.5,
                        width: 130,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 25,
                                width: 25,
                                child: Image.asset(ImageAssets.groupLogo)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total ",
                                  style: TextStyle(
                                      fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("wishlist")
                                      .doc(widget.wishid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data = snapshot.data?.get("total");
                                      return Text(data.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold));
                                    } else {
                                      return Text("0",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ));
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Buy the list',
                        style: TextStyle(
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
