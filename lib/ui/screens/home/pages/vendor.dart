import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origin/bloc/network_cubit.dart';
import 'package:origin/model/responses/random_user/random_user.dart';
import 'package:provider/provider.dart';

import '../../../../controller/random_user.dart';
import '../../../../utils/network_utilities.dart';

class Vendor extends StatefulWidget {
  Vendor({Key? key}) : super(key: key);

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  bool isDateRecevied = false;

  Results? results;

  late RandomUserProvider randomUserProvider;

  @override
  Widget build(BuildContext context) {
    randomUserProvider = Provider.of<RandomUserProvider>(context);
    randomUserProvider.networkCubit ??= BlocProvider.of<NetworkCubit>(context);

    getRnandomUser();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children:  [
          Text("hello"
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  void getRnandomUser() async {
    var response = await randomUserProvider.getRandomUser();
    var parseRes = NetworkUtils().handleResponse(response, context);
    if (parseRes != null) {
      var RandomUserModel = randomusr.fromJson(json.decode(response.body));
      print(parseRes);

      results = RandomUserModel.results?.first;

      print("email:${results?.email}");
    }
  }
}
