
import 'package:gomaa/features/login/login_model/login_model.dart';

import '../../../core/web_services/web_services.dart';

class Repository {
  final WebServices webServices;

  Repository(this.webServices);

  Future<LoginSalesModel> loginSales (SalseModel sales) async
  {
    return  await webServices.loginSales(sales);

  }


  Future<AdminModel> loginAdmin (Admin admin) async
  {
    return  await webServices.loginAdmin(admin);

  }
//
//   Future<SendOtp> sendOTP ( User user) async
//   {
//     return  await webServices.sendOTP(user);
//
//   }
//   Future<SendOtp> verifyPhone ( User user) async
//   {
//     return  await webServices.verifyPhone(user);
//
//   }
//
//   Future<AddFav> addFavourite (AddFav user_id,{required String productId}) async
//   {
//     return  await webServices.addFavourite(user_id, productId);
//
//   }
//
//   Future<AddFav> deleteTheFavourite (AddFav user_id,{required String productId}) async
//   {
//     return  await webServices.deleteTheFavourite(user_id, productId);
//
//   }
//
//
//   Future<GetFavorite> getAllFavourite (AddFav user_id) async
//   {
//     return  await webServices.getAllFavourite(user_id);
//
//   }
//
//   /// card
//
//
//   ///
//
//   Future<LoginModel> LoginUser (User user) async
//   {
//    var repo =   await webServices.LoginUser(user);
// return repo;
//   }
//

}