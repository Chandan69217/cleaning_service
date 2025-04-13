import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context){
  final text_scale_factor = MediaQuery.of(context).textScaleFactor;
  return ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0*text_scale_factor,
        fontWeight: FontWeight.bold,
          fontFamily: 'proxima_nova',
      ),
            bodyMedium: TextStyle(
              fontSize: 14.0*text_scale_factor,
                fontFamily: 'proxima_nova'
            ),
        bodySmall: TextStyle(
          fontSize: 12.0*text_scale_factor,
          fontFamily: 'proxima_nova'
        )
    )
  );
}