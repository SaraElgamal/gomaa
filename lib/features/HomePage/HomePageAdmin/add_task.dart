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
import '../../../core/data_base/cache_helper/cache_helper.dart';
import '../../../core/location_handler/location_handler.dart';
import 'package:intl/intl.dart';
var nameUser = CacheHelper.getData(key: 'nameUser');
var idUser = CacheHelper.getData(key: 'idUserData');

class AddNewTask extends StatefulWidget {
bool admin ;
AddNewTask({required this.admin});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  String selectedName = '       اسم الموظف';

  var nameTaskCon = TextEditingController();
  var addressCon = TextEditingController();
  var addressConGlobal = TextEditingController();
  var detailCon = TextEditingController();
  var callNumController = TextEditingController();
  var deadlineController = TextEditingController();
  var formAddTask = GlobalKey<FormState>();

  List<Map<String, dynamic>> users = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i = 0 ; i < TasksCubit.get(context).users!.length ; i++)
    {
      var user = TasksCubit.get(context).users![i];
      users.add({'name': user.name.toString(), 'id': user.id!.toInt()});
    }
  }

  DateTime? selectedDateTime;


  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('en', 'US'),  // Force English locale
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
        builder: (context, child) {
          return Localizations.override(
            context: context,
            locale: const Locale('en', 'US'), // Force English locale
            child: child,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
          deadlineController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context, state) {
if(state is AddSuccessTasksState)
{
  Navigator.pop(context);
}
      },
      builder: (context, state) => Scaffold(
        appBar: appBarDefaultTheme(
            context: context, isReverse: true, title: 'انشاء مهمة جديدة'),
        body:

        Padding(
          padding:  EdgeInsets.symmetric(horizontal : 20.w),
          child: Form(
            key: formAddTask,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      SizedBox(height: 30.h,),


                  widget.admin ?    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(30),

                        ),
                        child: DropdownButton<Map<String, dynamic>>(
                          dropdownColor: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(30),
                          isExpanded: true,
                          hint: Text(selectedName.isNotEmpty ? selectedName :  '    اختر اسم الموظف' ,
                            style: GoogleFonts.cairo(fontSize : 16.sp , color : primaryColor),),
                          value: null,
                          onChanged: (value) {
                            log(value.toString());
                  setState(() {

                    selectedName = value!['name'].toString();
                  });
                          },
                          items: users
                              .map(
                                (user) => DropdownMenuItem<Map<String, dynamic>>(
                              value: user,
                              child: Text(user['name'].toString(),style: Styles.style16SemiBold,),
                            ),
                          )
                              .toList(),
                        ),
                      ) :
                      Container(
                        height: 50.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(30),

                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 24.w,),
                            Text(nameUser,style: Styles.style16SemiBold,),
                          ],
                        ),
                      ),
                     SizedBox(height: 24.h),
                      defaultTextFormFeild
                        (keyboardType: TextInputType.text,
                           controller: nameTaskCon,
                          context,
                          validate: (value){
                            if (value == null || value == '') {
                              return 'لا تترك هذا الحقل فارغا';
                            }
                          }, label: 'اسم المهمة'),
                      SizedBox(height: 24.h),
                      defaultTextFormFeild
                        (keyboardType: TextInputType.text,

                          context,
                          controller: addressConGlobal,
                          validate: (value)
                          {
                            if (value == null || value == '') {
                              return 'لا تترك هذا الحقل فارغا';
                            }
                          }, label: 'العنوان بالكامل'),

                      SizedBox(height: 24.h),
                      defaultTextFormFeild
                        (
                          context,
                          keyboardType: TextInputType.text,
                          controller: addressCon,
                          validate: (value){


                          }, label: 'رابط العنوان من google map'),
                      SizedBox(height: 24.h),
                      defaultTextFormFeild
                        (
                          context,
                          keyboardType: TextInputType.phone,
                          controller: callNumController,
                          validate: (value){


                          }, label: 'رقم العميل إن وجد'),
                      SizedBox(height: 24.h),
                      TextFormField(

                        controller: deadlineController,

                        decoration:  InputDecoration(
                            focusColor: primaryColor,
                            fillColor: primaryColor,
                            alignLabelWithHint: true,
prefixIcon: Icon(Icons.add,color: Colors.white,),
                            labelStyle: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              color:  primaryColorText,

                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                            border: OutlineInputBorder(

                              gapPadding: 2,

                              borderSide: BorderSide(color: primaryColor,

                              ),

                              borderRadius: BorderRadius.circular(30),
                            ),
                            // constraints: width != null ? BoxConstraints( maxWidth: width!) : BoxConstraints.expand(),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: const BorderSide(
                                  color: primaryColor,

                                )),
                            labelText: 'تحديد مهلة المهمة'),
                        readOnly: true,

                        onTap: () => _selectDateTime(context),

                        textAlign: TextAlign.right,

                      ),


                      SizedBox(height: 24.h),
                      TextFormField(
                  validator: (value)
                  {
                    if (value == null || value == '') {
                  return 'لا تترك هذا الحقل فارغا';
                    }
                  },
                        keyboardType: TextInputType.multiline,
                        minLines: 4, // Set this
                        maxLines: 6,
            controller: detailCon,
                        decoration: InputDecoration(
                          labelText: '        تفاصيل',

                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                          border: OutlineInputBorder(

                            gapPadding: 2,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          labelStyle: GoogleFonts.cairo(
                            fontSize: 16.sp,
                            color:  primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                    ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    MaterialButton(
                      onPressed: ()
                      {


                         var  selectedUser = widget.admin ?
                        users.firstWhere((user) => user['name'] == selectedName) : null;

                        if(formAddTask.currentState!.validate())
                        {
                         // parseGoogleMapsLink(addressCon.text);
                          print(addressCon.text);
                          print(idUser);
                          cubit.addTasksForOneUser(
                            task_name:  nameTaskCon.text  ,
                            url: addressCon.text,
                            salse_id: !widget.admin ? idUser : selectedUser != null ? selectedUser['id'] : null,
                            full_address: addressConGlobal.text,
                            description: detailCon.text,
                            clientPhone: callNumController.text,
                            deadline: deadlineController.text,

                          );
                        }

                      },

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
                SizedBox(height: 30.h,),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
