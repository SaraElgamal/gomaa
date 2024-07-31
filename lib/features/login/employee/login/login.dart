import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/login/admin/admin_login.dart';
import 'package:gomaa/features/login/logic/cubit.dart';
import 'package:gomaa/features/login/logic/states.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/components/components.dart';
import '../../../HomePage/HomePageEmployee/home_employee.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var emailController = TextEditingController();

var passController = TextEditingController();
var formLogin  = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
if(state is PostSuccessLoginSalesState){
  navigateFinish(context, TasksScreen());
}
      },
      builder: (context, state) =>  Scaffold(
        appBar: appBarDefaultTheme(
            context: context, isReverse: false, title: 'تسجيل الدخول كموظف'),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child:   SingleChildScrollView(
      child: Form(
        key: formLogin,
        child: Column(

          children: [

           Lottie.asset('assets/animation/Animation - 1713431582904.json',height: 200.h, width: 200.w),
            SizedBox(height : 20.h),

            defaultTextFormFeild(
              controller: emailController,
                context,
                prefix: Icon(Icons.email,color: primaryColorText,),

                keyboardType: TextInputType.emailAddress,

                validate: (value){
                  if (value == null || value == '') {
                    return 'لا تترك هذا الحقل فارغا';
                  }
                }, label: 'البريد الالكتروني للموظف'),
            SizedBox(height : 20.h),
            defaultTextFormFeild(
              context,
              controller: passController,
        prefix: const Icon(Icons.lock,color: primaryColorText,),
        suffix: cubit.suffix,
                secure: cubit.isPassword,
                keyboardType: TextInputType.text,

                validate: (value)
                {
                  if (value == null || value == '') {
                    return 'لا تترك هذا الحقل فارغا';
                  }
                }, label: 'كلمة المرور'),


        SizedBox(height : 100.h),
            defaultButton(
                height: 48.h,
                textSize: 18.sp,
                context: context,
                text: 'تسجيل الدخول', width: 250.w, toPage:
                () {
                  if (formLogin.currentState!.validate()) {
                    cubit.postLoginSales
                      (

                        email: emailController.text,
                        password: passController.text
                    );
                  }
                }
         ),


            TextButton(onPressed: ()
            {
              navigateTo(context, LoginAdminScreen());
            }, child:  Text('حساب مالك؟',

              style: GoogleFonts.cairo(color:Colors.black,

                  decoration : TextDecoration.underline),),),

          ],

        ),
      ),
        ),
      ),
      ),
    );
  }
}
