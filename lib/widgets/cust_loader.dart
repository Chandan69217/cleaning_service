import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: CustColors.primary,
      size: 25.0,
    );
  }

}