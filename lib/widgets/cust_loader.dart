import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustLoader extends StatelessWidget{
  final Color? color;
  final double? size;
  CustLoader({this.color,this.size});
  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: color??CustColors.primary,
      size: size??25.0,
    );
  }

}