

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/repo.dart';
import '../../features/login/logic/cubit.dart';
import '../../features/login/logic/repo.dart';
import '../web_services/web_services.dart';

final getIt = GetIt.instance;

void getInit() {
  getIt.registerLazySingleton<WebServices> (() => WebServices(createSetupDio()));
  getIt.registerLazySingleton<AppCubit> (() => AppCubit(getIt()));
  getIt.registerLazySingleton<Repository> (() => Repository(getIt()));

  getIt.registerLazySingleton<TasksCubit> (() => TasksCubit(getIt()));
  getIt.registerLazySingleton<TasksRepository> (() => TasksRepository(getIt()));


}
Dio createSetupDio()
{
  Dio dio = Dio () ;

  dio.interceptors.add(LogInterceptor(
    error: true ,
    request: true,
    requestHeader: false ,
    responseBody: true,
    requestBody: true,
    responseHeader: false,


  ));
  dio.options.followRedirects = false;
  dio.options.validateStatus =
      (status) => status != null &&  status < 400;
  dio.options.maxRedirects = 0;



  return dio;
}