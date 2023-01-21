import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modern_parker/app/modles/util/parking_features.dart';
import '../modles/reservation.dart';


Widget dashbord2Component(BuildContext context , Color color, Reservation  reservation, ResourceApi resourceApi ) {


  return Column(
    children: <Widget>[
      Expanded(
        child: SizedBox(
          width:200.0,
          height: 200.0,
          child: Card(
            color: color,
            elevation: 9.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            ),
            child:Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed:(){

                    Navigator.pushNamed(context,'dashboard',arguments:{
                      'accessToken':resourceApi.accessToken,
                      'refreshToken':resourceApi.refreshToken,
                      'userId': resourceApi.userId
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  <Widget>[
                      Text(
                        "Vehicle ID: ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                      ),
                      Text(
                        '${reservation.vehicleId}',
                        style: const  TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                      ),
                      Text(
                        "Slot ID: ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                      ),
                      Text(
                        "${reservation.slotId}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    ],
  );

}


