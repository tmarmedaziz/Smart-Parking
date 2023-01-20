import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modern_parker/app/modles/util/parking_features.dart';
import '../modles/reservation.dart';


Widget dashbordComponent(BuildContext context , Color color, Slot  slot, ResourceApi resourceApi ) {
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
  Navigator.pushNamed(context,'Addvehicule',arguments:{
  'accessToken':resourceApi.accessToken,
  'refreshToken':resourceApi.refreshToken,
    'userId': resourceApi.userId
  });
  },
  child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children:  <Widget>[
    Text(
      "Slot ID: ",
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22.0
      ),
    ),
  Text(
  '${slot.id}',
  style: const  TextStyle(
  color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22.0
  ),
  ),
    Text(
      "Slot State: ",
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22.0
      ),
    ),
    Text(
      "${slot.state}",
      style: TextStyle(
          color: Colors.white,
          fontSize: 22
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



