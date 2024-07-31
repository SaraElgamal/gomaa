// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSalesModel _$LoginSalesModelFromJson(Map<String, dynamic> json) =>
    LoginSalesModel(
      access_token: json['access_token'] as String?,
      token_type: json['token_type'] as String?,
      expires_in: (json['expires_in'] as num?)?.toInt(),
      salse: json['salse'] == null
          ? null
          : SalseModel.fromJson(json['salse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginSalesModelToJson(LoginSalesModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'salse': instance.salse,
    };

SalseModel _$SalseModelFromJson(Map<String, dynamic> json) => SalseModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SalseModelToJson(SalseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

UpdateSalseModel _$UpdateSalseModelFromJson(Map<String, dynamic> json) =>
    UpdateSalseModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UpdateSalseModelToJson(UpdateSalseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
    };

AddRequestSalesModel _$AddRequestSalesModelFromJson(
        Map<String, dynamic> json) =>
    AddRequestSalesModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      password_confirmation: json['password_confirmation'] as String?,
    );

Map<String, dynamic> _$AddRequestSalesModelToJson(
        AddRequestSalesModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.password_confirmation,
    };

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      access_token: json['access_token'] as String?,
      token_type: json['token_type'] as String?,
      expires_in: (json['expires_in'] as num?)?.toInt(),
      admin: json['admin'] == null
          ? null
          : Admin.fromJson(json['admin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'admin': instance.admin,
    };

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      password: json['password'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
