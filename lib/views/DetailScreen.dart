import 'package:flutter/material.dart';
import 'package:get/get.dart';

class allNewsDetailScreen extends StatelessWidget {
  allNewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.pink,
        child: Stack(
          children: [
            Positioned(
                child: Material(
              elevation: 300,
              child: Container(
                height: h * .6,
                color: Colors.black,
              ),
            )),
            Positioned(
                child: Material(
              elevation: 200,
              child: Container(
                height: h * .4,
                color: Colors.lightBlue,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
