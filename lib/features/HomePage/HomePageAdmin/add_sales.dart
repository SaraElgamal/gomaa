import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/core/styles/styles.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/components/components.dart';
import '../../../core/constant/const/const.dart';


class AddNewSales extends StatefulWidget {
  AddNewSales({Key? key}) : super(key: key);

  @override
  State<AddNewSales> createState() => _AddNewSalesState();
}

class _AddNewSalesState extends State<AddNewSales> {

var passwordRegister = TextEditingController();
var nameCon = TextEditingController();
var emailCon = TextEditingController();
var verifyPassword = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context, state) {
        if(state is AddSuccessSalesState)
        {
          Navigator.pop(context);
        }
      },
      builder: (context, state) =>  Scaffold(
        appBar: appBarDefaultTheme(
            context: context, isReverse: true, title: 'إضافة موظف جديد'),
        body:

        Padding(
          padding:  EdgeInsets.symmetric(horizontal : 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    SizedBox(height: 30.h,),


                    defaultTextFormFeild
                      (keyboardType: TextInputType.text,
                        controller: nameCon,
                        context,
                        prefix: const Icon(Icons.person,color: primaryColor,),
                        validate: (value)
                        {
                          if (value == null || value == '') {
                            return 'لا تترك هذا الحقل فارغا';
                          }
                        }, label: 'اسم الموظف'),
                    SizedBox(height: 24.h),
                    defaultTextFormFeild
                      (keyboardType: TextInputType.emailAddress,
                        controller: emailCon,
                        context,
                        prefix: const Icon(Icons.email,color: primaryColor,),

                        validate: (value){
                          if (value == null || value == '') {
                            return 'لا تترك هذا الحقل فارغا';
                          }
                        }, label: 'البريد الالكتروني'),
                    SizedBox(height: 24.h),
                    defaultTextFormFeild
                      (keyboardType: TextInputType.text,
                        controller: passwordRegister,
                        context,
                        prefix: const Icon(Icons.password,color: primaryColor,),

                        validate: (value)
                        {
                          if (value == null || value == '') {
                            return 'لا تترك هذا الحقل فارغا';
                          }
                          if (value.length < 6) {
                            return 'كلمة السر لا يجب أن تقل عن 6 احرف' ;
                          }
                        }, label: 'كلمة سر'),

                    SizedBox(height: 24.h),
                    defaultTextFormFeild
                      (keyboardType: TextInputType.text,
                        controller: verifyPassword,
                        context,
                        prefix: const Icon(Icons.verified_user_outlined,color: primaryColor,),

                        validate: (value){


                          if (value == null || value == '') return 'لا تترك هذا الحقل فارغا';
                          if (value !=  passwordRegister.text || verifyPassword.text != passwordRegister.text) return 'كلمة السر غير متطابقة';

                        }, label: 'تأكيد كلمة السر'),
                    SizedBox(height: 24.h),
                    SizedBox(height: 50.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        MaterialButton(
                          onPressed: ()
                          {
                            if(formKey.currentState!.validate()) {
                              cubit.addSalesFun(name: nameCon.text,
                                email: emailCon.text,
                                password: passwordRegister.text,
                                password_confirmation: verifyPassword.text,);
                            }  },

                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          height: 48.h,


                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),

                          color: primaryColor,
                          child: Text(
                            'حفظ',
                            style:  GoogleFonts.cairo(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),



                      ],
                    ),
                  ]),
                ),


              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
