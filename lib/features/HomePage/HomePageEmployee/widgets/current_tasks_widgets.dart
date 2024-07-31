
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constant/components/components.dart';
import '../../../../core/styles/styles.dart';

Widget taskContainer(context ,
    {

      required String text1,
      required String text2,
      required bool rate,
       int? idIndex ,
      required bool admin,
      required int status,
      required String textButton,
      required Function() onPressed,
    }) => Stack(
  children: [

    customWidgetContainer(
        radius: 20.r,width: 382.w,height: 146.h),


    Positioned(
        top: 15.h,
        right: 60.w,
        child: Text(text1,style: Styles.style16whiteBold,)),


    Positioned(
        top: 50.h,
        right: 60.w,
        left: 60.w,
        child:  Text(text2)),

    rate ?    Positioned(
      top: 20.h,

      right: 20.w,
      child: const Icon(Icons.view_list_rounded),
    ) : Container(),
    Positioned(
        top: 90.h,

        left: 10.w,
        child: defaultButton(
            textSize: 14.sp,
            height: 36.h,
            context: context,
            text: textButton, width: 120.w,
            toPage: onPressed )) ,

  admin || status == 1 ?  Container() :  Positioned(
      top: 90.h,
      right: 15.w,
      bottom: 10.h,
      child: BlocConsumer<TasksCubit,TasksStates>(
        listener: (context, state) {

        },
        builder: (context, state) =>  buttonAddCard(text: 'تأكيد الاستلام' ,
          toPage: ()
          {
            TasksCubit.get(context)
                .updateTasksForOneUser(
                full_address: TasksCubit.get(context).tasksForUser![idIndex!].full_address.toString(),
                idTask:
            TasksCubit.get(context).tasksForUser![idIndex!].id.toString() , status: 1);
            print(TasksCubit.get(context).tasksForUser![idIndex!].id.toString());
          },context: context,),
      )),
  ],
);


Widget tasksDone(context ,
    {

      required String text1,
      required String id,
      required String userId,

      required bool rate,
      required bool admin,

    }) => Stack(
alignment: AlignmentDirectional.center,
  children: [

    customWidgetContainer(
        radius: 20.r,width: 350.w,height: 200.h),

    Positioned(
        top: 30.h,
        left: 60.w,
        right: 60.w,
        child: Text(text1,
          style: admin && rate ? Styles.style16SemiBoldMashtoob :
          Styles.style16whiteBold, maxLines: 4,
          overflow: TextOverflow.ellipsis,)),
    Positioned(
        top: 100.h,
        left: 20.w,
        child: BlocBuilder<TasksCubit,TasksStates>(
          builder: (context, state) =>  InkWell(child: Icon(Icons.delete,color: Colors.red,),onTap: ()
          {
            TasksCubit.get(context).deleteTasksFun(id: id, userId: userId );
          },),
        )),


    rate ?    Positioned(
      top: 30.h,

      right: 20.w,
      child: Icon(Icons.task,color: Colors.green,),
    ) : Container(),
   admin ? Container() :  Positioned(
        top: 20.h,

        left: 30.w,
        child: Lottie.asset('assets/animation/Animation - 1713438459680.json',height: 60.h,width: 60.w) ,
    ) ,
],
);