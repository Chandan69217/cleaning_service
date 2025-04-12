import 'dart:convert';
import 'dart:io';
import 'package:cleaning_service/models/cart_items.dart';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/check_internet/is_connected.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class CartScreenProvider with ChangeNotifier{
  static final CartScreenProvider instance = CartScreenProvider._();
  CartItemsList cartItemsList = CartItemsList.fromJson({});
  int cartCount = 0;
  double totalAmount = 0;
  CartScreenProvider._();


  Future<bool> addToCart({
    required BuildContext context,
    required int serviceId,
    required int qty,
    required double price,
  }) async {
    String appToken = Pref.instance.getString(Consts.token) ?? '';
    if (!await CheckConnection.isConnected()) {
      _showSnackbar(context, "No internet connection. Please check your network.",
          Colors.red);
      return false;
    }

    try {
      var uri = Uri.https(Urls.base_url, Urls.addToCart);
      var body = jsonEncode({
        "AppToken": appToken,
        "ServiceId": serviceId,
        "Qty": qty,
        "Price": price,
      });

      final response = await post(uri,
          headers: {"Content-Type": "application/json"}, body: body);

      final data = jsonDecode(response.body);


      if (response.statusCode == 200 && data['status'] == 'success') {
        _showSnackbar(
            context, "Item added to your cart successfully!", Colors.green);
        await getCartItems();
        return true;
      } else if (response.statusCode == 400) {
        _showSnackbar(context, "Invalid request! Please check the item details.",
            Colors.orange);
      } else if (response.statusCode == 401) {
        _showSnackbar(context, "Unauthorized! Please log in again.", Colors.red);
      } else if (response.statusCode == 500) {
        _showSnackbar(
            context, "Server is down! Please try again later.", Colors.red);
      } else {
        _showSnackbar(
            context, "Something went wrong! Please try again.", Colors.red);
      }
    } catch (e) {
      _showSnackbar(context, "Oops! Unable to add item. Please try again later.",
          Colors.red);
    }
    return false;
  }

  void _showSnackbar(BuildContext context, String message, Color color) {
    double screenWidth = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
              fontSize: screenWidth * 0.04, fontWeight: FontWeight.normal),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<CartItemsList?> getCartItems() async {
    try {
      final token = Pref.instance.getString(Consts.token) ?? '';
      print("Token: $token");

      final uri = Uri.https(
        Urls.base_url,
        Urls.getCart,
        {'apptoken': token},
      );

      final response = await get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'] as String;
        if (status == 'success') {
          cartItemsList = CartItemsList.fromJson(data);
          cartCount = cartItemsList.data.length;
          totalAmount = _calculateTotalAmount(cartItemsList.data);
          notifyListeners();
          return cartItemsList;
        } else {
          print("API returned failure: $status");
        }
      } else {
        print("Error: Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
    return null;
  }

  Future<bool> removeCartItem(String cartId) async {
    final String token = Pref.instance.getString(Consts.token) ?? '';

    try {
      final Uri uri = Uri.https(
        Urls.base_url,
        Urls.removeCartItem,
        {
          "appToken": token,
          "cartid": cartId,
        },
      );
      final response = await post(
        uri,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var status = data['status'] == 'success';
        if(status){
         await getCartItems();
        }
        return status;
      }
    }on SocketException {
      print("No internet connection.");
    } on FormatException {
      print("Invalid response format.");
    } catch (e) {
      print("Exception occurred: $e");
    }
    return false;
  }

  Future<bool> updateCartQty({required int cartId, required int qty}) async {
    final String token = Pref.instance.getString(Consts.token) ?? '';

    try {
      final Uri uri = Uri.https(
        Urls.base_url,
        Urls.updateCartQty,
        {
          "appToken": token,
          "cartid": cartId.toString(),
          "qty": qty.toString(),
        },
      );

      final response = await post(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var status = data['status'] == 'success';
        if(status){
          await getCartItems();
        }
        return status;
      } else {
        print("Server returned error: ${response.statusCode}");
      }
    } on SocketException {
      print("No internet connection.");
    } on FormatException {
      print("Invalid response format.");
    } catch (e) {
      print("Unexpected error: $e");
    }
    return false;
  }


  double _calculateTotalAmount(List<CartItems> cartItems) {
    double totalAmount = 0;
    for (var item in cartItems) {
      totalAmount += (item.price.toDouble() * item.qty.toDouble() );
    }
    return totalAmount;
  }

// Future<CartItems?> getCartItems() async {
//
//   try {
//     final token = Pref.instance.getString(Consts.token)??'';
//     print(token);
//     final uri = Uri.https(Urls.base_url,Urls.getCart + token);
//     final response = await get(uri,headers: {"Content-Type": "application/json"},);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final status = data['status'] as String;
//       if(status.toString() == 'success' ){
//         var cartItems = CartItems.fromJson(data);
//         return cartItems;
//       }
//     } else {
//       print("Error: . Status Code: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Exception: $e");
//   }
//   return null;
// }


}