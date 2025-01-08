import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Bug1ExplanationScreen extends StatelessWidget{
  const Bug1ExplanationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Bug 1 Solve",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height/10,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: height/10,
                        width: height/10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(color: Colors.red),
                        child: Center(child: Text('$index',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                      );
                    },),
              ),
              ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: width-20,
                    height: height/5,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: Center(child: Text('$index',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)),
                  );
              },)
            ],
          ),
        ),
      ),

    );
  }

}


