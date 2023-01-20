import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
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
    //var uId;
    //dynamic user = SessionManager().get("userId").then((value) => uId=value);
    var   response = await http.post(Uri.parse(super.reserveslotpath), headers:super.headers, body: body);
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