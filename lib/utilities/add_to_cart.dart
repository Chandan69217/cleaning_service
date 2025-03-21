import 'dart:convert';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';

Future<bool> addToCart({
  required BuildContext context,
  required int serviceId,
  required int qty,
  required double price,
}) async {
  String appToken = Pref.instance.getString(Consts.token)??'';
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    _showSnackbar(context, "No internet connection. Please check your network.", Colors.red);
    return false;
  }

  try {
    var uri = Uri.https(Urls.base_url,Urls.addToCart);
    var body = jsonEncode({
      "AppToken": appToken,
      "ServiceId": serviceId,
      "Qty": qty,
      "Price": price,
    });

    final response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: body
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      _showSnackbar(context, "Item added to your cart successfully!", Colors.green);
      return true;
    } else if (response.statusCode == 400) {
      _showSnackbar(context, "Invalid request! Please check the item details.", Colors.orange);
    } else if (response.statusCode == 401) {
      _showSnackbar(context, "Unauthorized! Please log in again.", Colors.red);
    } else if (response.statusCode == 500) {
      _showSnackbar(context, "Server is down! Please try again later.", Colors.red);
    } else {
      _showSnackbar(context, "Something went wrong! Please try again.", Colors.red);
    }
  } catch (e) {
    _showSnackbar(context, "Oops! Unable to add item. Please try again later.", Colors.red);
  }
  return false;
}

void _showSnackbar(BuildContext context, String message, Color color) {
  double screenWidth = MediaQuery.of(context).size.width;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: screenWidth*0.04, fontWeight: FontWeight.normal),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      duration: Duration(seconds: 3),
    ),
  );
}
