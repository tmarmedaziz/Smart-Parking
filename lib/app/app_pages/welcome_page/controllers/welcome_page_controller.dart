import 'dart:async';
import 'package:frontend/app/app_pages/auth/signin/views/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/modles/utils/api_services.dart';
import 'package:frontend/app/app_pages/home/views/home_view.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomePageController extends GetxController
    with SingleGetTickerProviderMixin {
  // animation controller for lottie
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    // spalsh animation config
    animationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    animationController.forward();
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        bool isConnected = await GetIt.I<APIServices>().isConnected();
        Timer(
            Duration(milliseconds: 1000),
            () => Get.off(() => isConnected
                ? HomeView()
                : ResponsiveSizer(builder: (context, orientation, screenType) {
                    return LoginView();
                  })));
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
