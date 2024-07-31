
import 'package:gomaa/core/constant/end_points/end_point.dart';
import 'package:gomaa/core/data_base/cache_helper/cache_helper.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/tasks_model/tasks_model.dart';
import 'package:gomaa/features/login/login_model/login_model.dart';

import '../../../../core/web_services/web_services.dart';
import '../../HomePageAdmin/admin_models/admin_model.dart';

String? accessToken;
String? accessTokenAdmin;
class TasksRepository {
  final WebServices webServices;

  TasksRepository(this.webServices);

  Future<GetTasksByTokenModel> getUserTasks () async
  {
    return  await webServices.getUserTasks('Bearer $accessToken');

  }

  Future<TasksModelForUser> updateUserTasks (String id , Status status) async
  {
    return  await webServices.updateUserTasks(id , status);

  }

  Future<AllSalesModel> getAllSales() async {
    return  await webServices.getAllSales();

  }
  Future<Status> deleteSales(String id) async {
    return  await webServices.deleteSales(id);

  }

  Future<EditSalesModel> editSales(String id, UpdateSalseModel salse) async {
    return  await webServices.editSales(id,salse);

  }

  Future<EditSalesModel> addSales(AddRequestSalesModel salse) async {
    return  await webServices.addSales(salse);

  }

  Future<GetTasksByTokenModel> addUserTasks (TasksModelForUser task) async
  {
    return  await webServices.addUserTasks(task);

  }
  Future<GetTasksByTokenModel> getUserTasksForAdmin ( String id)  async
  {
    return  await webServices.getUserTasksForAdmin(id);

  }

  Future deleteTask
      ( String id) async {
    return  await webServices.deleteTask(id);

  }

  Future<ImagesModelGet> getImages() async {
    return  await webServices.getImages();
  }
}