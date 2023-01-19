import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:http/http.dart' as http;
import 'package:origin/utils/service_utilites.dart';

import '../bloc/network_cubit.dart';
import '../bloc/server_status_codes.dart';
import '../ui/screens/login/loginScreen.dart';
import '../user_preferences/user_preferences.dart';

class NetworkUtils {
  handleResponse(http.Response response, BuildContext context) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    print('responseData is $responseData');
    if (response.statusCode == ServerStatusCodes.UNAUTHORISED ||
        response.statusCode == ServerStatusCodes.FORBIDDED) {
      ServiceUtils.showSuccessMsg(responseData["message"], context);
      UserPreferences.clearDetailsOnSignOut();
      Future(() {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      });
      return null;
    } else if (response.statusCode == ServerStatusCodes.BAD_REQUEST) {
      ServiceUtils.showErrorMsg(responseData["message"], context);
      return null;
    }
    return response;
  }

  static showLoader(BuildContext context) {
    BlocProvider.of<NetworkCubit>(context).showLoader(context);
  }

  static hideLoader(BuildContext context) {
    BlocProvider.of<NetworkCubit>(context).hideLoader(context);
  }
}
