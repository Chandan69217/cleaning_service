import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnection{
  static Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}