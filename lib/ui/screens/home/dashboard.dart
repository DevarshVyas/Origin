import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/resources/color_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:origin/resources/string_manager.dart';
import 'package:origin/ui/dialogs/logut_dialog.dart';
import 'package:origin/ui/screens/home/Productpage.dart';
import 'package:origin/ui/screens/home/pages/categories.dart';
import 'package:origin/ui/screens/home/pages/home.dart';
import 'package:origin/ui/screens/home/pages/more.dart';
import 'package:origin/ui/screens/home/pages/show.dart';
import 'package:origin/ui/screens/home/pages/vendor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Dashboard> {
  int activeIndex = 0;

  final TextEditingController _Listnames = TextEditingController();
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  List<String> litems = [];
  int _currentIndex = 0;

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
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            unselectedItemColor: Colors.grey,
            fixedColor: ColorManager.darkPrimary,
            items:  [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Vendors'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lists'),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.more), label: 'More'),
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
        body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            CarouselSlider.builder(

              itemCount: urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];

                return Container(
                    width: double.infinity,
                    child:
                buildImage(urlImage, index));
              },
              options: CarouselOptions(height: 200, autoPlay: true,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
              viewportFraction: 1
              ),
            ),
            const SizedBox(height: 10, width: 10),
            buildIndicator(activeIndex=_currentIndex),
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
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
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
                                                      MainAxisAlignment
                                                          .spaceEvenly,
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
        ),
      ),
    );
  }

  Widget buildIndicator(int activeindex) => AnimatedSmoothIndicator(

        count: urlImages.length, activeIndex: activeindex,
      );

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const Home();
        break;
      case 1:
        widget = const Vendor();
        break;
      case 2:
        widget = const Display();
        break;
      case 3:
        widget = const More();
        break;
      case 4:
        widget = const Categories();
        break;
      default:
        widget = const Home();
        break;
    }
    return widget;
  }

  Widget buildImage(String urlImage, int index) => Container(

        child: Image.network(
          urlImage,
          fit: BoxFit.fitWidth,
        ),
      );

}
