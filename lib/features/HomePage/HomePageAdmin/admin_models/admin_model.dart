
import 'package:gomaa/features/login/login_model/login_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_model.g.dart';


@JsonSerializable()
class AllSalesModel {
  List<DataAllSales>? data;

  AllSalesModel({this.data});

  factory AllSalesModel.fromJson(Map<String, dynamic> json) => _$AllSalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllSalesModelToJson(this);

}

@JsonSerializable()
class DataAllSales {
  int? id;
  String? name;
  String? email;
  String? image;
  String? created_at;

  DataAllSales({this.id, this.name,
    this.email, this.image, this.created_at});

  factory DataAllSales.fromJson(Map<String, dynamic> json) => _$DataAllSalesFromJson(json);

  Map<String, dynamic> toJson() => _$DataAllSalesToJson(this);

}

@JsonSerializable()
class EditSalesModel {
  String? message;
  SalseModel? salse;

  EditSalesModel({this.message, this.salse});

  factory EditSalesModel.fromJson(Map<String, dynamic> json) => _$EditSalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditSalesModelToJson(this);


}