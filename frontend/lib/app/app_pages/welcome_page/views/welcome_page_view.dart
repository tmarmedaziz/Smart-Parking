import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:frontend/app/app_theme/Text_Theme.dart';
import 'package:lottie/lottie.dart';

import '../controllers/welcome_page_controller.dart';

class WelcomePageView extends GetView<WelcomePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD9EEFF),
      body: Center(
        child: GetBuilder<WelcomePageController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/car.json',
                controller: _.animationController,
                frameRate: FrameRate(60),
                repeat: true,
                width: Get.width * 0.80,
                onLoaded: (composition) {
                  _.animationController..duration = composition.duration;
                },
              ),
              SizedBox(
                height: 70.0,
              ),
              Text(
                'Smart Parking',
                style: Text_Theme.style1.copyWith(
                  color: Color(0xff1a1111)
                  ,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
