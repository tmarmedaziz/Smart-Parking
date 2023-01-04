class BaseAPI{

  static String base = "https://api.modernparker.me:8443";
  static var api = base + "/modernparker-1.0/api";
//authentication path
var authPath = api + "/oauth2/token/";
//resources path
var apisPath = api + "/user";
//register path
var registerPath=api+"/signup" ;

// more routes
Map<String,String> headers = {
  "Content-Type": "application/json; charset=UTF-8" };


  Map<String,String> headersAuth = {
    "Content-Type": "application/x-www-form-urlencoded"  };

  Map<String,String> createProtectedHeader(String accestoken){

    var headersProtected = {
      "Authorization":"Bearer $accestoken"
    };
    return  headersProtected ;


  }

}