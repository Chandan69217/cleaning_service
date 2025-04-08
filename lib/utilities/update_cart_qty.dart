import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'api_urls.dart';
import 'const.dart';


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
      return data['status'] == 'success';
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
