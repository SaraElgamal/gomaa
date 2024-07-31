import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/core/constant/components/components.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/widgets/current_tasks_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/styles/styles.dart';
import '../HomePageEmployee/details_screen.dart';
import '../profile_after_done.dart';
import 'filter_daily.dart';



class EmployeeDetails extends StatefulWidget {
  int index ;
   EmployeeDetails({required this.index }) ;

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TasksCubit.get(context).getAdminUsersTasks(id: TasksCubit.get(context).users![widget.index].id.toString());
    TasksCubit.get(context).getAllImages();

  }
  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);

    return DefaultTabController(
      length: 3,
      child: BlocConsumer<TasksCubit,TasksStates>(
        listener: (context, state) {

        },
        builder: (context, state) =>  Scaffold(
          appBar: AppBar(
            leading: Container(),
            centerTitle: true,
            title: Text(cubit.users![widget.index].name.toString(),style: Styles.style18Bold,),
            bottom:  TabBar(
              labelStyle: GoogleFonts.cairo(),
              tabs: const [
                Tab(text: 'مهمات الموظف',),
                Tab(text: 'المستلمة',),
                Tab(text: ' المكتملة',),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TabBarView(
              children: [

                cubit.adminTaskForOneUser!.isNotEmpty ?   ListView.separated(

                  itemCount: cubit.adminTaskForOneUser!.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                  itemBuilder:(context, index) =>    cubit.adminTaskForOneUser![index].status == 0 ||
                      cubit.adminTaskForOneUser![index].status == '0' ? taskContainer(
                    admin: true,
                    context,
                    status: 1,
                    onPressed: ()
                    {
                      navigateTo(context,  DetailedScreen(admin: true,index: index,id:widget.index));
                    },
                    rate: true,
                    textButton: 'المزيد',

                    text1: cubit.adminTaskForOneUser![index].task_name.toString(),
                    text2: cubit.adminTaskForOneUser![index].description.toString(),


                  ) : Container(),
                ) : Center(child: Column(
                  children: [
                    Lottie.asset('assets/animation/Animation - 1707786695011.json'),
                    Text('لا يوجد لدى هذا الموظف حتى الان !', style: Styles.style14Bold, ),
                  ],
                )),

                cubit.adminTaskForOneUser!.isNotEmpty ?  ListView.separated(

                  itemCount: cubit.adminTaskForOneUser!.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                  itemBuilder:(context, index) => cubit.adminTaskForOneUser![index].status == 1 ||
                      cubit.adminTaskForOneUser![index].status == '1' ?  tasksDone(
                      context,
                      rate: true,
                      userId: cubit.adminTaskForOneUser![index].salse_id.toString(),

                      id: cubit.adminTaskForOneUser![index].id.toString(),
                      admin: true,
                      text1: ' تم استلام مهمة ${cubit.adminTaskForOneUser![index].task_name}'

                  ) : Container(),
                ) : Center(child: Column(
                  children: [
                    Lottie.asset('assets/animation/Animation - 1707786695011.json'),
                    Text('لا يوجد حتى الان !', style: Styles.style14Bold, ),
                  ],
                )),
                // Center(child: Column(
                //   children: [
                //     Lottie.asset('assets/animation/Animation - 1707786695011.json'),
                //     Text('لا يوجد حتى الان !', style: Styles.style14Bold, ),
                //   ],
                // )),
                cubit.adminTaskForOneUser!.isNotEmpty ? ListView.separated(

                  itemCount: cubit.adminTaskForOneUser!.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                  itemBuilder:(context, index) => cubit.adminTaskForOneUser![index].status == 2 ||
                      cubit.adminTaskForOneUser![index].status == '2' ?  InkWell(
                    onTap: ()
                    {
                      navigateTo(context, ProfilePage(index: index,id:widget.index));
                    },
                        child: tasksDone(
                            context,
                            admin: true,
                            userId: cubit.adminTaskForOneUser![index].salse_id.toString(),
                            id: cubit.adminTaskForOneUser![index].id.toString(),
                            rate: true,
                            text1: ' تم الذهاب لمنطقة ${cubit.adminTaskForOneUser![index].full_address}'

                        ),
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
              navigateTo(context, FilterTasks(index: widget.index,));
            },child: Icon(Icons.menu_book),),
        ),
      ),
    );
  }
}
