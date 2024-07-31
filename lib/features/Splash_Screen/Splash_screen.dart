

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/features/HomePage/HomePageAdmin/home_screen_admin.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/home_employee.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constant/components/components.dart';
import '../../core/constant/const/const.dart';
import '../../core/constant/end_points/end_point.dart';
import '../../core/injection/injection.dart';
import '../HomePage/HomePageEmployee/logic/cubit.dart';
import '../HomePage/HomePageEmployee/logic/repo.dart';
import '../login/employee/login/login.dart';
import '../login/logic/cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
if(accessToken != null) {
  navigateFinish(context,  TasksScreen());
    } else if (accessTokenAdmin != null)
    {
      navigateFinish(context,  HomeAdmin());
    } else
    {
      navigateFinish(context,  LoginScreen());
    }

    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Set the duration of the animation


  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackground,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 230.h,
                    width: 230.w,
                    decoration: const BoxDecoration(

                        image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/splash.png')),
                        shape: BoxShape.circle,


                    ),

                   // child: Image.asset('assets/images/goma.png',)

                ),
              ),
          SizedBox(height: 20.h,),
        AnimatedTextKit(

          animatedTexts: [
            TyperAnimatedText('GOMMA SALES',
speed: Duration(milliseconds: 200),
                textStyle: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize : 30.sp ,
                fontWeight: FontWeight.w800 )),


         ],),


              // AnimatedTextKit(
              //   repeatForever: true,
              //
              //   animatedTexts: [
              //
              //     TyperAnimatedText('.Solar Power Co',
              //         speed:  Duration(milliseconds: 200),
              //         textStyle: GoogleFonts.cairo(
              //             color: Colors.black87,
              //             fontSize : 30.sp ,
              //             fontWeight: FontWeight.w800 )),
              //
              //   ],),
          //   Row(
          //     children: [
          //       SvgPicture.asset('assets/images/flower.svg'),
          //
          //       SizedBox(
          //       width: 190.w,
          //       child: TextLiquidFill(
          //         text: 'wedding day',
          //         waveColor: primaryColor0,
          //         boxBackgroundColor: scaffoldBackground,
          //         textStyle: const TextStyle(
          //           fontSize: 30.0,
          //
          //           fontWeight: FontWeight.bold,
          //         ),
          //         boxHeight: 300.0,
          //       ),
          // ),
          //       SvgPicture.asset('assets/images/flower_rotate.svg',),
          //
          //
          //     ],
          //   ),

     ],
      ),
        ),
    ),
    );
  }


  }

