import 'dart:convert';
import 'package:cleaning_service/models/cart_items.dart';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:http/http.dart';

Future<CartItems?> getCartItems() async {

  try {
    final token = Pref.instance.getString(Consts.token)??'';
    final uri = Uri.https(Urls.base_url,Urls.getCart + token);
    final response = await get(uri,headers: {"Content-Type": "application/json"},);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final status = data['status'] as String;
      if(status.toString() == 'success' ){
        var cartItems = CartItems.fromJson(data);
        return cartItems;
      }
    } else {
      print("Error: Failed to load cart items. Status Code: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception: $e");
  }
  return null;
}
