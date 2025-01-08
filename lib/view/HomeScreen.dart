import 'package:flutter/material.dart';
import 'package:flutter_dev_test/view/Bug1ExplanationScreen.dart';
import 'package:flutter_dev_test/view/Bug2.dart';
import 'package:flutter_dev_test/view/ComplexJson.dart';

import 'Bug1.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("HOME"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bug1()));
            }, child: const Text("Bug 1 (UI) - Solve")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bug2()));
            }, child: const Text("Bug 2 (Google Map) - Solve")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ComplexJson()));
            }, child: const Text("Handle Complex Json - Solve"))
          ],
        ),
      ),
    );
  }

}