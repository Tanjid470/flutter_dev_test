

import 'dart:convert';

import 'package:flutter_dev_test/model/location_data_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class LocationDataController extends GetxController{

  @override
  void onInit() {
    setLocationData();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  late List<Data>? dataList;

  Future<bool> setLocationData() async {
    var fetchLocationData = await getLocationData("https://try.artificialsoft.xyz/api/location-data");
    try {
      if (fetchLocationData?.data?.isNotEmpty == true) {
        dataList = fetchLocationData!.data;
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<LocationDataModel?> getLocationData(String endPoint) async {
    var response = await http.get(Uri.parse(endPoint));
    if (response != null) {
      var data = json.decode(response.body);
      if (data != null) {
        var locationData = locationDataModeFromJson(utf8.decode(response.bodyBytes));
        return locationData;
      }
    } else {
      return null;
    }
    return null;
  }

}