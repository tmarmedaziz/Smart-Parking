

class BaseAPI{

  static String base = "https://api.modernparker.me:8443";
  static var api = base + "/modernparker-1.0/api";
//authentication path
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
  var reserveslotpath = "https://api.modernparker.me:8443/modernparker-1.0/api/reservation/add/test9@supcom.tn/1/1";
//addvehicule path
  var addvehiculepath = "https://api.modernparker.me:8443/modernparker-1.0/api/vehicle/karahba";

// headers
Map<String,String> headers = {
  "Content-Type": "application/json; charset=UTF-8" };


  Map<String,String> headersAuth = {
    "Content-Type": "application/x-www-form-urlencoded"  };

  Map<String,String> createProtectedHeader(String accestoken){

    var headersProtected = {
      "Authorization":"Bearer $accestoken",
      "Content-Type": "application/json; charset=UTF-8",
      "Accept":"application/json"
    };
    return  headersProtected ;


  }

}