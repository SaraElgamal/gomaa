import 'package:json_annotation/json_annotation.dart';

import '../../../login/login_model/login_model.dart';

part 'tasks_model.g.dart';


@JsonSerializable()
class GetTasksByTokenModel {
  List<TasksModelForUser>? data;
  TasksModelForUser? task;

  GetTasksByTokenModel({this.data,this.task});

  factory GetTasksByTokenModel.fromJson(Map<String, dynamic> json) => _$GetTasksByTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksByTokenModelToJson(this);


}



@JsonSerializable()
class TasksModelForUser {
  int? id;
  String? task_name;
  String? description;
  int? status;
  String? full_address;
  String? url;
  String? image;
  String? latitude;
  String? longitude;
  int? salse_id;
  String? created_at;
  String? updated_at;
  String? client_phone;
  String? deadline;
  SalseModel? salse;

  TasksModelForUser({
    this.id,
    this.task_name,
    this.description,
    this.status,
    this.full_address,
    this.url,
    this.image,
    this.latitude,
    this.longitude,
    this.salse_id,
    this.created_at,
    this.updated_at,
    this.client_phone,
    this.deadline,
    this.salse
  });

  factory TasksModelForUser.fromJson(Map<String, dynamic> json) => _$TasksModelForUserFromJson(json);

  Map<String, dynamic> toJson() => _$TasksModelForUserToJson(this);



}


@JsonSerializable()
class Status
{

  String? message;
  Status({this.message});
  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable()

class ImagesModelGet {
  List<ImagesModel>? data;

  ImagesModelGet({this.data});

  factory ImagesModelGet.fromJson(Map<String, dynamic> json) => _$ImagesModelGetFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesModelGetToJson(this);

}

@JsonSerializable()
class ImagesModel {
  int? task_id;
  String? image_path;
  String? updated_at;
  String? created_at;
  int? id;

  ImagesModel(
      {this.task_id, this.image_path, this.updated_at, this.created_at, this.id});


  factory ImagesModel.fromJson(Map<String, dynamic> json) => _$ImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesModelToJson(this);

}

