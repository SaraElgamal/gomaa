import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/colors.dart';
import '../constant/const/const.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(


    colorScheme: ColorScheme.fromSeed(
      primary: primaryColor ,
      seedColor: primaryColor,



    ),
      useMaterial3: true,
    fontFamily: GoogleFonts.cairo(color: Colors.black,
        fontSize: 24.sp).fontFamily,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: MainColors.white,
    textTheme:  TextTheme(
        bodySmall: GoogleFonts.cairo(
          color: MainColors.black,
          fontSize: 14.sp,

          fontWeight: FontWeight.w400,
          height: 0.h,
          letterSpacing: -0.24,
        ),
        titleMedium:  GoogleFonts.cairo(
          color: MainColors.black,
          fontSize: 20.sp,

          fontWeight: FontWeight.w600,
          height: 0,
          letterSpacing: -0.40,
        ),

        bodyMedium: GoogleFonts.cairo(

          color: MainColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: 0,
          letterSpacing: -0.24,
        )),
  );
}