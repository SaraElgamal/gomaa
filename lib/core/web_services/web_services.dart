

import 'package:dio/dio.dart' hide Headers;
import 'package:gomaa/features/HomePage/HomePageAdmin/admin_models/admin_model.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/tasks_model/tasks_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/login/login_model/login_model.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: ('https://gomaacompany.com/api/public/'))

abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  @POST('api/salse/login')
  Future<LoginSalesModel> loginSales (@Body() SalseModel salse) ;

  @POST('api/admin/login')
  Future<AdminModel> loginAdmin (@Body() Admin admin) ;


  @GET('api/tasksByToken')
Future<GetTasksByTokenModel> getUserTasks (@Header('Authorization') String token) ;

  @GET('api/tasks/salse/{id}')
  Future<GetTasksByTokenModel> getUserTasksForAdmin (@Path('id') String id) ;

  @POST('api/tasks/update/{id}')
Future<TasksModelForUser> updateUserTasks
    (@Path('id') String id, @Body() Status status) ;

  @GET('api/salse')
  Future<AllSalesModel> getAllSales() ;


  @DELETE('api/salse/{id}')
  Future<Status> deleteSales
      (@Path('id') String id) ;


  @DELETE('api/tasks/{id}')
  Future deleteTask
      (@Path('id') String id) ;

  @POST('api/salse/update/{id}')
  Future<EditSalesModel> editSales
      (@Path('id') String id, @Body() UpdateSalseModel salse) ;


  @POST('api/salse')
  Future<EditSalesModel> addSales
      ( @Body() AddRequestSalesModel addSales) ;



  @POST('api/tasks')
  Future<GetTasksByTokenModel> addUserTasks (@Body() TasksModelForUser task) ;



  @GET('api/taskImage')
  Future<ImagesModelGet> getImages() ;



}


