// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTasksByTokenModel _$GetTasksByTokenModelFromJson(
        Map<String, dynamic> json) =>
    GetTasksByTokenModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TasksModelForUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      task: json['task'] == null
          ? null
          : TasksModelForUser.fromJson(json['task'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTasksByTokenModelToJson(
        GetTasksByTokenModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'task': instance.task,
    };

TasksModelForUser _$TasksModelForUserFromJson(Map<String, dynamic> json) =>
    TasksModelForUser(
      id: (json['id'] as num?)?.toInt(),
      task_name: json['task_name'] as String?,
      description: json['description'] as String?,
      status: (json['status'] as num?)?.toInt(),
      full_address: json['full_address'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      salse_id: (json['salse_id'] as num?)?.toInt(),
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      client_phone: json['client_phone'] as String?,
      deadline: json['deadline'] as String?,
      salse: json['salse'] == null
          ? null
          : SalseModel.fromJson(json['salse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TasksModelForUserToJson(TasksModelForUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_name': instance.task_name,
      'description': instance.description,
      'status': instance.status,
      'full_address': instance.full_address,
      'url': instance.url,
      'image': instance.image,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'salse_id': instance.salse_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'client_phone': instance.client_phone,
      'deadline': instance.deadline,
      'salse': instance.salse,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'message': instance.message,
    };

ImagesModelGet _$ImagesModelGetFromJson(Map<String, dynamic> json) =>
    ImagesModelGet(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ImagesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImagesModelGetToJson(ImagesModelGet instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ImagesModel _$ImagesModelFromJson(Map<String, dynamic> json) => ImagesModel(
      task_id: (json['task_id'] as num?)?.toInt(),
      image_path: json['image_path'] as String?,
      updated_at: json['updated_at'] as String?,
      created_at: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImagesModelToJson(ImagesModel instance) =>
    <String, dynamic>{
      'task_id': instance.task_id,
      'image_path': instance.image_path,
      'updated_at': instance.updated_at,
      'created_at': instance.created_at,
      'id': instance.id,
    };
