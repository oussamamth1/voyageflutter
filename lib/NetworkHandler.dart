import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  static const baseurl = "http://192.168.1.25:3000";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get(String url) async {
    String token = await storage.read(key: "access_token");
    url = formater(url);
    // /user/register
    print(token);
    log.i(token, "token hhhhhhhhhhhhhhhhhhhhhr");
    var response = await http.get(
      Uri.parse(url as String),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body, "the response of get");

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    log.d(json.encode(body), url);
    String token = await storage.read(key: "access_token");
    var response = await http.post(
      Uri.parse(url as String),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      // headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String token = await storage.read(key: "access_token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      Uri.parse(url as String),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    log.d(response);
    return response;
  }

  Future<http.Response> post1(String url, var body) async {
    // String token = await storage.read(key: "access_token");
    // url = formater(url);
    // log.d(body);
    var response = await http.post(
      Uri.parse(url as String),
      headers: {
        "Content-type": "application/json",
        // "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    print(url);
    String token = await storage.read(key: "access_token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName)  {
//  String token =  storage.read(key: "access_token") as String;
    String url = formater(
        "/api/v1/profile/img/Screenshot(121)02afd54e-be99-4099-9202-bc7decc96320.png");
    return NetworkImage(url,
      headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MkBnbWFpbC5jb20iLCJ1c2VybmFtZSI6InRlc3QyIiwiaWF0IjoxNjc2NjI0ODE1fQ.LnWOUdIvlcv-1DN6-6GlYh_sL5-sPycrArx-FOED7xg"},
    );
  }

  NetworkImage getImage1(String imageName) {
    String url = formater("$imageName.jpg");
    return NetworkImage(url);
  }
}
