import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/app/app_pages/parking_slot/views/parking_slot_view.dart';
import 'package:get/get.dart';
import 'package:frontend/app/app_pages/home/views/dashboard_view.dart';
import 'package:frontend/app/app_pages/home/views/settings_view.dart';


class HomeController extends GetxController {
  // bottom nav current index.
  RxInt _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;


  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [

    Dashborad(),
    ParkingSlotView(),
    SettingsView(),
  ];


  List<bool> _isToggled = [];
  void set isToggled(length) {
    _isToggled = List.generate(length, (index) => false);
  }


  // funtion to set current index
  setCurrentIndex(int index) {
    _currentIndex.value = index;
    if (index == 1 || index == 2) {
    } else if (index == 0) {
      streamInit();
    }
  }

  // function to return correct view on bottom navBar switch
  Widget navBarSwitcher() {
    return homeViews.elementAt(currentIndex);
  }


  streamInit() {
    Timer.periodic(
      Duration(seconds: 1),
      (_) {},
    );
  }

  @override
  void onInit() {
    streamInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
