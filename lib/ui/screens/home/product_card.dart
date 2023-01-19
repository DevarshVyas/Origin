// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:origin/resources/assets_manager.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:origin/user_preferences/user_preferences.dart';

class Productcard extends StatefulWidget {
  static const String id = 'productcard';
  Productcard({super.key, required this.snapshot, required this.wishid});

  DataSnapshot snapshot;
  String wishid;
  @override
  State<Productcard> createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  int qty = 0;
  int total = 0;

  getQuantity() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var quary = await firestore
        .collection("Cart")
        .where("pid", isEqualTo: widget.snapshot.child("pid").value)
        .where("wishid", isEqualTo: widget.wishid)
        .get();
    if (quary.size == 0) {
    } else {
      var cId = quary.docs.first.id;
      var x = await firestore
          .collection("Cart")
          .doc(cId)
          .get()
          .then((value) => value.get("quantity"));
      setState(() {
        qty = x;
      });
    }
  }

  @override
  void initState() {
    getQuantity();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              Container(
                height: 148,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.network(
                    widget.snapshot.child('image').value.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: 1,
                  child: Container(
                      height: 15,
                      width: 70,
                      decoration: BoxDecoration(
                          color: ColorManager.green,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Text(
                        "10% discount",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ))),
              Positioned(
                  bottom: 1,
                  right: 2,
                  child: Container(
                    height: 15,
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        )),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: ColorManager.darkPrimary,
                        ),
                        Text("4.5")
                      ],
                    ),
                  )),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 80,
                  child: Image.asset(ImageAssets.tescoLogo),
                ),
                Text(
                  widget.snapshot.child('pname').value.toString(),
                  style: TextStyle(
                    color: ColorManager.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.snapshot.child('desc').value.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
              height: 90,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                const Text(
                  "1 x KG",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                    ),
                    Icon(
                      Icons.currency_rupee,
                      color: ColorManager.darkPrimary,
                      size: 20,
                    ),
                    Text(
                      widget.snapshot.child('prize').value.toString(),
                      style: TextStyle(
                        color: ColorManager.darkPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                  height: 38,
                ),
                Container(
                  width: 80,
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.primary),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (qty >= 1) {
                            setState(() {
                              qty -= 1;
                              total = (widget.snapshot.child('prize').value
                                      as int) *
                                  qty;
                            });

                            FirebaseFirestore firestore =
                                FirebaseFirestore.instance;

                            var query = await firestore
                                .collection('Cart')
                                .where('pid',
                                    isEqualTo:
                                        widget.snapshot.child('pid').value)
                                .where('wishid', isEqualTo: widget.wishid)
                                .get();

                            if (query.size == 0) {
                              FirebaseFirestore.instance
                                  .collection('Cart')
                                  .add({
                                'uid': await UserPreferences.getUserId(),
                                'pid': widget.snapshot.child('pid').value,
                                'quantity': qty,
                                'total': total,
                                'wishid': widget.wishid
                              });
                            } else {
                              var docid = query.docs.first.id;
                              firestore
                                  .collection('Cart')
                                  .doc(docid)
                                  .update({'quantity': qty, 'total': total});
                            }
                            var dbqty = await firestore
                                .collection("wishlist")
                                .doc(widget.wishid)
                                .get()
                                .then((value) => value.get("qauntity"));
                            var dbTotal = await firestore
                                .collection("wishlist")
                                .doc(widget.wishid)
                                .get()
                                .then((value) => value.get("total"));
                            await firestore
                                .collection("wishlist")
                                .doc(widget.wishid)
                                .update({
                              "qauntity": dbqty -= 1,
                              "total": dbTotal -=
                                  widget.snapshot.child('prize').value
                            });
                          }
                        },
                        child: Icon(
                          Icons.remove_circle_outline_sharp,
                          color: ColorManager.darkPrimary,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('$qty'),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            qty += 1;
                            total =
                                (widget.snapshot.child('prize').value as int) *
                                    qty;
                          });

                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;

                          var query = await firestore
                              .collection('Cart')
                              .where('pid',
                                  isEqualTo: widget.snapshot.child('pid').value)
                              .where('wishid', isEqualTo: widget.wishid)
                              .get();

                          if (query.size == 0) {
                            FirebaseFirestore.instance.collection('Cart').add({
                              'uid': await UserPreferences.getUserId(),
                              'pid': widget.snapshot.child('pid').value,
                              'quantity': qty,
                              'total': total,
                              'wishid': widget.wishid
                            });
                          } else {
                            var docid = query.docs.first.id;
                            firestore
                                .collection('Cart')
                                .doc(docid)
                                .update({'quantity': qty, 'total': total});
                          }
                          var dbqty = await firestore
                              .collection("wishlist")
                              .doc(widget.wishid)
                              .get()
                              .then((value) => value.get("qauntity"));
                          var dbTotal = await firestore
                              .collection("wishlist")
                              .doc(widget.wishid)
                              .get()
                              .then((value) => value.get("total"));
                          await firestore
                              .collection("wishlist")
                              .doc(widget.wishid)
                              .update({
                            "qauntity": dbqty += 1,
                            "total": dbTotal +=
                                widget.snapshot.child('prize').value
                          });
                        },
                        child: Icon(
                          Icons.add_circle_outline_sharp,
                          color: ColorManager.darkPrimary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
