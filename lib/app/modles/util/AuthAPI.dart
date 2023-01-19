import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modern_parker/app/modles/util/baseapi.dart';



class AuthAPI extends BaseAPI {
  //signup
  Future signUp(  String  email , String  forname , String surname , String password) async {
    var body = jsonEncode({
        'forname': forname,
        'surname': surname,
        'email': email,
        'password': password,
        'roles': ["ADMIN"]

    });
       var   response = await http.post(Uri.parse(super.registerPath), headers: super.headers, body: body);
        return response ;
  }

  //login
  Future<http.Response> login(String email, String password) async {
    var body = {'grand_type':'password','email': email, 'password': password};
    http.Response response = await http.post(Uri.parse(super.authPath), headers: super.headersAuth, body: body) ;
    return response;

  }
//reserveslot
  Future reservationslot(  String  id , String  reservation) async {
    var body = jsonEncode({
      'id': id,
      'reservation': reservation,
    });
    var   response = await http.post(Uri.parse(super.reserveslotpath), headers:super.headers, body: body);
    return response ;
  }
  //addvehicule
  Future addvehicule(  String  vehicleNumber , String  vehicleCategory, String vehicleDescription) async {
    var body = jsonEncode({
      'vehicleNumber': vehicleNumber,
      'vehicleCategory': vehicleCategory,
      'vehicleDescription': vehicleDescription,
    });
    var   response = await http.post(Uri.parse(super.addvehiculepath), headers:super.headers, body: body);
    return response ;
  }
  //Booking history
  Future<http.Response> BookinghistoryPage(String email, String password) async {
    var body = {'grand_type':'password','email': email, 'password': password};
    http.Response response = await http.post(Uri.parse(super.authPath), headers: super.headersAuth, body: body) ;
    return response;

  }
 //refreshtoken
  Future<http.Response> refreshToken(String refreshToken) async {
    var body = jsonEncode({'grand_type':' refresh_token','refresh_token': refreshToken});
    http.Response response =
    await http.post(Uri.parse(super.authPath), headers: super.headersAuth, body: body );
    return response;
  }




}