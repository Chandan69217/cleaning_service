import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cleaning_service/screens/authentication/registration_screen.dart';
import 'package:cleaning_service/screens/splash/splash_screen.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:cleaning_service/utilities/handle_https_response.dart';
import 'package:cleaning_service/widgets/cust_snack_bar.dart';
import 'package:cleaning_service/widgets/otp_inputfiled.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import '../../utilities/api_urls.dart';
import '../../widgets/cust_loader.dart';

class LoginScreen extends StatefulWidget {
  final bool requestLogin;
  const LoginScreen({super.key, this.requestLogin = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileNoTxtController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String mobileNo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLargeScreen = screenWidth > 600;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    // padding: const EdgeInsets.only(bottom: 450),
                    color: Colors.blue.withOpacity(.8),
                    height: screenHeight * 0.3,
                    alignment: Alignment.center,
                  ),
                ),
                ClipPath(
                  clipper: TopWaveClipper(waveDeep: 0, waveDeep2: 100),
                  child: Container(
                      // padding: const EdgeInsets.only(bottom: 50),
                      color: Colors.blue.withOpacity(.3),
                      height: screenHeight * 0.25,
                      alignment: Alignment.center,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if(widget.requestLogin )
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      )),
                                ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                                height: screenWidth * 0.07,
                                width: screenWidth * 0.18,
                                child: TextButton(
                                  onPressed: ()async {
                                    showRegistrationDialog(context);
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(fontSize: (screenWidth * 0.2) * 0.16, fontWeight: FontWeight.normal),
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustColors.primary,
                                    overlayColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.black.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(width: 1, color: Colors.black12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth *0.034,)
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustColors.primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      child: Center(
                        child: Text(
                          'CS',
                          style: TextStyle(
                              fontSize: (screenWidth * 0.12) * 0.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    RichText(
                      text: TextSpan(
                          text: 'Cleaning',
                          style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: '\nService',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            )
                          ]),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                SizedBox(height: isLargeScreen ? 10 : 5),
                Text('Your Home Service Expert',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
                Text('Quick • Affordable • Trusted',
                    style: TextStyle(
                        fontSize: screenWidth * 0.032, color: Colors.grey)),
                SizedBox(height: isLargeScreen ? 30 : 20),
                Container(
                  width: screenWidth * 0.8,
                  child: TextFormField(
                    controller: _mobileNoTxtController,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(fontSize: (screenWidth * 0.14) * 0.3),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      } else if (value.length < 10) {
                        return "Mobile no must be in 10 digit number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      hintText: 'Enter Mobile Number',
                      hintStyle:
                          TextStyle(fontSize: (screenWidth * 0.14) * 0.3),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CustColors.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CustColors.primary),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CustColors.primary),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isLargeScreen ? 50 : 40.0),
                _isLoading
                    ? CustLoader()
                    : SizedBox(
                        width: screenWidth * 0.8,
                        child: ElevatedButton(
                          onPressed: _getVerificationCode,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            'Get Verification Code',
                            style:
                                TextStyle(fontSize: (screenWidth * 0.13) * 0.3),
                          )),
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    // padding: const EdgeInsets.only(bottom: 450),
                    color: Colors.blue.withOpacity(.8),
                    height: screenHeight * 0.3,
                    alignment: Alignment.center,
                  ),
                ),
                ClipPath(
                  clipper: BottomWaveClipper(waveDeep: 0, waveDeep2: 100),
                  child: Container(
                    // padding: const EdgeInsets.only(bottom: 50),
                    color: Colors.blue.withOpacity(.3),
                    height: screenHeight * 0.25,
                    alignment: Alignment.center,
                  ),
                ),
                if (!widget.requestLogin)
                  Positioned(
                    bottom: screenWidth * 0.1,
                    right: screenWidth * 0.05,
                    child: SizedBox(
                      height: screenWidth * 0.07,
                      width: screenWidth * 0.18,
                      child: TextButton(
                        onPressed: () async {
                          Pref.instance.setBool(Consts.isSkipped, true);
                          Pref.instance.setBool(Consts.isLogin, false);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LocationFetchScreen()),
                              (route) => false);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              fontSize: (screenWidth * 0.2) * 0.16,
                              fontWeight: FontWeight.normal),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: CustColors.primary,
                          overlayColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.black.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(width: 1, color: Colors.black12),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getVerificationCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      mobileNo = _mobileNoTxtController.text;

      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (!(connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet))) {
        showSnackBar(
            context: context,
            title: 'No Internet',
            message: 'Your are not connected to any internet provider');
        return;
      }
      setState(() {
        _isLoading = true;
      });

      try {
        var uri = Uri.https(Urls.base_url, Urls.send_otp);
        var body = json.encode({
          'mobileno': mobileNo,
        });

        var response = await post(uri, body: body, headers: {
          'Content-Type': 'application/json',
        });

        // Check status code
        if (response.statusCode == 200) {
          var rawData = json.decode(response.body);
          Pref.instance.setBool(Consts.isLogin, true);
          bool isSuccess = rawData['isSuccess'];
          var responseMsg = rawData['responseMsg'];
          if (isSuccess) {
            var LoginOTP = rawData['data']['loginOTP'];
            showSnackBar(
                context: context,
                title: responseMsg,
                message: "otp send to $mobileNo",
                contentType: ContentType.success);
            showOtpDialog(context, onSubmit: verifyOTP);
          } else {
            showSnackBar(
                context: context,
                title: responseMsg,
                message: 'There is a server problem please try again !!');
          }
        } else {
          await handleHttpResponse(context, response);
        }
      } catch (exception, trace) {
        print('Exception: $exception, Trace: $trace');
        showSnackBar(
            context: context,
            title: 'Opps!',
            message: 'Network or server error, please check your connection.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(''),
        ));
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> verifyOTP(String OTP) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (!(connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet))) {
      showSnackBar(
          context: context,
          title: 'No Internet',
          message: 'Your are not connected to any internet provider');
      return false;
    }

    try {
      var uri = Uri.https(Urls.base_url, Urls.verify_otp);
      var body = json.encode({'mobileno': "$mobileNo", 'otp': "$OTP"});

      var response = await post(uri, body: body, headers: {
        'Content-Type': 'application/json',
      });

      // Check status code
      if (response.statusCode == 200) {
        var rawData = json.decode(response.body);
        bool isSuccess = rawData['isSuccess'];
        var responseMsg = rawData['responseMsg'];
        if (isSuccess) {
          showSnackBar(
              context: context,
              title: 'Login Successfully',
              contentType: ContentType.success,
              message: responseMsg);
          Pref.instance.setBool(Consts.isLogin, true);
          Pref.instance.setBool(Consts.isSkipped, false);
          var userToken = rawData['data']['loginToken'];
          Pref.instance.setString(Consts.token, userToken);
          Pref.instance.setString(Consts.mobileNo, mobileNo);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LocationFetchScreen()),
              (route) => false);
        } else {
          showSnackBar(
              context: context, title: 'Login Failed', message: responseMsg);
        }
      } else {
        await handleHttpResponse(context, response);
      }
    } catch (exception, trace) {
      print('Exception: $exception, Trace: $trace');
      showSnackBar(
          context: context,
          title: 'Opps!',
          message: 'Network or server error, please check your connection.');
    }
    return false;
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  final double waveDeep;
  final double waveDeep2;

  TopWaveClipper({this.waveDeep = 100, this.waveDeep2 = 0});
  @override
  Path getClip(Size size) {
    final double sw = size.width;
    final double sh = size.height;

    final Offset controlPoint1 = Offset(sw * .25, sh - waveDeep2 * 2);
    final Offset destinationPoint1 = Offset(sw * .5, sh - waveDeep - waveDeep2);

    final Offset controlPoint2 = Offset(sw * .75, sh - waveDeep * 2);
    final Offset destinationPoint2 = Offset(sw, sh - waveDeep);

    final Path path = Path()
      ..lineTo(0, size.height - waveDeep2)
      ..quadraticBezierTo(controlPoint1.dx, controlPoint1.dy,
          destinationPoint1.dx, destinationPoint1.dy)
      ..quadraticBezierTo(controlPoint2.dx, controlPoint2.dy,
          destinationPoint2.dx, destinationPoint2.dy)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  final double waveDeep;
  final double waveDeep2;

  BottomWaveClipper({this.waveDeep = 100, this.waveDeep2 = 0});

  @override
  Path getClip(Size size) {
    final double sw = size.width;
    final double sh = size.height;

    final Offset controlPoint1 = Offset(sw * .25, waveDeep2 * 2);
    final Offset destinationPoint1 = Offset(sw * .5, waveDeep + waveDeep2);

    final Offset controlPoint2 = Offset(sw * .75, waveDeep * 2);
    final Offset destinationPoint2 = Offset(sw, waveDeep);

    final Path path = Path()
      ..moveTo(0, waveDeep2) // Start from the top
      ..quadraticBezierTo(controlPoint1.dx, controlPoint1.dy,
          destinationPoint1.dx, destinationPoint1.dy)
      ..quadraticBezierTo(controlPoint2.dx, controlPoint2.dy,
          destinationPoint2.dx, destinationPoint2.dy)
      ..lineTo(sw, sh) // Extending to bottom
      ..lineTo(0, sh) // Closing at bottom-left corner
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
