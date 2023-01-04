import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/app/modles/utils/api_services.dart';
import 'package:frontend/app/app_widgets/snackbar.dart';
import 'package:frontend/app/app_theme/Text_Theme.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';





class Dashborad extends StatefulWidget {
  const Dashborad({Key? key}) : super(key: key);

  @override
  _DashboradState createState() => _DashboradState();
}

class _DashboradState extends State<Dashborad> {
  Completer<GoogleMapController> _controller = Completer();
  final _usernameController = TextEditingController();

  CameraPosition pos = CameraPosition(
      target: LatLng(36.93995593184964, 10.223821364343166), zoom: 15);

  void getLocation() async {
    List<double> l = await GetIt.I<APIServices>().getLocation();
    LatLng _pos = LatLng(l[0], l[1]);
    setState(() {
      pos = CameraPosition(target: _pos, zoom: 18);
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _size.width * 0.067),
      height: _size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.08),
            Row(
              children: [
                Text(
                  'Parking Locator\nPlease enter your location ',
                  style: Text_Theme.style3
                      .copyWith(color: Color(0xff1a1111)),
                ),
                Spacer(),

              ],
            ),

            SizedBox(height: _size.height * 0.02),
            Container(
              height: _size.height * 0.6,
              child: GoogleMap(
                mapType: MapType.hybrid,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                trafficEnabled: true,
                initialCameraPosition: pos,
                onMapCreated: (GoogleMapController controller) {
                  getLocation();
                  _controller.complete(controller);
                },
                onLongPress: (coord) {
                  GetIt.I<APIServices>()
                      .setLocation(location: coord)
                      .then((value) {
                    if (value == true) {
                      SnackbarMessage(
                        message: "Location set",
                        icon: Icon(Icons.error, color: Colors.red),
                      ).showMessage(
                        context,
                      );
                    } else {
                      SnackbarMessage(
                        message: "Not authorized",
                        icon: Icon(Icons.error, color: Colors.red),
                      ).showMessage(
                        context,
                      );
                    }
                  });
                },
              ),
            ),
            SizedBox(height: _size.height * 0.05),
            Text(
              "Enter Parking Informations",
              style: Text_Theme.style3
                  .copyWith(color: Color(0xff1a1111)),
            ),
            SizedBox(height: _size.height * 0.05),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Parking Location',
              ),
            ),
            SizedBox(height: _size.height * 0.05),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Parking Name',
              ),
            ),
            SizedBox(height: _size.height * 0.02),
            OutlinedButton(
                child: Text('Enter'),
                onPressed: () {
                  String newUsername = _usernameController.text;
                  GetIt.I<APIServices>()
                      .updateProfile(data: {'username': newUsername});
                }),
            SizedBox(height: _size.height * 0.02),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

