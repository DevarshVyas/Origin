// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origin/controller/random_user.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../bloc/api_constants.dart';
import '../../../../bloc/network_cubit.dart';
import '../../../../model/responses/customer.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/string_manager.dart';
import '../../../../utils/network_utilities.dart';
import '../product_page.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const String id = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int activeIndex = 0;
  int _currentIndex = 0;
  final TextEditingController _Listnames = TextEditingController();

  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  addData() {
    Map<String, dynamic> data = {
      'name': _Listnames.text,
      'qauntity': 0,
      'total': 0,
      'uid': userId,
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('wishlist');
    collectionReference.add(data);
  }

  final urlImages = [
    'https://images.unsplash.com/photo-1601598851547-4302969d0614?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
    'https://images.unsplash.com/photo-1628102490959-a5b3c905fb9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
    'https://images.unsplash.com/photo-1506617564039-2f3b650b7010?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
    'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80',
    'https://images.unsplash.com/photo-1601057366047-ec734881239b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
  ];

  Widget buildIndicator(int activeindex) => AnimatedSmoothIndicator(
        count: urlImages.length,
        activeIndex: activeindex,
      );

  Widget buildImage(String urlImage, int index) => Image.network(
        urlImage,
        fit: BoxFit.fitWidth,
      );



  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        CarouselSlider.builder(
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];

            return SizedBox(
                width: double.infinity, child: buildImage(urlImage, index));
          },
          options: CarouselOptions(
              height: 200,
              autoPlay: true,
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              },
              viewportFraction: 1),
        ),
        const SizedBox(height: 10, width: 10),
        buildIndicator(activeIndex = _currentIndex),
        TextFormField(
            controller: _Listnames,
            cursorColor: ColorManager.darkPrimary,
            // textAlignVertical: TextAlignVertical.center,

            decoration: InputDecoration(
              hintText: "New List",
              prefixIcon: InkWell(
                onTap: () {
                  addData();
                },
                child: Icon(Icons.add_circle,
                    size: 30, color: ColorManager.darkPrimary),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorManager.darkPrimary, width: 3),
                  borderRadius: BorderRadius.circular(30.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorManager.darkPrimary, width: 3),
                  borderRadius: BorderRadius.circular(30.0)),
            )),
        Row(
          children: [
            Text(
              StringManager.shoppinglist,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorManager.darkPrimary,
                height: 2,
              ),
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("wishlist")
                .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),

            // lists.doc(documentId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Object?> documentSnapshot =
                          snapshot.data!.docs.elementAt(index);
                      return Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Productpage(
                                        wishid: documentSnapshot.id,
                                        title: documentSnapshot.toString(),
                                      )),
                            ),
                            child: Card(
                              elevation: 2,
                              color: ColorManager.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                height: 100,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          snapshot.data?.docs[index]['name']
                                                  .toString() ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: ColorManager.primary,
                                            ),
                                            height: 100,
                                            width: 100,
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'qty- ${snapshot.data?.docs[index]['qauntity'].toString() ?? ''}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Total- ${snapshot.data?.docs[index]['total'].toString() ?? ''}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    });
              }
              return const Text(StringManager.loading);
            },
          ),
        ),
      ]),
    );
  }


}
