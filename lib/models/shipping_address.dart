import 'dart:convert';
import 'package:http/http.dart';
import '../utilities/api_urls.dart';
import '../utilities/const.dart';


class  ShippingAddress {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final String address;
  final String landMark;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final String latitude;
  final String longitude;
  final String edate;

  ShippingAddress({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.landMark,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.latitude,
    required this.longitude,
    required this.edate,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: json['Id'] ?? 0,
      name: json['Name'] ?? '',
      mobile: json['Mobile'] ?? '',
      email: json['Email'] ?? '',
      address: json['Address'] ?? '',
      landMark: json['LandMark'] ?? '',
      city: json['City'] ?? '',
      state: json['State'] ?? '',
      country: json['Country'] ?? '',
      pincode: json['Pincode'] ?? '',
      latitude: json['Latitude'] ?? '',
      longitude: json['Longitude'] ?? '',
      edate: json['Edate'] ?? '',
    );
  }

  String getCompleteDetails() {
    return '$name, $mobile\n$address, $landMark, $city, $state, $country - $pincode';
  }
}


class ShippingAddressList {
  static List<ShippingAddress> _addresses = [];
  static bool isInitialized = false; // Ensures fetching happens only once

  static List<ShippingAddress> get addresses => _addresses;

  static Future<bool> fetchAddresses() async {
    if (isInitialized) return false;

    try {
      var appToken = Pref.instance.getString(Consts.token);
      var uri = Uri.https(Urls.base_url, Urls.getShippingAddress,{'appToken' : appToken});
      var response = await get(uri, headers: {
        'Content-Type': 'application/json',
      });
      print(uri.toString());

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['status'] == "success") {
          var list = jsonData['data'] as List? ?? [];
          _addresses = list.map((e) => ShippingAddress.fromJson(e)).toList();
          isInitialized = true;
          return true;
        }
      } else {
        throw Exception("Failed to load addresses. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching addresses: $error");
    }
    return false;
  }

}
