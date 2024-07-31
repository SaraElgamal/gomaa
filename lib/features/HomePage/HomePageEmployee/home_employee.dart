import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/core/constant/components/components.dart';
import 'package:gomaa/core/data_base/cache_helper/cache_helper.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/widgets/current_tasks_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/styles/styles.dart';
import '../../login/employee/login/login.dart';
import '../HomePageAdmin/add_task.dart';
import 'details_screen.dart';


class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {

    TasksCubit.get(context).getTasksForOneUser();
    // TODO: implement initState
    super.initState();
  }



@override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return DefaultTabController(
      length: 3,
      child: BlocConsumer<TasksCubit,TasksStates>(
        listener: (context, state) {

        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: Container(),
            actions: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
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
                                       navigateFinish(context, LoginScreen());
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
                  child: Icon(Icons.logout),
                ),),
            ],

            centerTitle: true,
            title: Text('المهمات',style: Styles.style18Bold,),
            bottom:  TabBar(
        labelStyle: GoogleFonts.cairo(),
              tabs: const [
                Tab(text: 'مهمات مطلوبة',),
                Tab(text: 'جاري تنفيذها',),
                Tab(text: ' المكتملة',),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TabBarView(
              children: [

                cubit.tasksForUser!.isNotEmpty ?   ListView.separated(

                  itemCount: cubit.tasksForUser!.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 20.h,),
                  itemBuilder:(context, index) =>
                  cubit.tasksForUser![index].status == 0 ||
                      cubit.tasksForUser![index].status == '0' ?
                  taskContainer(
                    admin: false,
                    context,
                    status: 0,
                    idIndex: index,
                    onPressed: ()
                    {
                      navigateTo(context,
                          DetailedScreen(admin: false,index: index,id: 1,));
                    },
                    rate: true,
                    textButton: 'المزيد',

                    text1: cubit.tasksForUser![index].task_name.toString(),
                    text2: cubit.tasksForUser![index].description.toString(),

                  ) : Container(),
                )
                    : Center(child: Column(
                  children: [
                    Lottie.asset('assets/animation/Animation - 1707786695011.json'),
                    Text('لا يوجد حتى الان !', style: Styles.style14Bold, ),
                  ],
                )),

                cubit.tasksForUser!.isNotEmpty ?   ListView.separated(

                  itemCount: cubit.tasksForUser!.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 20.h,),
                  itemBuilder:(context, index) =>
                  cubit.tasksForUser![index].status == 1 ||
                      cubit.tasksForUser![index].status == '1' ?  taskContainer(
                    admin: false,
                    context,
                    status: 1,
                    onPressed: ()
                    {
                      navigateTo(context, DetailedScreen(admin: false,index: index,id: 1,));
                    },
                    rate: true,
                    textButton: 'المزيد',

                    text1: cubit.tasksForUser![index].task_name.toString(),
                    text2: cubit.tasksForUser![index].description.toString(),

                  ) : Container(),
                ) : Center(child: Column(
                  children: [
                    Lottie.asset('assets/animation/Animation - 1707786695011.json'),
                 Text('لا يوجد حتى الان !', style: Styles.style14Bold, ),
                  ],
                )),
                cubit.tasksForUser!.isNotEmpty ?   ListView.separated(

                  itemCount: cubit.tasksForUser!.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                  itemBuilder:(context, index) => cubit.tasksForUser![index].status == 2 ||
                      cubit.tasksForUser![index].status == "2" ? tasksDone(
                   context,
                    rate: true,
                    userId: cubit.tasksForUser![index].salse_id.toString(),
                    id: cubit.tasksForUser![index].id.toString(),
                    admin: false,
                    text1: '  تم الذهاب إلى :   ${cubit.tasksForUser![index].full_address}'

                  ) : Container(),
                ) : Center(child: Column(
                  children: [
                    Lottie.asset('assets/animation/Animation - 1707786695011.json'),
                    Text('لا يوجد حتى الان !', style: Styles.style14Bold, ),
                  ],
                )),

              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(

            onPressed: ()
            {
              navigateTo(context, AddNewTask(admin: false,));
            },
            child: Icon(Icons.add_task),
          ),
        ),
      ),
    );
  }
}
