import 'package:blog_application/API/Models/categoryresponse.dart';
import 'package:blog_application/API/Models/contactresponse.dart';
import 'package:blog_application/API/Models/detailsreponse.dart';
import 'package:blog_application/API/Models/homeresponse.dart';
import 'package:blog_application/API/Models/loginresponse.dart';
import 'package:blog_application/API/Models/mediaresponse.dart';
import 'package:blog_application/API/Models/notificationresponse.dart';
import 'package:blog_application/API/Models/registerresponse.dart';
import 'package:blog_application/base/sharedpreferences/pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Api {
  String startUrl = "http://steverao.com/steveraoapis/";
  String device = '';
  //Login Api

  Future<dynamic> LoginAPI(
      {required String email, required String password, required String location}) async {
    CircularProgressIndicator();
    getToken();
    String url = startUrl + 'loginapi';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = getToken() as String?;
    debugPrint("LoginAPI DeviceToken:$device");
    final param = {
      "email": email,
      "password": password,
      "token": device,
    };
    String queryString = Uri(queryParameters: param).query;
    debugPrint("URL:$queryString");
    var requestUrl = url + '?' + queryString;
    var response = await http.get(
      Uri.parse(requestUrl),
    );
    if (response.statusCode == 200) {
      final responseJsonAll = jsonDecode(response.body);
      final LoginData loginResponse = LoginData.fromJson(responseJsonAll);
      return loginResponse;
    } else {
      debugPrint('Error!:' + response.statusCode.toString());
      return null;
    }
  }

  Future<void> getToken() async {
    String? dt = await Pref().getStringValuesSF(key: 'DeviceToken');
    debugPrint("DeviceToken:$dt");
    device = dt!;
  }

  //Register API
  Future<dynamic> RegisterAPI(
      {required String name,
      required String email,
      required String password,
      required String mobile}) async {
    String url = startUrl + 'registerapi';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("DeviceToken");
    debugPrint("DeviceToken:$token");
    final param = {
      "name": name,
      "email": email,
      "password": password,
      "mobile": mobile,
      "devicetoken": token,
    };
    var response = await http.post(Uri.parse(url), body: param);
    if (response.statusCode == 200) {
      final responseJsonAll = jsonDecode(response.body);
      final RegisterResponse registerResponse = RegisterResponse.fromJson(responseJsonAll);
      return registerResponse;
    } else {
      debugPrint('Error!:' + response.statusCode.toString());
      return null;
    }
  }

  //HomeScreenAPI
  Future<dynamic> HomeAPI() async {
    String url = startUrl + 'homeapi';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseJsonAll = jsonDecode(response.body);
      final HomeResponse homeResponse = HomeResponse.fromJson(responseJsonAll);
      return homeResponse;
    } else {
      debugPrint('Error!:' + response.statusCode.toString());
      return null;
    }
  }

  //NotificationAPI
  Future<dynamic> NotificationAPI() async {
    String url = startUrl + 'notificationsapi';
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseJsonAll = jsonDecode(response.body);
      final NotificationResponse notificationResponse =
          NotificationResponse.fromJson(responseJsonAll);
      return notificationResponse;
    } else {
      debugPrint('Error!:' + response.statusCode.toString());
      return null;
    }
  }

  //CategoriesAPI
  Future<dynamic> CategoriesAPI({required String categorytype}) async {
    CircularProgressIndicator();
    String url = startUrl + 'categoriesapi';
    final param = {
      "categorytype": categorytype,
    };
    String queryString = Uri(queryParameters: param).query;
    var requestUrl = url + '?' + queryString;
    var response = await http.get(
      Uri.parse(requestUrl),
    );
    if (response.statusCode == 200) {
      final responseJsonAll = jsonDecode(response.body);
      debugPrint("statement:" + response.body.toString());
      final CategoryResponse detailsResponse = CategoryResponse.fromJson(responseJsonAll);
      return detailsResponse;
    } else {
      debugPrint('Error!:' + response.statusCode.toString());
      return null;
    }
  }

  //CategoriesDetailAPI
  Future<dynamic> CategoriesDetailAPI({required String type, required String call}) async {
    CircularProgressIndicator();
    String url = startUrl + 'detailsapi';
    Map<String, String> param;
    if (call == "Blog") {
      param = {
        "type": type,
        "subtype": 'blog',
      };
    } else {
      param = {
        "type": type,
      };
    }

    String queryString = Uri(queryParameters: param).query;
    debugPrint("queryString:$queryString");
    var requestUrl = url + '?' + queryString;
    var response = await http.get(
      Uri.parse(requestUrl),
    );
    if (response.statusCode == 200) {
      final responseJsonAll = jsonDecode(response.body);
      DetailsResponse detailsResponse = DetailsResponse.fromJson(responseJsonAll);
      return detailsResponse;
    } else {
      debugPrint('Error!:' + response.statusCode.toString());
      return null;
    }
  }

  //ContactAPI
  Future<dynamic> ContactAPI(
      {required String subject,
      required String message,
      required String? name,
      required String? email}) async {
    String url = startUrl + 'contactapi';
    final param = {
      "subject": subject,
      "message": message,
      "name": name,
      "email": email,
    };
    var response = await http.post(Uri.parse(url), body: param);
    if (response.statusCode == 200) {
      final responseJsonAll = jsonDecode(response.body);
      final ContactResponse contactResponse = ContactResponse.fromJson(responseJsonAll);
      return contactResponse;
    } else {
      debugPrint('Error!:' + response.statusCode.toString());
      return null;
    }
  }
}
