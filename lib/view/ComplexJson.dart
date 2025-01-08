import 'package:flutter/material.dart';
import 'package:flutter_dev_test/model/location_data_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/location_data_controller.dart';

class ComplexJson extends StatefulWidget {
  @override
  State<ComplexJson> createState() => _ComplexJsonState();
}

class _ComplexJsonState extends State<ComplexJson> {
  LocationDataController locationDataController =
      Get.put(LocationDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text(
              "Plot Solve",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () {
              return locationDataController.isLoading.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: locationDataController.dataList?.length,
                      itemBuilder: (context, index) {
                        final data = locationDataController.dataList?[index];
                        return Column(
                          children: [
                            buildContainer(data, data?.sizes?.small, "Small"),
                            buildContainer(data, data?.sizes?.medium, "Medium"),
                            buildContainer(data, data?.sizes?.large, "Large"),
                          ],
                        );
                      },
                    );
            },
          ),
        ));
  }

  Container buildContainer(Data? data, String? value, String title) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width-50,
      decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText("Address", "${data?.address}"),
          buildText("City", "${data?.city}"),
          buildText("Country", "${data?.country}"),
          buildText(title, "$value"),
        ],
      ),
    );
  }

  Text buildText(String title, String value) => Text(
        "$title : $value",
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      );
}
