import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:origin/model/responses/customer.dart';

import '../bloc/api_constants.dart';
import '../bloc/network_cubit.dart';
import 'package:http/http.dart' as http;

import '../model/responses/customer.dart';

class RandomUserProvider with ChangeNotifier {
  NetworkCubit? networkCubit;
  ModelCustomer? customerDetail;

  getRandomUser() async {
    http.Response? response;
    response =
    await networkCubit!.networkGetRequest(APIConstants.randomUser, Map());
    print("Request Response : ${response!.body}");
    return response;
  }
}