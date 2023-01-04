import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/app/modles/AvailableSlots.dart';
import 'package:frontend/app/modles/utils/oauthentication.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'baseapi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class APIServices  extends BaseAPI {
  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode({'grandType':'PASSWORD','email': email, 'password': password});
    http.Response response = await http.post(Uri.parse(super.authPath), headers: super.headers, body: body) ;

    return response;

  }



  Future<http.Response> refreshToken(String refreshToken) async {
    var body = jsonEncode({'grandType':'REFRESH_TOKEN','refreshToken': refreshToken});
    http.Response response =
    await http.post(Uri.parse(super.authPath), headers: super.headers, body: body );
    return response;
  }

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



  Future<List<AvailableSlots>> ParkingSlot({required page, required limit}) async {
    final request = RequestOptions(
      path: '/',
      contentType: 'application/json',
    );
    try {
      var resp = await GetIt.I<OAuthSettings>().authenticatedDio.get(
          "https://api.modernparker.me/users?page=$page&limit=$limit",
          options: Options(contentType: request.contentType));
      print(resp);

      return resp.data["message"].map<AvailableSlots>((e) {
        return AvailableSlots.fromJson({"ok": true, "message": e});
      }).toList();
    } on DioError catch (e) {
      var data = {
        "ok": false,
      };
      return [AvailableSlots.fromJson(data)];
    }
  }



  Future<void> updateProfile({required Map<String, dynamic> data}) async {
    final request = RequestOptions(
      path: '/',
      contentType: 'application/json',
    );
    try {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      String? id = await storage.read(key: "id");
      await GetIt.I<OAuthSettings>().authenticatedDio.patch(
          "https://api.modernparker.me/users/$id",
          data: data,
          options: Options(contentType: request.contentType));
    } on DioError catch (e) {
      print(e.response);
    }
  }



  Future<void> deleteUserById({required id}) async {
    final request = RequestOptions(
      path: '/',
      contentType: 'application/json',
    );
    try {
      await GetIt.I<OAuthSettings>().authenticatedDio.delete(
          "https://api.modernparker.me/users/$id",
          options: Options(contentType: request.contentType));
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<bool> isConnected() async {
    try {
      OAuthToken? token =
          await GetIt.I<OAuthSettings>().oauth.fetchOrRefreshAccessToken();
      return token != null ? true : false;
    } on DioError catch (e) {
      print(e.response);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
  }


  Future<List<double>> getLocation() async {
    final request = RequestOptions(
      path: '/',
      method: 'GET',
      contentType: 'application/json',
    );
    final Dio dio = Dio();
    try {
      var res = await dio.request(
          "https://api.modernparker.me/getLocation",
          options: Options(contentType: request.contentType));
      List<double> l = [res.data["message"]["lat"], res.data["message"]["lon"]];
      return l;
    } on DioError catch (e) {
      return [0, 0];
    }
  }

  Future<bool> setLocation({required LatLng location}) async {
    final request = RequestOptions(
      path: '/',
      method: 'POST',
      contentType: 'application/json',
    );
    final Dio dio = Dio();
    try {
      await await GetIt.I<OAuthSettings>().authenticatedDio.request(
          "https://api.modernparker.me/setLocation?coordinates=${location.latitude},${location.longitude}",
          options: Options(
              contentType: request.contentType, method: request.method));
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      return false;
    }
  }
}
