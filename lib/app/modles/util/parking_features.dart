import 'dart:convert';
import 'package:modern_parker/app/modles/util/baseapi.dart';
import '../reservation.dart';
 import 'package:http/http.dart' as http;
 import 'dart:convert' as convert;
 class ResourceApi  extends BaseAPI{
 String  accessToken  ;
 String refreshToken ;
 ResourceApi(this.accessToken,this.refreshToken);
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
   Future<List> getReservationsByIdUser(String email) async{ //Get user reservations
     var response  =await http.get(Uri.parse(super.reservationpath+"/user/"+email),headers:super.createProtectedHeader(accessToken)) ;
     if(response.statusCode==200){
       var jsonResponse = convert.jsonDecode(response.body) as List ;
       List responseList=[] ;
       jsonResponse.forEach((element) {
         Reservation reservation = Reservation(element["id"], element["reservation"], element["userId"], element["vehicleId"], element["slotId"]);
         responseList.add(reservation) ;
       });
       return responseList as List ;
     }else {
       print('Request failed with status: ${response.statusCode}.');
       return [] ;
     }
   }

   //addvehicule
   Future addvehicule(  String  vehicleNumber , String  vehicleCategory, String vehicleDescription) async {
     var body = jsonEncode({
       'vehicleNumber': vehicleNumber,
       'vehicleCategory': vehicleCategory,
       'vehicleDescription': vehicleDescription,
     });
     var   response = await http.post(Uri.parse(super.addvehiculepath), headers:super.createProtectedHeader(accessToken), body: body);
     return response ;
   }
   //reserveslot
   Future reservationslot(  String  id , String  reservation) async {
     var body = jsonEncode({
       'id': id,
       'reservation': reservation,
     });
     var   response = await http.post(Uri.parse(super.reserveslotpath), headers:super.createProtectedHeader(accessToken), body: body);
     return response ;
   }
}
