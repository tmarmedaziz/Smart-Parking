import 'package:get/get.dart';

import '../controllers/parking_slot_controller.dart';

class ParkingSlotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParkingSlotController>(
      () => ParkingSlotController(),
    );
  }
}
