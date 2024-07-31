import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';


@JsonSerializable()
class LoginSalesModel {
  String? access_token;
  String? token_type;
  int? expires_in;
  SalseModel? salse;

  LoginSalesModel({this.access_token, this.token_type, this.expires_in, this.salse});


  factory LoginSalesModel.fromJson(Map<String, dynamic> json) => _$LoginSalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginSalesModelToJson(this);

}

@JsonSerializable()
class SalseModel {
  int? id;
  String? name;
  String? email;
  String? password;
 // Null? emailVerifiedAt;
  String? image;
  String? created_at;
  String? updated_at;

  SalseModel({this.id,
    this.name,
    this.email,
    this.password,
   // this.emailVerifiedAt,
    this.image,
    this.created_at,
    this.updated_at});


  factory SalseModel.fromJson(Map<String, dynamic> json) => _$SalseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalseModelToJson(this);


}

@JsonSerializable()
class UpdateSalseModel {

  String? name;
  String? email;


  UpdateSalseModel({
    this.name,
    this.email,
   });


  factory UpdateSalseModel.fromJson(Map<String, dynamic> json) => _$UpdateSalseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSalseModelToJson(this);


}

@JsonSerializable()
class AddRequestSalesModel {

  String? name;
  String? email;
  String? password;
  String? password_confirmation;


  AddRequestSalesModel({
    this.name,
    this.email,
    this.password,
    this.password_confirmation,
  });


  factory AddRequestSalesModel.fromJson(Map<String, dynamic> json) => _$AddRequestSalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddRequestSalesModelToJson(this);


}

@JsonSerializable()
class AdminModel {
  String? access_token;
  String? token_type;
  int? expires_in;
  Admin? admin;

  AdminModel({this.access_token, this.token_type, this.expires_in, this.admin});

  factory AdminModel.fromJson(Map<String, dynamic> json) => _$AdminModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminModelToJson(this);


}



@JsonSerializable()
class Admin {
  int? id;
  String? name;
  String? email;
  String? password;
  String? image;
  String? created_at;
  String? updated_at;

  Admin({this.id,
    this.name,
    this.email,
    this.image,
    this.password,
    this.created_at,
    this.updated_at});

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  Map<String, dynamic> toJson() => _$AdminToJson(this);


}