import 'dart:convert';
import 'dart:io';

import 'package:cleaning_service/models/categories_service.dart';
import 'package:cleaning_service/utilities/urls/api_urls.dart';
import 'package:cleaning_service/utilities/check_internet/is_connected.dart';
import 'package:cleaning_service/utilities/provider/cart_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';



class HomeScreenProvider with ChangeNotifier{
  static final HomeScreenProvider instance = HomeScreenProvider._();
  CategoriesServiceModel categoriesServiceModel  = CategoriesServiceModel.fromJson({});
  HomeScreenProvider._();


  Future<CategoriesServiceModel?> fetchHomeScreenData() async {
    bool hasInternet = await CheckConnection.isConnected();
    if (!hasInternet) {
      return Future.error("No Internet Connection. Please check your network.");
    }
    CartScreenProvider.instance.getCartItems();
    try {
      var uri = Uri.https(Urls.base_url, Urls.categories);
      var response = await get(uri, headers: {
        'Content-Type': 'application/json',
      });
      print(response.body);
      if (response.statusCode == 200) {
        categoriesServiceModel = CategoriesServiceModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
        return categoriesServiceModel;
      } else {
        print(
            'Server error: ${response.statusCode} - ${response.reasonPhrase}');
        return null;
      }
    } on SocketException catch (e) {
      print('No internet connection: $e');
      return Future.error("No Internet Connection. Please check your network.");
    } on HttpException catch (e) {
      print('HTTP Exception: $e');
      return Future.error("Server error. Please try again later.");
    } on FormatException catch (e) {
      return Future.error("Something went wrong!!. Please try again later.");
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return Future.error("Something went wrong!!. Please try again later.");
    }
  }

}