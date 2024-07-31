import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gomaa/core/location_handler/location_handler.dart';
import 'package:gomaa/features/HomePage/HomePageAdmin/admin_models/admin_model.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/repo.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/tasks_model/tasks_model.dart';
import 'package:gomaa/features/login/login_model/login_model.dart';

import '../../../../core/utils/toast.dart';
import 'package:path/path.dart';



class TasksCubit extends Cubit<TasksStates> {
  TasksRepository repo;
  TasksCubit(this.repo) : super(InitialStateTasks());


  static TasksCubit get(context) => BlocProvider.of(context);



List<TasksModelForUser>? tasksForUser = [];

  getTasksForOneUser() async
{
  emit(GetLoadingTasksState());

  await repo.getUserTasks().then((value) {
    tasksForUser =  value.data;


  emit(GetSuccessTasksState());

  }).catchError((onError)
  {
    showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

    emit(GetErrorTasksState());
    debugPrint('errrrrror ${onError.toString()}');

  });

}


  List<TasksModelForUser>? adminTaskForOneUser = [];

  getAdminUsersTasks({
    required String id,
}) async
  {
    emit(GetLoadingAdminTasksState());

    await repo.getUserTasksForAdmin(id).then((value) {
      adminTaskForOneUser =  value.data;


      emit(GetSuccessAdminTasksState());

    }).catchError((onError)
    {
      showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

      emit(GetErrorAdminTasksState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }


  addTasksForOneUser({
    required int salse_id,
    required String description,
    required String full_address,
    required String url,
    required String task_name,
    required String clientPhone,
    required String deadline,

}) async
  {
    emit(AddLoadingTasksState());

    await repo.addUserTasks(TasksModelForUser(

      salse_id: salse_id,
      status: 0,
      description: description,
      full_address: full_address,
      url: url,
      task_name: task_name,
      latitude: "51.50740000",
      longitude: "-0.12780000",
      client_phone: clientPhone,
      deadline: deadline,

    )).then((value) {

if(value.task != null ) {
  showToast(text: 'تم إنشاء المهمة بنجاح', state: ToastStates.success);
  emit(AddSuccessTasksState());
  getTasksForOneUser();
print(url);

} else {
  showToast(text: 'ادخل رابط العنوان بشكل صحيح', state: ToastStates.error);

}

    }).catchError((onError)
    {
      showToast(text: 'ادخل رابط العنوان بشكل صحيح', state: ToastStates.error);

      emit(AddErrorTasksState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }

  Future<void> updateTasksForOneUser({
    required String idTask ,
    required int status,
    required String full_address,
    File? imageFile,
  }) async {
    emit(UpdateLoadingTasksState());

    try {
      // Create a Dio instance
      Dio dio = Dio();



      // Create a FormData object to hold your form data
      FormData formData = FormData.fromMap({
        'status': status.toString(),
        'full_address': full_address.toString(),
      });

      if (imageFile != null) {
        String filename = imageFile!.path
            .split('/')
            .last;
        formData.files.add(
            MapEntry(
              'image',
              await MultipartFile.fromFile(
                  imageFile.path, filename: filename),
            ));
      }
      // Make the HTTP POST request
      Response response = await dio.post(
        'https://gomaacompany.com/api/public/api/tasks/update/$idTask',
        data: formData,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // If successful, emit success state
      //  showToast(text: 'succeee$idTask ', state: ToastStates.white);
        log('syyyyyyyyyy');
        emit(UpdateSuccessTasksState());
        getTasksForOneUser();
      } else {
        // If not successful, emit error state
        emit(UpdateErrorTasksState());
     //   showToast(text: '${response.data}عفوا حدث خطأ', state: ToastStates.error);
        debugPrint('Error: ${response.data}');
      }
    } catch (error) {
      // If an exception occurs, emit error state
      emit(UpdateErrorTasksState());
     // showToast(text: 'Error: $errorعفوا حدث خطأ', state: ToastStates.error);
      debugPrint('Error: $error');
    }
  }
//  updateTasksForOneUser({
//
//     required String idTask ,
//     required int status ,
//
// }) async
//   {
//     emit(UpdateLoadingTasksState());
//
//     await repo.updateUserTasks(idTask, Status(status:  status)).then((value) {
//
//
//
//       emit(UpdateSuccessTasksState());
//       getTasksForOneUser();
//     }).catchError((onError)
//     {
//       showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);
//
//       emit(UpdateErrorTasksState());
//       debugPrint('errrrrror ${onError.toString()}');
//
//     });
//
//   }



List<DataAllSales>? users = [];
getAllSalesFun() async

{
  emit(GetLoadingAllSalesState());

  await repo.getAllSales().then((value) {
  users = value.data;


    emit(GetSuccessAllSalesState());

  }).catchError((onError)
  {
    showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

    emit(GetErrorAllSalesState());
    debugPrint('errrrrror ${onError.toString()}');

  });

}

  List<ImagesModel>? images = [];
  getAllImages() async

  {
    emit(GetLoadingAllImagesState());

    await repo.getImages().then((value) {
      images = value.data;


      emit(GetSuccessAllImagesState());

    }).catchError((onError)
    {
      showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

      emit(GetErrorAllImagesState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }

String? mes;
  deleteSalesFun({

    required String id,
}) async

  {
    emit(DeleteLoadingSalesState());

    await repo.deleteSales(id).then((value) {

mes = value.message;

      emit(DeleteSuccessSalesState());
      getAllSalesFun();

    }).catchError((onError)
    {
      showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

      emit(DeleteErrorSalesState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }

  deleteTasksFun({

    required String id,
    required String userId,
  }) async

  {
    emit(DeleteLoadingTasksState());

    await repo.deleteTask(id).then((value) {


      emit(DeleteSuccessTasksState());
      getTasksForOneUser();
      getAdminUsersTasks(id: userId);

    }).catchError((onError)
    {
      showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

      emit(DeleteErrorTasksState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }

  editSalesFun({

    required String id,
     String? name,
     String? email,

  }) async

  {
    emit(EditLoadingSalesState());

    await repo.editSales(id, UpdateSalseModel(
      name: name,
      email: email,

    )).then((value) {

     if(value.message != null ) {
       showToast(text: 'تم التعديل بنجاح', state: ToastStates.success);

       emit(EditSuccessSalesState());
       getAllSalesFun();
     }
    }).catchError((onError)
    {
      showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

      emit(EditErrorSalesState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }

  addSalesFun({

   required String? name,
  required  String? email,
   required String? password,
  required  String? password_confirmation,

  }) async

  {
    emit(AddLoadingSalesState());

    await repo.addSales(AddRequestSalesModel(
      name: name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,

    )).then((value) {

      if(value.message != null ) {
        showToast(text: 'تم إضافة الموظف بنجاح', state: ToastStates.success);

        emit(AddSuccessSalesState());
        getAllSalesFun();
      }
    }).catchError((onError)
    {
      showToast(text: 'عفوا حدث خطأ', state: ToastStates.error);

      emit(AddErrorSalesState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }

  Future<void> uploadTaskImages
      ({
    required int taskId,
    required List<File> imageFiles
      }) async {
    const String url = 'https://gomaacompany.com/api/public/api/taskImage';
    Dio dio = Dio(
      BaseOptions(
        followRedirects: true,
        validateStatus: (status) {
          return status != null && status < 500; // Accepts status codes less than 500
        },
      ),
    );


    try {
      List<MultipartFile> imageMultipartList = await Future.wait(
        imageFiles.map((file) async {
          String fileName = basename(file.path);
          return MultipartFile.fromFile(file.path, filename: fileName);
        }).toList(),
      );
      FormData formData = FormData.fromMap({
        'task_id': taskId,
        'images[]': imageMultipartList,


      });

      Response response = await dio.post(url, data: await formData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Images uploaded successfully');
        print(response.data);
      } else {
        print('Failed to upload images. Status code: ${response.statusCode}');
        print(response.data);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}