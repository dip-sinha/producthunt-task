import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/splash/splash_controller.dart';

class SplashPage extends StatelessWidget{
  static const routeName = "/";
  final SplashController _controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Product Hunt", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w700, fontSize: 28),),
              // SizedBox(height: 20),
              // Text("by", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 10),),
              // Text("Dip Sinha", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 10),),
              SizedBox(height: 20),
              CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }

}