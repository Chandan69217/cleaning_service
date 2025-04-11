import 'dart:convert';
import 'package:cleaning_service/models/user_details.dart';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/check_internet/is_connected.dart';
import 'package:cleaning_service/utilities/check_token_validity.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/widgets/cust_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class UserProfileProvider with ChangeNotifier {
  static final UserProfileProvider instance = UserProfileProvider._internal();

  UserProfileProvider._internal(){
    _userDetails = UserDetails.fromJson({});
  }

  UserDetails _userDetails = UserDetails.fromJson({});
  UserDetails get userDetails => _userDetails;

  Future<bool> getUserDetails() async {
    bool hasInternet = await CheckConnection.isConnected();
    if (!hasInternet) {
      return Future.error("No Internet Connection. Please check your network.");
    }

    try {
      await CheckTokenValidity.checkTokenValidity();
      final appToken = Pref.instance.getString(Consts.token);
      var uri = Uri.https(Urls.base_url, Urls.profielDetails, {
        'appToken': appToken,
      });
      var response = await get(uri, headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        _userDetails = UserDetails.fromJson(body['data']);
        notifyListeners(); // Will work
      } else {
        return Future.error("Server error. Please try again later.");
      }
    } catch (e) {
      return Future.error("Something went wrong. Please try again later.");
    }
    return true;
  }


  Future<bool> updateUserProfile(Map<String,String> updates) async{
    bool hasInternet = await CheckConnection.isConnected();
    if (!hasInternet) {
      return Future.error("No Internet Connection. Please check your network.");
    }

    try {
      await CheckTokenValidity.checkTokenValidity();
      final appToken = Pref.instance.getString(Consts.token);
      var uri = Uri.https(Urls.base_url, Urls.editProfile, {
        'appToken': appToken,
      });
      var response = await post(uri,body: json.encode(
          updates
      ),headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        var isUpdated = body['status'] == 'success';
        if(isUpdated){
          await getUserDetails();
          return true;
        }else{
          return false;
        }
      } else {
        return Future.error("Server error. Please try again later.");
      }
    } catch (e) {
      return Future.error("Something went wrong. Please try again later.");
    }
  }
}
