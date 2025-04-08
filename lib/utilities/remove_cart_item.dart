import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'api_urls.dart';
import 'const.dart';

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
      return data['status'] == 'success';
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