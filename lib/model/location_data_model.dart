
import 'dart:convert';

LocationDataModel locationDataModeFromJson(String str) => LocationDataModel.fromJson(json.decode(str));

String locationDataModeToJson(LocationDataModel data) => json.encode(data.toJson());

class LocationDataModel {
  bool? status;
  List<Data>? data;

  LocationDataModel({this.status, this.data});

  LocationDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? appId;
  String? address;
  String? city;
  String? country;
  Sizes? sizes;

  Data(
      {this.id, this.appId, this.address, this.city, this.country, this.sizes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    sizes = json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['app_id'] = appId;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    if (sizes != null) {
      data['sizes'] = sizes!.toJson();
    }
    return data;
  }
}

class Sizes {
  String? small;
  String? medium;
  String? large;

  Sizes({this.small, this.medium, this.large});

  Sizes.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = small;
    data['medium'] = medium;
    data['large'] = large;
    return data;
  }
}
