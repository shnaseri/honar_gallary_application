import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

Map<String, String> header = {
  'Accept': 'application/json',
  'Content-Type': 'application/json; charset=utf-8',
};

class BaseNetworkService {
  String urlServer = "http://188.121.110.151:8000/api";

  Future<void> saveToken(String token) async {
    var _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
  }

  Future<String?> setTokenToHeader() async {
    var _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('token')) {
      header['Authorization'] = 'Bearer ' + _prefs.getString('token')!;
      return _prefs.getString('token');
    }
  }

  Future<dynamic>? postTemplate(String url, var body) async {
    try {
      var _body = convert.json.encode(body);
      http.Response response = await http.post(Uri.parse(urlServer + url),
          headers: header, body: _body);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String body = convert.utf8.decode(response.bodyBytes);
        var _jsonResponse = convert.jsonDecode(body);
        return _jsonResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic>? postTemplateWithOutHeader(String url, var body) async {
    try {
      Map<String, String> header2 = {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=utf-8',
      };
      var _body = convert.json.encode(body);
      http.Response response = await http.post(Uri.parse(urlServer + url),
          headers: header2, body: _body);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String body = convert.utf8.decode(response.bodyBytes);
        var _jsonResponse = convert.jsonDecode(body);
        return _jsonResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic>? putTemplate(String url, var body) async {
    try {
      var _body = convert.json.encode(body);
      http.Response response = await http.put(Uri.parse(urlServer + url),
          headers: header, body: _body);
      print(response.statusCode);
      ;
      print(response.body);
      print(header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String body = convert.utf8.decode(response.bodyBytes);
        var _jsonResponse = convert.jsonDecode(body);
        return _jsonResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic>? getTemplate(String url, {Map<String, dynamic>? body}) async {
    try {
      String urlOfBody = '?';
      if (body != null) {
        body.forEach((key, value) {
          urlOfBody = "$urlOfBody$key=$value&";
        });
      }
      http.Response response = await http
          .get(Uri.parse(urlServer + url + urlOfBody), headers: header);
      print(response.statusCode);
      print(response.body);
      print(response.request?.url);
      print(header['Authorization']);
      if (response.statusCode == 200) {
        String body = convert.utf8.decode(response.bodyBytes);
        var _jsonResponse = convert.jsonDecode(body);
        return _jsonResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic>? getTemplateInLink(String url, int id) async {
    try {
      print(urlServer + url + id.toString());
      http.Response response = await http
          .get(Uri.parse(urlServer + url + id.toString()), headers: header);
      print(response.body);
      if (response.statusCode == 200) {
        String body = convert.utf8.decode(response.bodyBytes);
        var _jsonResponse = convert.jsonDecode(body);
        print(_jsonResponse);
        return _jsonResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
