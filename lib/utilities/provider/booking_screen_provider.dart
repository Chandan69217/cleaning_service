import 'dart:convert';
import 'package:cleaning_service/models/booked_service_list.dart';
import 'package:cleaning_service/utilities/urls/api_urls.dart';
import 'package:cleaning_service/utilities/check_internet/is_connected.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BookingScreenProvider with ChangeNotifier{
  static final BookingScreenProvider instance = BookingScreenProvider._();
  BookingScreenProvider._();
  BookedServiceList _bookedServiceList = BookedServiceList.fromJson({});

  BookedServiceList get bookedServiceList => _bookedServiceList;


  Future<BookedServiceList?> getBookingList() async {
    // Check Internet Connectivity
    bool hasInternet = await CheckConnection.isConnected();
    if (!hasInternet) {
      return Future.error("No Internet Connection. Please check your network.");
    }

    try {
      var appToken = Pref.instance.getString(Consts.token);
      final url = Uri.http(Urls.base_url, Urls.getBookingList, {'appToken': appToken});
      final response = await get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data == null || data.isEmpty) {
          return Future.error("No booking data found.");
        }
        _bookedServiceList = BookedServiceList.fromJson(data);
        notifyListeners();
        return _bookedServiceList;
      }else if(response.statusCode == 400){
        return Future.error("No booking data found.");
      }
      else if (response.statusCode == 401) {
        return Future.error("Session expired. Please log in again.");
      }
      else if (response.statusCode == 403) {
        return Future.error("Access denied. You do not have permission.");
      }
      else if (response.statusCode == 404) {
        return Future.error("Booking service not found.");
      }
      else if (response.statusCode == 500) {
        return Future.error("Server error. Please try again later.");
      }
      else {
        return Future.error("Unexpected error: ${response.statusCode}. Please try again.");
      }
    } catch (e) {
      return Future.error("Something went wrong. Please check your connection and try again.");
    }
  }
}