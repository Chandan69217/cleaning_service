import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cleaning_service/utilities/urls/api_urls.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../../utilities/handle_https_response.dart';
import '../../widgets/cust_loader.dart';
import '../../widgets/cust_snack_bar.dart';

void showRegistrationDialog(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return RegistrationDialog();
    },
  );
}

class RegistrationDialog extends StatefulWidget {
  @override
  _RegistrationDialogState createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

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
      var uri = Uri.https(Urls.base_url, Urls.register);
      var body = json.encode({
        "FullName": fullNameController.text,
        "Email": emailController.text,
        "Mobile": mobileController.text,
        "Password": passwordController.text,
        "Address": addressController.text,
        "City": cityController.text,
        "State": stateController.text,
        "Pincode": pincodeController.text,
      });

      var response = await post(uri, body: body, headers: {
        'Content-Type': 'application/json',
      });

      // Check status code
      if (response.statusCode == 200) {
        var rawData = json.decode(response.body);
        bool isSuccess = rawData['isSuccess'];
        var responseMsg = rawData['responseMsg'];
        Navigator.of(context).pop();
        if (isSuccess) {
          showSnackBar(
              context: context,
              title: responseMsg,
              message: "User register successfully",
              contentType: ContentType.success);
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 10,
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Close button (always visible)
              IconButton(
                iconSize: screenWidth * 0.06,
                onPressed: () => Navigator.of(context).pop(),
                style: IconButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                ),
                icon: Icon(Icons.close_rounded),
              ),

              SizedBox(height: 8.0,),
              // Container with form
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildTextField(fullNameController, 'Full Name'),
                                _buildTextField(emailController, 'Email', isEmail: true),
                                _buildTextField(mobileController, 'Mobile', isNumber: true),
                                _buildTextField(passwordController, 'Password', isPassword: true),
                                _buildTextField(confirmPasswordController, 'Confirm Password', isPassword: true),
                                _buildTextField(addressController, 'Address'),
                                _buildTextField(cityController, 'City'),
                                _buildTextField(stateController, 'State'),
                                _buildTextField(pincodeController, 'Pincode', isNumber: true),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        // Register button (always visible at bottom)
                        _isLoading
                            ? CustLoader()
                            : SizedBox(
                          width: screenWidth * 0.8,
                          child: ElevatedButton(
                            onPressed: _registerUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTextField(
      TextEditingController controller, String labelText,
      {bool isEmail = false, bool isPassword = false, bool isNumber = false}) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double textFieldHeight = screenWidth * 0.15;
    bool _isObsureText = isPassword;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 8.0,),
      child: SizedBox(
        height: textFieldHeight,
        child: StatefulBuilder(builder: (context,refresh)=> TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          maxLength: isNumber?10:null,
          keyboardType: isNumber
              ? TextInputType.number
              : (isEmail ? TextInputType.emailAddress : TextInputType.text),
          obscureText: _isObsureText,
          style: TextStyle(fontSize: textFieldHeight * 0.35,fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: labelText,
            counterText: '',
            suffixIcon: isPassword ? IconButton(onPressed: (){
              refresh((){
                _isObsureText = !_isObsureText;
              });
            }, icon: Icon(_isObsureText?Icons.visibility_off:Icons.visibility)):null,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                )
            ),
            labelStyle: TextStyle(fontSize: textFieldHeight * 0.35,fontWeight: FontWeight.w500,color: Colors.black),
            contentPadding: EdgeInsets.symmetric(
                horizontal: textFieldHeight * 0.2),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $labelText';
            }
            return null;
          },
        ),)
      ),
    );
  }


}

// Expanded(
// child: AlertDialog(
// title: Text('Register'),
// content: Container(
// width: screenWidth,
// child: Form(
// key: _formKey,
// child: SingleChildScrollView(
// child: Column(
// children: [
// _buildTextField(fullNameController, 'Full Name', screenWidth),
// _buildTextField(emailController, 'Email', screenWidth, isEmail: true),
// _buildTextField(mobileController, 'Mobile', screenWidth, isNumber: true),
// _buildTextField(passwordController, 'Password', screenWidth, isPassword: true),
// _buildTextField(addressController, 'Address', screenWidth),
// _buildTextField(cityController, 'City', screenWidth),
// _buildTextField(stateController, 'State', screenWidth),
// _buildTextField(pincodeController, 'Pincode', screenWidth, isNumber: true),
// ],
// ),
// ),
// ),
// ),
// actions: [
//
// _isLoading
// ? CustLoader()
//     : SizedBox(
// width: screenWidth * 0.8,
// child: ElevatedButton(
// onPressed: _registerUser,
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.indigoAccent,
// foregroundColor: Colors.white,
// padding: EdgeInsets.zero,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// child: Center(
// child: Text(
// 'Register',
// style:
// TextStyle(fontSize: (screenWidth * 0.13) * 0.3),
// )),
// ),
// ),
// ],
// ),
// ),
