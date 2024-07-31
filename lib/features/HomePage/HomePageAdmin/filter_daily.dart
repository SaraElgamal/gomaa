import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/core/styles/styles.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constant/components/components.dart';
import '../HomePageEmployee/logic/cubit.dart';
import '../HomePageEmployee/logic/states.dart';
import '../HomePageEmployee/widgets/current_tasks_widgets.dart';
import '../profile_after_done.dart';


class FilterTasks extends StatefulWidget {
  int index ;
  FilterTasks({required this.index }) ;
  @override
  State<FilterTasks> createState() => _FilterTasksState();
}

class _FilterTasksState extends State<FilterTasks> {
  @override
  void initState() {
    TasksCubit.get(context).getAdminUsersTasks(id: TasksCubit.get(context).users![widget.index].id.toString());
    TasksCubit.get(context).getAllImages();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return BlocConsumer<TasksCubit,TasksStates>(
        listener: (context, state) {

    },
    builder: (context, state) => Scaffold(
      appBar: appBarDefaultTheme(
          context: context, isReverse: true, title: 'سجل المهمات'),

      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('اسم الموظف : ',style: Styles.style18Bold,),
                  Text(cubit.users![widget.index].name.toString(),style: Styles.style18Bold,),
          
                ],
              ),
              SizedBox(height: 10.h,),
              cubit.adminTaskForOneUser!.isNotEmpty ?
              ListView.separated(
          shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.adminTaskForOneUser!.length,
                separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                itemBuilder:(context, index) => cubit.adminTaskForOneUser![index].status == 2 ||
                    cubit.adminTaskForOneUser![index].status == '2' ?
                InkWell(
                  onTap: ()
                  {
                    navigateTo(context, ProfilePage(index: index,id:widget.index));
                  },
                  child: tasksDone(
                      context,
                      admin: true,
                      userId: cubit.adminTaskForOneUser![index].salse_id.toString(),
                      id: cubit.adminTaskForOneUser![index].id.toString(),
                      rate: false,
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
      ),

    )  );
  }
}
