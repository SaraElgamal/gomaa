// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllSalesModel _$AllSalesModelFromJson(Map<String, dynamic> json) =>
    AllSalesModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataAllSales.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllSalesModelToJson(AllSalesModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataAllSales _$DataAllSalesFromJson(Map<String, dynamic> json) => DataAllSales(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$DataAllSalesToJson(DataAllSales instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'created_at': instance.created_at,
    };

EditSalesModel _$EditSalesModelFromJson(Map<String, dynamic> json) =>
    EditSalesModel(
      message: json['message'] as String?,
      salse: json['salse'] == null
          ? null
          : SalseModel.fromJson(json['salse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditSalesModelToJson(EditSalesModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'salse': instance.salse,
    };
