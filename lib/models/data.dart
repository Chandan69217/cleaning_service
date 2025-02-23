import 'package:geocoding/geocoding.dart'; // for Placemark
import 'package:geolocator/geolocator.dart'; // for Position

class Data {

  static List<Placemark>? user_placemarks;
  static Position? user_position;
  static String? address;

  static void initialize({
    List<Placemark>? placemarks,
    Position? position,
    String? addr = 'N/A',
  }) {
    user_placemarks = placemarks;
    user_position = position;
    address = addr;
  }
}
