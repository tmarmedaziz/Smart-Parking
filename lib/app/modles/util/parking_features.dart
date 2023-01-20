import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:modern_parker/app/modles/util/baseapi.dart';
import '../reservation.dart';
 import 'package:http/http.dart' as http;
 import 'dart:convert' as convert;
import 'package:modern_parker/app/modles/Tokens.dart';

class ResourceApi  extends BaseAPI{
 String  accessToken  ;
 String refreshToken ;
 String userId;
 ResourceApi(this.accessToken,this.refreshToken, this.userId);

//get request
   Future<List> Getallreservations()  async{ //Get all reservations GET (ADMIN)
     var response  =await http.get(Uri.parse(super.reservationpath),headers:super.createProtectedHeader(accessToken))  ;
    //
     if(response.statusCode==200){
       print("response code 200");
       var jsonResponse = convert.jsonDecode(response.body) as List ;
       print(jsonResponse);
       List responseList=[] ;
       jsonResponse.forEach((element) {
         print(element);
         print(element["id"]);
         Reservation reservation = Reservation(element["userId"], element["reservation"], element["id"], element["vehicleId"], element["slotId"]);
         responseList.add(reservation) ;
       });
       print("Printing the list of reservations");
       print(responseList.length);
        return responseList as List ;
     }else {
       print('Request failed with status: ${response.statusCode}.');
       return [] ;
     }

  }
   //get available slots
   Future<List> emptyslots()  async{ //Get all EMPTY slots  (ADMIN)
     var response  =await http.get(Uri.parse(super.slotspath),headers:super.createProtectedHeader(accessToken))  ;
     //
     if(response.statusCode==200){
       print("response code 200");
       var jsonResponse = convert.jsonDecode(response.body) ;
       print([jsonResponse]);
       List responseList=[] ;
       [jsonResponse].forEach((element) {
         element.forEach((key, value) {
           print(element);
           Slot slot = Slot(key, value);
           responseList.add(slot);
         });
       });
       print("Printing the list of available slots");
       print(responseList.length);
       return responseList as List ;
     }else {
       print('Request failed with status: ${response.statusCode}.');
       return [] ;
     }

   }
//get request
   Future<List> getReservationsByIdUser(String userId) async{
     print(userId);
     var reservationsbyuser = "https://api.modernparker.me:8443/modernparker-1.0/api/reservation/user/$userId";
     var response  = await http.get(Uri.parse(reservationsbyuser),headers:super.createProtectedHeader(accessToken)) ;
     if(response.statusCode==200){
       var jsonResponse = convert.jsonDecode(response.body) as List ;
       List responseList=[] ;
       jsonResponse.forEach((element) {
         Reservation reservation = Reservation(element["userId"], element["reservation"], element["id"], element["vehicleId"], element["slotId"]);
         responseList.add(reservation) ;
       });
       return responseList as List ;
     }else {
       print('Request failed with status: ${response.statusCode}.');
       return [] ;
     }
   }

   //addvehicule
  Future<http.Response> addvehicule(String vehicleNumber, String vehicleCategory, String vehicleDescription) async {
    var vehiculepath = addvehiculepath + userId;
    var body = jsonEncode({
      'vehicleNumber': vehicleNumber,
      'vehicleCategory': vehicleCategory,
      'vehicleDescription': vehicleDescription,
    });
    var response = await http.post(Uri.parse(vehiculepath),headers: super.createProtectedHeader(accessToken), body: body);
    return response;
  }
  //var response1 = SessionManager().get("userId").then((value) {

  // print("-------------------$body----------------");
  //var uri = super.addvehiculepath + value;
   //addslotreservation
   Future reservationslot(  String  id , String  reservation) async {
     var reservationpath = addreserveslotpath + userId + "/1/6";
     var body = jsonEncode({
       'id': id,
       'reservation': reservation,
     });
     var   response = await http.post(Uri.parse(reservationpath), headers:super.createProtectedHeader(accessToken), body: body);
     return response ;
   }
}
