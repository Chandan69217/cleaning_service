import 'dart:async';
import 'dart:convert';
import 'package:cleaning_service/screens/authentication/login_screen.dart';
import 'package:cleaning_service/utilities/urls/api_urls.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/widgets/cust_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CheckTokenValidity{
  static Timer? _tokenCheckTimer;
  final BuildContext context;
  static BuildContext? _buildContext;
  CheckTokenValidity({required this.context}){
    _buildContext = context;
  }

  static void startTokenValidationCheck() {
    _tokenCheckTimer = Timer.periodic(Duration(minutes: 5), (_) {
      checkTokenValidity();
    });
  }

  static void stopTokenValidationCheck(){
    if(_tokenCheckTimer!.isActive){
      _tokenCheckTimer?.cancel();
    }

  }

  static Future<void> checkTokenValidity() async {
    try {
      var isLogin = Pref.instance.getBool(Consts.isLogin)??false;
      if(isLogin){
        final appToken = await Pref.instance.getString(Consts.token); // Update as per your token storage
        final uri = Uri.https(Urls.base_url, Urls.isValidToken, {'appToken': appToken});
        final response = await get(uri, headers: {'content-type': 'application/json'});
        final body = jsonDecode(response.body) as Map;
        if (response.statusCode == 200) {
          var isValid = body['status'] == 'success';
          if(!isValid){
            _handleInvalidToken();
          }
        } else {
          _handleInvalidToken();
        }
      }
    } catch (e) {
      print('exceptions: ${e.toString()}');
    }
  }


  static void _handleInvalidToken() {
    _tokenCheckTimer?.cancel();
    Pref.instance.clear();
    showSnackBar(context: _buildContext!, title: 'Session Expired', message: 'Please log in again.');
    Navigator.of(_buildContext!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }
}
