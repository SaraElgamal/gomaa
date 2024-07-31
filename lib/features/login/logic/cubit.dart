import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/repo.dart';
import 'package:gomaa/features/login/logic/repo.dart';
import 'package:gomaa/features/login/logic/states.dart';
import 'package:gomaa/features/login/login_model/login_model.dart';

import '../../../core/constant/end_points/end_point.dart';
import '../../../core/data_base/cache_helper/cache_helper.dart';
import '../../../core/utils/toast.dart';

class AppCubit extends Cubit<AppStates> {
  Repository repo;
  AppCubit(this.repo) : super(InitialState());


  static AppCubit get(context) => BlocProvider.of(context);




  postLoginSales({

    required String email,
    required String password,
}) async
{
  emit(PostLoadingLoginSalesState());
  await repo.loginSales(SalseModel(

    email: email,
    password:password

  )).then((value) {


    CacheHelper.saveData(key: 'nameUser', value: value.salse!.name);
    CacheHelper.saveData(key: 'idUserData', value: value.salse!.id);
    // CacheHelper.saveData(key: 'phoneUser', value: phoneReg);
    // CacheHelper.saveData(key: 'emailUser', value: emailReg);
    // CacheHelper.saveData(key: 'dateUser', value: dateReg);
    // CacheHelper.saveData(key: 'imageUser', value: imageReg);
    // CacheHelper.saveData(key: 'nameUser', value: nameReg);
if(value.access_token != null ) {
  showToast(text: 'تم تسجيل الدخول بنجاح', state: ToastStates.success);
  accessToken = value.access_token.toString();
  CacheHelper.saveData(key: 'token', value: accessToken);

  emit(PostSuccessLoginSalesState());
} else
{
  showToast(text: 'عفوا البيانات غير صحيحة', state: ToastStates.error);

}
  }).catchError((onError)
  {
    showToast(text: 'عفوا البيانات غير صحيحة', state: ToastStates.error);

    emit(PostErrorLoginSalesState());
    debugPrint('errrrrror ${onError.toString()}');

  });

}

  postLoginAdmin({

    required String email,
    required String password,
  }) async
  {
    emit(PostLoadingLoginAdminState());
    await repo.loginAdmin(Admin(

        email: email,
        password:password

    )).then((value) {

      if(value.access_token != null ) {
        showToast(text: 'تم تسجيل الدخول بنجاح', state: ToastStates.success);
        accessTokenAdmin = value.access_token.toString();
        CacheHelper.saveData(key: 'tokenAdmin', value: accessTokenAdmin);

        emit(PostSuccessLoginAdminState());
      } else
      {
        showToast(text: 'عفوا البيانات غير صحيحة', state: ToastStates.error);

      }
    }).catchError((onError)
    {
      showToast(text: 'عفوا البيانات غير صحيحة', state: ToastStates.error);

      emit(PostErrorLoginAdminState());
      debugPrint('errrrrror ${onError.toString()}');

    });

  }



  var suffix = Icon(Icons.remove_red_eye_rounded,color: primaryColor,);
  bool isPassword = true;

  void suffixChange() {
    isPassword = !isPassword;
    suffix = isPassword ? Icon(Icons.visibility_off_rounded,color: primaryColor,) : Icon(Icons.remove_red_eye_rounded,color: primaryColor,);
    emit(changeSuffixIconState());
  }








}