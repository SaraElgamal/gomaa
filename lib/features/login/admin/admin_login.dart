import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/features/login/admin/admin_login.dart';
import 'package:gomaa/features/login/employee/login/login.dart';
import 'package:gomaa/features/login/logic/states.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/components/components.dart';
import '../../HomePage/HomePageAdmin/home_screen_admin.dart';
import '../logic/cubit.dart';

class LoginAdminScreen extends StatelessWidget {
   LoginAdminScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passController = TextEditingController();
   var formLoginAdmin  = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
if(state is PostSuccessLoginAdminState)
{
  navigateFinish(context, HomeAdmin());
}
      },
      builder: (context, state) =>  Scaffold(
        appBar: appBarDefaultTheme(
            context: context, isReverse: false, title: 'تسجيل الدخول للمالك'),

        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child:   SingleChildScrollView(
            child: Form(
              key: formLoginAdmin,
              child: Column(

                children: [

                  Lottie.asset('assets/animation/Animation - 1713431582904.json',height: 200.h, width: 200.w),
                  SizedBox(height : 20.h),

                  defaultTextFormFeild(
                      context,
                      prefix: Icon(Icons.email,color: primaryColorText,),
              controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validate: (value)
                      {
                        if (value == null || value == '') {
                          return 'لا تترك هذا الحقل فارغا';
                        }
                      }, label: 'البريد الالكتروني للمالك'),
                  SizedBox(height : 20.h),
                  defaultTextFormFeild(
                    controller: passController,
                      context,
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
                      ()
                  {
                    if(formLoginAdmin.currentState!.validate()) {
                      cubit.postLoginAdmin
                        (

                          email: emailController.text,
                          password: passController.text
                      );
                    }

                  }),


                  TextButton(onPressed: ()
                  {
                    navigateTo(context, LoginScreen());
                  }, child:  Text('حساب موظف؟',

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
