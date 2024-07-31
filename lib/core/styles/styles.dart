import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/colors.dart';
import '../constant/const/const.dart';


class Styles {
  static TextStyle style18Bold = GoogleFonts.cairo(
      color: MainColors.black, fontSize: 18.sp, fontWeight: FontWeight.w700);

  static TextStyle style20white = GoogleFonts.cairo(

      color: MainColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500);

  static TextStyle style14whiteSemiBold = GoogleFonts.cairo(
      color: MainColors.black, fontSize: 14.sp,
      fontWeight: FontWeight.w500
  );

  static TextStyle style16SemiBold = GoogleFonts.cairo(
      color: MainColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500);

  static TextStyle style16SemiBoldMashtoob = GoogleFonts.cairo(
    decoration : TextDecoration.lineThrough,
      color: MainColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold);

  static TextStyle style14Bold = GoogleFonts.cairo(
      color: MainColors.black, fontSize: 14.sp,
      fontWeight: FontWeight.w700);

  static TextStyle style12white = GoogleFonts.cairo(
      color: MainColors.black, fontSize: 12.sp, fontWeight: FontWeight.w500);
  static TextStyle subTitle12 = GoogleFonts.cairo(
      color: MainColors.addressTextColor, fontSize: 12.sp, fontWeight: FontWeight.w500);

  static TextStyle style16whiteBold = GoogleFonts.cairo(
      color: MainColors.black,
      fontSize: 16.sp, fontWeight: FontWeight.bold);

  static TextStyle style24whiteBold = GoogleFonts.cairo(
      color: MainColors.black, fontSize: 24.sp, fontWeight: FontWeight.w600);

  static TextStyle style40whiteBold = GoogleFonts.cairo(
      color: MainColors.black, fontSize: 40.sp, fontWeight: FontWeight.bold);

  static TextStyle style36greenBold = GoogleFonts.cairo(
      color: primaryColor, fontSize: 36.sp, fontWeight: FontWeight.w600);
}