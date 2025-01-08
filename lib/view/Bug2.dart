import 'package:flutter/material.dart';
import 'package:flutter_dev_test/view/LatLngViewerCard.dart';
import 'package:geolocator/geolocator.dart';

class Bug2 extends StatefulWidget{

  @override
  State<Bug2> createState() => _Bug2State();
}

class _Bug2State extends State<Bug2> {
  Position? planLatLng;

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
            "Bug 2 Solve",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
              child: Column(children: [
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Pick Location",
                      style: TextStyle(
                          color: Colors.cyan, fontSize: 16)),
                ),
                const SizedBox(height: 5),
                LatLngViewerCard(
                    currentPosition: planLatLng,
                    returnValue: (Position? position) {
                      setState(() {
                        planLatLng = position;
                      });
                    }),
                const SizedBox(height: 20)
              ]),
            ),
          ],
        ),
      ),
    );
  }
}