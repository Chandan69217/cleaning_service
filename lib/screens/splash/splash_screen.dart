import 'package:cleaning_service/models/data.dart';
import 'package:cleaning_service/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utilities/cust_colors.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    futureCall(context);
    return Scaffold(
      backgroundColor: CustColors.primary,
      body: Center(
        child: Text('Cleaning Service',style: GoogleFonts.fjallaOne().copyWith(
          color: CustColors.white,
          fontSize: 38.0,
          fontWeight: FontWeight.w500,
        ),),
      ),
    );
  }

  futureCall(BuildContext context){
    Future.delayed(Duration(seconds: 1),()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LocationFetchScreen())));
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

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled.";
        isFetchingLocation = false;
      });
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          locationMessage = "Location permission denied.";
          isFetchingLocation = false;
        });
        return;
      }
    }

    // Fetch current position
    Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
    Data.user_position = position;
    // Perform reverse geocoding to get the detailed address
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Data.user_placemarks = placemarks;
    // Extract address components
    // Placemark place = placemarks.length>1?placemarks[1]:placemarks.first;
    Placemark place = placemarks.first;

    // Formatting the address
    String street = place.thoroughfare?? "";
    String locality = place.locality ?? "";
    String subLocality = place.subLocality ?? "";
    String administrativeArea = place.administrativeArea ?? "";
    String postalCode = place.postalCode ?? "";
    String country = place.country ?? "";

    // Combining into the desired format
    // String formattedAddress = "$street, $subLocality, $locality, $administrativeArea $postalCode, $country";
    String formattedAddress = await getAddressFromCoordinates(position.latitude, position.longitude);
    Data.address = formattedAddress;
    setState(() {
      locationMessage = formattedAddress;
      isFetchingLocation = false;
      Future.delayed(Duration(milliseconds: 800,),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Dashboard())),);
    });
  }

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      // Get the placemarks from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      // Check if placemarks are available
      if (placemarks.isNotEmpty) {
        // Get the first placemark
        Placemark place = placemarks[0];

        // Format the address
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Center(
          child: isFetchingLocation
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: CustColors.primary,
                size: 50.0,
              ),
              SizedBox(height: 30),
              Text(
                locationMessage,
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
                size: 50.0,
              ),
              SizedBox(height: 10),
              Text('Service at',style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.green,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(
                '${Data.user_placemarks[1].thoroughfare}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              Text(
                locationMessage,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
