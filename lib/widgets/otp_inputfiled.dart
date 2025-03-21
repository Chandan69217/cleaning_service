import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:cleaning_service/widgets/cust_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showOtpDialog(BuildContext context,{Future<bool> Function(String OTP)? onSubmit}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double dialogHeight = MediaQuery.of(context).size.height * 0.25;
  final List<TextEditingController> otpControllers = List.generate(4, (_)=>TextEditingController());
  bool _isLoading = false;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext _) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: dialogHeight * 0.1),
        title: FittedBox(fit:BoxFit.scaleDown,child: Text('Enter OTP',style: TextStyle(fontSize: dialogHeight * 0.12),)),
        titlePadding: EdgeInsets.symmetric(vertical: dialogHeight * 0.1),
        buttonPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        content: StatefulBuilder(
          builder:(__,setState){
            return SizedBox(
              height: dialogHeight,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildOtpFields(__,otpControllers: otpControllers),
                  // SizedBox(height: dialogHeight > 200 ? dialogHeight * 0.1:dialogHeight * 0.009),
                  Spacer(),
                  _isLoading ? CustLoader():SizedBox(
                    width: double.infinity,
                    // height: dialogHeight * 0.27,
                    child: ElevatedButton(
                      onPressed:()async{
                        setState(() {
                          _isLoading = true;
                        });
                         var number = '';
                        for(var controller in otpControllers){
                          number += controller.text.trim();
                        }
                        if(!await onSubmit!(number)){
                          setState((){
                            _isLoading = false;
                          });
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        textStyle: TextStyle(fontSize: (dialogHeight * 0.27) * 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: dialogHeight * 0.08,
                            fontWeight: FontWeight.normal,
                            color: Colors.white, // Change if needed
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,)
                ],
              ),
            );
          }
        ),
      );
    },
  );
}

Widget _buildOtpFields(BuildContext context ,{required List<TextEditingController> otpControllers}) {
  double dialogHeight = MediaQuery.of(context).size.height * 0.2;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: dialogHeight * 0.07,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return SizedBox(
            width: dialogHeight * 0.3,
            height: dialogHeight * 0.3,
            child: TextField(
              controller: otpControllers[index],
              style: TextStyle(fontSize: dialogHeight * 0.12),
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                counterText: '',
                hintText: '-',
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(color: Colors.grey,fontSize: dialogHeight * 0.12),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              onChanged: (value) {
                if (value.isNotEmpty && index < 5) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          );
        }),
      ),
      SizedBox(height: dialogHeight * 0.01),
      TextButton(
        child: Text('Resend OTP'),
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () {
          print("Resend OTP pressed");
        },
      ),
      SizedBox(height: dialogHeight * 0.08,)
    ],
  );
}