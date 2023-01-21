import 'package:flutter_session_manager/flutter_session_manager.dart';

class BaseAPI{

  static String base = "https://api.modernparker.me:8443";
  static var api = base + "/modernparker-1.0/api";
  //var authPath = api + "/oauth2/token/";
  var authPath = "https://api.modernparker.me:8443/modernparker-1.0/api/oauth2/token/";
  //register path
  var registerPath=api+"/signup" ;
//resources path
var apisPath = api + "/user";
//reservation path
var reservationpath = api + "/reservation/";
//slot path
  var slotspath = "https://api.modernparker.me:8443/modernparker-1.0/api/parking/allemptyslots/1";
//reserveslot path
  var addreserveslotpath="https://api.modernparker.me:8443/modernparker-1.0/api/reservation/add/";
//addvehicule path
  //dynamic user = SessionManager().get("userId").then((value) => print("$value"));

  var addvehiculepath = "https://api.modernparker.me:8443/modernparker-1.0/api/vehicle/";
//

// headers
Map<String,String> headers = {
  "Content-Type": "application/json; charset=UTF-8" };


  Map<String,String> headersAuth = {
    "Content-Type": "application/x-www-form-urlencoded"  };

  //BaseAPI(super.accessToken, super.refreshToken, super.userId);

  Map<String,String> createProtectedHeader(String accestoken){

    var headersProtected = {
      "Authorization":"Bearer $accestoken",
      "Content-Type": "application/json; charset=UTF-8",
      "Accept":"application/json"
    };
    return  headersProtected ;


  }

}