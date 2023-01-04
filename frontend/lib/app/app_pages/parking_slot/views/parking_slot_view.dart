import 'package:flutter/material.dart';
import 'package:frontend/app/app_theme/ColorTheme.dart';
import 'package:frontend/app/app_theme/Text_Theme.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../modles/AvailableSlots.dart';
import '../../../modles/utils/api_services.dart';
import '../controllers/parking_slot_controller.dart';

class ParkingSlot extends StatefulWidget {
  const ParkingSlot({Key? key}) : super(key: key);

  @override
  _ParkingSlotState createState() => _ParkingSlotState();
}

class _ParkingSlotState extends State<ParkingSlot> {
  List<AvailableSlots> slots = [];
  void Slot() async {
    var x = await GetIt.I<APIServices>().ParkingSlot(page: 0, limit: 15);
    setState(() {
      slots = x;
    });
  }

  @override
  void initState() {
    super.initState();
    Slot();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      height: size.height,
      width: size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.01),
            Text(
              ' Parking Slots Status',
              style: Text_Theme.style1
                  .copyWith(color: Color(0xff1a1111)),
            ),


            Container(
              height: size.height * 0.8,
              width: size.width,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 3,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    return SlotStatus(
                      slotname: slots[index].slotname,
                      availability: slots[index].availability,
                      id: slots[index].id,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ParkingSlotView extends GetView<ParkingSlotController> {
  @override
  Widget build(BuildContext context) {
    return ParkingSlot();
  }
}

class SlotStatus extends StatefulWidget {
  final String slotname;
  final int availability;
  final String id;

  const SlotStatus(
      {Key? key,
        required this.slotname,
        required this.availability,
        required this.id})
      : super(key: key);

  @override
  _SlotStatusState createState() => _SlotStatusState();
}

class _SlotStatusState extends State<SlotStatus> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(1),
      height: _size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
      ),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.08),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Slot 1\n\nAvailable',
                      style: Text_Theme.style3
                          .copyWith(color: Color(0xff1a1111)),

                    ),

                  ],
                ),
                Spacer(flex: 1),



                IconButton(
                    onPressed: () async {
                      await GetIt.I<APIServices>().deleteUserById(id: widget.id);
                    },
                    icon: Icon(
                      Icons.car_repair,
                      color: ColorTheme.Green,
                      size: 50,
                    )),



              ],
            ),
            Container(
              width: 500,
              child: Divider(
                color: ColorTheme.blueGrey,
                thickness: 3,
              ),
            ),
            SizedBox(height: _size.height * 0.06),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Slot 2\n\nNot Available',
                      style: Text_Theme.style3
                          .copyWith(color: Color(0xff1a1111)),
                    ),

                  ],
                ),
                Spacer(flex: 1),



                IconButton(
                    onPressed: () async {
                      await GetIt.I<APIServices>().deleteUserById(id: widget.id);
                    },
                    icon: Icon(
                      Icons.car_repair,
                      color: ColorTheme.Red,
                      size: 50,
                    )),


              ],
            ),
            Container(
              width: 500,
              child: Divider(
                color: ColorTheme.blueGrey,
                thickness: 3,
              ),
            ),

            SizedBox(height: _size.height * 0.06),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Slot 3\n\nNot Available',
                      style: Text_Theme.style3
                          .copyWith(color: Color(0xff1a1111)),
                    ),

                  ],
                ),
                Spacer(flex: 1),



                IconButton(
                    onPressed: () async {
                      await GetIt.I<APIServices>().deleteUserById(id: widget.id);
                    },
                    icon: Icon(
                      Icons.car_repair,
                      color: ColorTheme.Red,
                      size: 50,
                    )),


              ],
            ),
            Container(
              width: 500,
              child: Divider(
                color: ColorTheme.blueGrey,
                thickness: 3,
              ),
            ),
            SizedBox(height: _size.height * 0.06),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Slot 4\n\nAvailable',
                      style: Text_Theme.style3
                          .copyWith(color: Color(0xff1a1111)),
                    ),

                  ],
                ),
                Spacer(flex: 1),



                IconButton(
                    onPressed: () async {
                      await GetIt.I<APIServices>().deleteUserById(id: widget.id);
                    },
                    icon: Icon(
                      Icons.car_repair,
                      color: ColorTheme.Green,
                      size: 50,
                    )),


              ],
            ),
            Container(
              width: 500,
              child: Divider(
                color: ColorTheme.blueGrey,
                thickness: 3,
              ),
            ),
            SizedBox(height: _size.height * 0.06),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      'Slot 5\n\nAvailable',
                      style: Text_Theme.style3
                          .copyWith(color: Color(0xff1a1111)),
                    ),

                  ],
                ),
                Spacer(flex: 1),



                IconButton(
                    onPressed: () async {
                      await GetIt.I<APIServices>().deleteUserById(id: widget.id);
                    },
                    icon: Icon(
                      Icons.car_repair,
                      color: ColorTheme.Green,
                      size: 50,
                    )),


              ],
            ),
            Container(
              width: 500,
              child: Divider(
                color: ColorTheme.blueGrey,
                thickness: 3,
              ),
            ),
            SizedBox(height: _size.height * 0.06),


          ],
        ),
      ),
    );
  }

}


