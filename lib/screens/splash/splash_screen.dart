import 'dart:convert';
import 'dart:ffi';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cleaning_service/models/data.dart';
import 'package:cleaning_service/screens/authentication/login_screen.dart';
import 'package:cleaning_service/screens/dashboard.dart';
import 'package:cleaning_service/utilities/urls/api_urls.dart';
import 'package:cleaning_service/utilities/check_internet/is_connected.dart';
import 'package:cleaning_service/widgets/cust_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/global_keys.dart';
import '../../utilities/const.dart';
import '../../utilities/cust_colors.dart';



class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration){
      _checkLoginStatus(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.08;
    return Scaffold(
      backgroundColor: CustColors.primary,
      body: FutureBuilder(
        future: _checkLoginStatus(context),
        builder:(context,snapshot){
          if(snapshot.hasError){
            return Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.error.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                SizedBox(height: 8.0,),
                ElevatedButton(onPressed: (){
                  _checkLoginStatus(context);
                }, child: Text('Try Again')),
              ],
            ),);
          }
          return Center(
            child: Text('Cleaning Service',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: CustColors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),),
          );
        }
      ),
    );
  }


  Future<void> _checkLoginStatus(BuildContext context)async{
    bool isLoggedIn = Pref.instance.getBool(Consts.isLogin) ?? false;
    bool isTokenValid = false;
    if(isLoggedIn){
      final appToken = Pref.instance.getString(Consts.token)??'';
      try {
        if (!await CheckConnection.isConnected()) {
          showSnackBar(context: context, title: 'No internet connection.', message: 'Check your internet connections and try again',contentType: ContentType.warning);
          return Future.error('No Internet Connection !!\n please connect to internet and try again');
        }

        final uri = Uri.https(Urls.base_url, Urls.isValidToken, {'appToken': appToken});
        final response = await get(
          uri,
          headers: {'Content-Type': 'application/json'},
        );
        final body = json.decode(response.body) as Map;
        if (response.statusCode == 200) {
          if(body['status'] == 'success')
          isTokenValid = true;
          else{
            isTokenValid = false;
            showSnackBar(context: context, title: 'Session Expired', message: 'You have been logged out. Please sign in again to continue.');
          }
        } else {
          isTokenValid = false;
          showSnackBar(context: context, title: 'Server Error', message: 'Something went wrong on our end. Please try again later.');
          print("Invalid token or server error.");
        }
      } catch (e, trace) {
        print("Error checking token: $e");
        print(trace);
        isTokenValid = false;
      }
    }
    Future.delayed(const Duration(seconds: 1),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> _navigateToNextScreen(isLoggedIn && isTokenValid))),);
  }

  Widget _navigateToNextScreen(bool isLoggedIn) {
    return isLoggedIn
        ? LocationFetchScreen()
        : LoginScreen();
  }
}



class LocationFetchScreen extends StatefulWidget {

  @override
  _LocationFetchScreenState createState() => _LocationFetchScreenState();
}

class _LocationFetchScreenState extends State<LocationFetchScreen> {
  bool isFetchingLocation = true;
  String locationMessage = "Fetching your location...";


  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    String formattedAddress = '';
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
       await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Enable Location Services'),
            content: Text('Location services are disabled. Would you like to enable?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Geolocator.openLocationSettings();
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
        if (mounted) {
          setState(() {
            locationMessage = "Location services are disabled.";
            isFetchingLocation = false;
          });
        }
        Future.delayed(Duration(milliseconds: 800), () {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => Dashboard(key: Keys.dashboardScreenKey),
              ),(route)=> false
            );
          }
        });
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          if (mounted) {
            setState(() {
              locationMessage = "Location permission denied.";
              isFetchingLocation = false;
            });
          }
          Future.delayed(Duration(milliseconds: 800), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Dashboard(key: Keys.dashboardScreenKey),
                ),
              );
            }
          });
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));


      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none){
        formattedAddress = "Lat: ${position.latitude}, Lng: ${position.longitude}";
      } else {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        formattedAddress = await getAddressFromCoordinates(
            position.latitude, position.longitude);
        Data.initialize(
            addr: formattedAddress,
            placemarks: placemarks,
            position: position);
      }

    } catch (e) {
      locationMessage = "Failed to fetch location";
      print("Error occurred: $e");
    }

    if (mounted) {
      setState(() {
        locationMessage = formattedAddress;
        isFetchingLocation = false;
      });
    }

    Future.delayed(Duration(milliseconds: 800), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Dashboard(key: Keys.dashboardScreenKey),
          ),
        );
      }
    });
  }




  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {

        Placemark place = placemarks[0];

        String address = "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country} ${place.postalCode}";

        return address;
      } else {
        return 'Address not found';
      }
    } catch (e) {
      print(e);
      return 'Error occurred while fetching the address';
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.05;

    double padding = screenWidth * 0.1;
    double iconSize = screenWidth * 0.12;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Center(
          child: isFetchingLocation
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: Colors.blue,
                size: iconSize,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                locationMessage,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                ),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: iconSize,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Service at',
                style: TextStyle(
                  fontSize: fontSize * 0.9,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                '${Data.user_placemarks!=null?Data.user_placemarks!.first.thoroughfare:'N/A'}',
                style: TextStyle(
                  fontSize: fontSize * 1.1,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                locationMessage,
                style: TextStyle(
                  fontSize: fontSize * 0.9,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
