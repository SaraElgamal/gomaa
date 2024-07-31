import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/core/colors/colors.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/core/styles/styles.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:gomaa/features/login/admin/admin_login.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../core/constant/components/components.dart';
import '../../../core/data_base/cache_helper/cache_helper.dart';
import 'add_sales.dart';
import 'add_task.dart';
import 'empolyee details.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    TasksCubit.get(context).getAllSalesFun();
    // TODO: implement initState
    super.initState();
    nameController.text = '';
    emailController.text = '';
  }


  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context, state) {
if(state is DeleteSuccessSalesState) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('تم الحذف بنجاح',style: GoogleFonts.cairo(color : Colors.white,fontSize : 16.sp),),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Undo delete action
          // Implement undo logic here
        },
      ),
    ),
  );
}
      },
      builder: (context, state) =>  Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBarDefaultTheme(

          actions: [
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
             child: InkWell(
                 onTap : ()
                 {
                   navigateTo(context, AddNewSales());
                 },
                 child: Icon( Icons.add,size: 30, )),
           ),
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
             child: InkWell(
                 onTap : ()
                 {
                   showDialog(context: context, builder: (context)
                   => Dialog(
                     child: Container(
                       height: 200.h,
                       width: 366.w,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(height: 40.h,),
                           Text('هل أنت متأكد من تسجيل الخروج؟',style: Styles.style16SemiBold,),
                           SizedBox(height: 40.h,),


                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               defaultButton(context: context, text: 'نعم', width: 100.w, height: 40.h,
                                 textSize: 14.sp, toPage: () async
                                 {

                                   await CacheHelper.clearAll().then((value) {
                                     value = true;
                                     if (value) {
                                       navigateFinish(context, LoginAdminScreen());
                                     }
                                   });

                                 },                           ),
                               defaultButton(context: context, text: 'لا', width: 100.w, height: 40.h,
                                   textSize: 14.sp, toPage: ()
                                   {
                                     Navigator.pop(context);

                                   }),
                             ],
                           ),
                         ], ),
                     ),
                   ),);
                 },
                 child: Icon( Icons.logout,size: 30, )),
           ),
          ],
            context: context, isReverse: false, title: 'أسماء الموظفين'),

        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child:   ListView(

            children: [
              SizedBox(height : 20.h),
              // ListView.separated(
              //
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //
              //   itemCount: cubit.users!.length,
              //   separatorBuilder: (context, index) => Divider(),
              //   itemBuilder:(context, index) => Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       SizedBox(height: 10.h,),
              //       InkWell(
              //           onTap: ()
              //           {
              //             navigateTo(context, EmployeeDetails() );
              //           },
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(cubit.users![index].name.toString(),style: Styles.style16whiteBold,),
              //               Text(cubit.users![index].email.toString(),style: Styles.style14whiteSemiBold,),
              //
              //             ],
              //           )),
              //   SizedBox(height: 10.h,),
              //     ],
              //   )
              // ),
              ListView.separated(

                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: cubit.users!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder:(context, index) {
                  final user = cubit.users![index];
                  return Dismissible(
                    key: UniqueKey(), // Unique key for each item
                    direction: DismissDirection.horizontal,

                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),// Blue background color for edit
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),


    secondaryBackground:  Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.red,
      ),// Red background color
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          nameController.text = cubit.users![index].name.toString();
                          emailController.text = cubit.users![index].email.toString();
                          showDialog(context: context, builder: (context)
                          => Dialog(
                              child:
                         Container(
                                  height: 250.0.h,
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      SizedBox(height: 40.h,),
                                      defaultTextFormFeild(
                                          context,
                                          keyboardType: TextInputType.text,
                                          controller: nameController,
                                          validate: (value){}, label: 'الاسم'),
                                SizedBox(height: 20.h,),
                                      defaultTextFormFeild(
                                          context,
                                          keyboardType: TextInputType.text,
                                          controller: emailController,
                                          validate: (value){}, label: 'البريد الالكتروني'),
                                      SizedBox(height: 20.h,),
                                      defaultButton(context: context, text: 'تعديل', width: 100.w, height: 40.h,
                                          textSize: 14.sp, toPage: ()
                                          {
                                            cubit.editSalesFun(id: user.id.toString(),name: nameController.text,email: emailController.text);
                                Navigator.pop(context);
                                          })
                                    ],
                                  ),

                         ),
                          )
                          );
                        } else if (direction == DismissDirection.endToStart) {
                          showDialog(context: context, builder: (context)
                          => Dialog(
                            child: Container(
                              height: 200.h,
                              width: 366.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 40.h,),
                                  Text('هل أنت متأكد من حذف هذا الموظف؟',style: Styles.style16SemiBold,),
                                  SizedBox(height: 40.h,),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      defaultButton(context: context, text: 'نعم', width: 100.w, height: 40.h,
                                        textSize: 14.sp, toPage: ()
                                        {


                                          cubit.deleteSalesFun(id: user.id.toString());
Navigator.pop(context);
                                        },                           ),
                                      defaultButton(context: context, text: 'لا', width: 100.w, height: 40.h,
                                          textSize: 14.sp, toPage: ()
                                          {
                                            Navigator.pop(context);
                                            cubit.getAllSalesFun();
                                          }),
                                    ],
                                  ),
                                ], ),
                            ),
                          ),);
                          // Here you can perform the action to delete the item
                          print(cubit.mes);
                        }
                      },

                    child:
                    InkWell(
                      onTap: ()
                                {
                                  navigateTo(context, EmployeeDetails(index: index,) );
                                },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cubit.users![index].name.toString(),style: Styles.style16whiteBold,),
                                      Text(cubit.users![index].email.toString(),style: Styles.style14whiteSemiBold,),

                                    ],
                                  ),
                        ),
                      ),
                    ),
                  );
                }
              ),



            ],

          ),
        ),
        floatingActionButton: FloatingActionButton(

          onPressed: ()
          {
            navigateTo(context, AddNewTask(admin: true,));
          },
          child: Icon(Icons.add_task),
        ),
      ),
    );
  }
}
