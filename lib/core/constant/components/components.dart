import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/login/logic/cubit.dart';
import 'package:gomaa/features/login/logic/states.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../const/const.dart';
import '../const/transition.dart';
Future navigateFinish(
    BuildContext context,
    Widget widget,
    ) =>
    Navigator.of(context).pushAndRemoveUntil(
        aniamtedNavigation(screen: widget),
     (route) => false,
     // SliderRight(page: widget),

    );
Future navigateTo(
  BuildContext context,
  Widget widget,
) =>
    Navigator.of(context).push(
      aniamtedNavigation(screen: widget),
       //SliderRight(page: widget),

        );
bool x  = false ;
Widget defaultButton(
        {
          required BuildContext context,
        required String text,
        required double width,
        required double height,
        required double textSize,

        required Function() toPage}) =>
    MaterialButton(
      onPressed: toPage,
      //padding: EdgeInsets.symmetric(vertical: 13.h),
      height: 24.h,
      minWidth: width,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(30.r),
      ),

     // color: primaryColor3,
      child:  Container(
        height: height,
        width: width,

        decoration: BoxDecoration(
        color: primaryColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.cairo(fontSize:  textSize  ,fontWeight: FontWeight.w700
                ,color: scaffoldBackground),
          ),
        ),


),

    );

Widget buttonAddCard(
    {
      required BuildContext context,
      required String text,


      required Function() toPage}) =>
    MaterialButton(

      onPressed: toPage,
      padding: EdgeInsets.symmetric(vertical: 13.h,),
      height: 60.h,
      minWidth: 130.w,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),

      color: Colors.green,
      child:  Text(
        text,
        style:  GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
      ),
    );

Widget defaultTextFormFeild(context,
   {
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  String? hint,
  required String label,


  bool secure = false,
FocusNode? focusNode,
  void Function()? onTap,
  void Function(String)? onSubmit,
  void Function(String)? onChanged,
   Widget? prefix,
   Widget? suffix,
   //  double? width ,

    TextEditingController?  controller,
bool? enabled ,
}) =>
    TextFormField(
focusNode: focusNode != null ? focusNode : null,
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: secure,
      keyboardType: keyboardType,
      validator: validate,
      enabled: enabled != null ? enabled : true,
      decoration: InputDecoration(
        focusColor: primaryColor,
       // constraints: width != null ? BoxConstraints( maxWidth: width!) : BoxConstraints.expand(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
          color: primaryColor,
          
        )),
        fillColor: primaryColor,
        errorStyle: const TextStyle(height: 1),

        // constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 18 ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
        border: OutlineInputBorder(

          gapPadding: 2,

          borderSide: BorderSide(color: primaryColor,

          ),

          borderRadius: BorderRadius.circular(30),
        ),

        hintText: hint,
        labelText: label,
   suffixIcon: suffix != null ? BlocBuilder<AppCubit,AppStates>(
     builder: (context, state) =>  InkWell(
         onTap: ()
         {
           AppCubit.get(context).suffixChange();
         },
         child: suffix),
   ) : Icon(Icons.add,color: Colors.white,),
   prefixIcon: prefix != null ? prefix : Icon(Icons.add,color: Colors.white,) ,
   alignLabelWithHint: true,

        labelStyle: GoogleFonts.cairo(
         fontSize: 16.sp,
          color:  primaryColorText,

        ),
      ),
    );
Widget searchTextField({
  required Function(String)? search,
  required Function()? onTap ,
  required Function(PointerDownEvent)? onTapOutside ,
  required Function(String?)? onSaved ,
  required BuildContext context,
}) =>  TextFormField(

  onChanged:  search,
  onTap: onTap,
  onTapOutside: onTapOutside,
  onSaved: onSaved ,
  decoration: InputDecoration(
    filled: true,

    fillColor: fillRectangular,
    labelText: 'بحث',

    labelStyle: GoogleFonts.tajawal(

      fontSize: 16.sp,

      color: const Color(0xff606F7B),
    ),

    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: fillRectangular)),
    border: OutlineInputBorder(
        borderSide: const BorderSide(

            color: fillRectangular),

        borderRadius: BorderRadius.circular(8)),

    contentPadding: EdgeInsets.symmetric(horizontal: 26.w),

    prefixIconConstraints: const BoxConstraints(
      minHeight: 24,
      minWidth: 24,
    ),

    suffixIconConstraints: const BoxConstraints(
      minHeight: 24,
      minWidth: 24,
    ),
    suffixIcon: Padding(
      padding:  EdgeInsets.only(left: 16.0.w),
      child: InkWell(
          onTap: ()
          {

        // navigateTo(context, Test());
          },
          child: SvgPicture.asset('assets/images/lets-icons_filter.svg')),
    ),
    prefixIcon: Padding(
      padding:  EdgeInsets.only(right: 16.0.w, left: 16.0.w),
      child: SvgPicture.asset(


          'assets/images/material-symbols-light_search.svg'),
    ), ///temporary

  ), );

Widget searchBarField({

  required BuildContext context,
}) =>  TextFormField(

onTap: ()
{
  SchedulerBinding.instance.addPostFrameCallback((_) {
   // navigateTo(context,  SearchDetails());

  });
},
  decoration: InputDecoration(
    filled: true,

    labelText: 'ابحث',


    labelStyle: GoogleFonts.tajawal(

      fontSize: 16.sp,

      color: const Color(0xff606F7B),
    ),

    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: fillRectangular)),
    border: OutlineInputBorder(
        borderSide: const BorderSide(

            color: Colors.deepOrange),

        borderRadius: BorderRadius.circular(8)),

    contentPadding: EdgeInsets.symmetric(horizontal: 26.w),

    prefixIconConstraints: const BoxConstraints(
      minHeight: 24,
      minWidth: 24,
    ),

    suffixIconConstraints: const BoxConstraints(
      minHeight: 24,
      minWidth: 24,
    ),
    //suffixIcon: Container(),
    prefixIcon: Padding(
      padding:  EdgeInsets.only(right: 16.0.w, left: 16.0.w),
      child: SvgPicture.asset(


          'assets/images/search.svg'),
    ), ///temporary

  ), );
Widget verifyTextField(context,{required TextEditingController? controller}) => Container(
  height: 53.h,
  width: 51.w,
  padding: EdgeInsets.symmetric( horizontal: 10.w, vertical: 0.h ),
  decoration: BoxDecoration(

      border: Border.all(color:  Colors.grey ),
      borderRadius: BorderRadius.circular(6)),
  child: TextFormField(

controller: controller,

    validator: (value) {
      if (value == null || value == '') return '';
      return null;
    },
    onChanged: (value) {
      if (value.length == 1) {
       // if (AppCubit.get(context).isArabicSelected) {
          FocusScope.of(context).previousFocus();
        // } else {
        //   FocusScope.of(context).nextFocus();
        //}
      }
    },
    textAlign: TextAlign.center,
    decoration: const InputDecoration(

      helperText: '',
      helperStyle: TextStyle(fontSize: 3,),
      errorStyle: TextStyle(fontSize: 3,),



      border: UnderlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    inputFormatters: [
      LengthLimitingTextInputFormatter(1),
      FilteringTextInputFormatter.digitsOnly,
    ],
  ),
);

Widget logo() => Image.asset('',height: 100.h,width: 100.w,fit: BoxFit.contain,);
PreferredSizeWidget appBarDefaultTheme(
    {
  required BuildContext context,
  required bool isReverse  ,
  required String title,
  List<Widget>? actions,

}) => AppBar(
  elevation: 0.0,
  centerTitle: true,

  titleTextStyle: GoogleFonts.cairo(

    fontSize: 16.sp,
fontWeight: FontWeight.bold,
    color:  Colors.black,
  ),

  backgroundColor: scaffoldBackground,
  leading: isReverse  ? IconButton(
    icon:
       const Icon(Icons.arrow_back,color: Colors.black,),
    onPressed: (){
      Navigator.pop(context);
     // ClinicCubit.get(context).clearData();
    },
  )
      : Container() ,
  title: Text(title!),
  actions: actions,

);

Widget loader() =>  Container(
  height: 200.h,
  color: Colors.pinkAccent.shade100.withOpacity(0.1),
  child:   Center(

    child: Image.asset('assets/images/final-aanimi-logo.gif',
  height: 120.h,
      width: 120.h,
    ),
  ),
);

Widget notFound() => Center(
  child: Lottie.asset('assets/animation/Animation - 1706096646711.json',height: 230.h.h,width: 230.w.w),);

Widget nothing(
{
  required String text,
}) =>  Column(

  children: [
    SizedBox(height: 150.h,),
    notFound(),
    SizedBox(height: 30.h,),
    Text(text,style: GoogleFonts.cairo(fontSize: 20.sp,fontWeight: FontWeight.bold)),


  ],
);

Widget customContainer({
  Function()? onTap,
  double? width,
  double? height,
  String? text,

}) =>  InkWell(
  onTap: onTap,
  child: Container(

    width: width,
    height: height,
    padding: EdgeInsets.all(5.h),
    decoration: BoxDecoration(
      color: scaffoldBackground,

      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(

          width: 1,color: primaryColor),


    ),
    child: Center(
      child: Text(text.toString(),style:
          GoogleFonts.cairo(color: Colors.black)),
    ),
  ),
);


Widget customWidget({
  required double height,
  required double radius,
  required String image,
  required double width,


}) => Container(
  height: height,
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),


    image: DecorationImage(
      image: AssetImage(image.toString()),
      fit: BoxFit.cover,
    ),

  ),
);



Widget customWidgetContainer({
  required double height,
  required double radius,
  required double width,


}) => Container(
  height: height,
  width: width,
  decoration: BoxDecoration(
    color: scaffoldBackground,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: const [

      BoxShadow(

        offset: Offset(5, 5),color: gridColor,),
    ],

  ),
);