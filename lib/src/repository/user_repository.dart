import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:order_client_app/src/models/tos.dart';
import 'package:order_client_app/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

User currentUser = new User();
Tos tos = new Tos();

final String _apiToken = 'api_token=${currentUser.apiToken}';

Future<User> loginUser(User user) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}login';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMapLogin()),
  );

  if (response.statusCode == 200 &&
      json.decode(response.body)['data'].toString().contains("name")) {
    user = User.fromJSON(json.decode(response.body)['data']);
    return user;
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    user.message = json.decode(response.body)['message'].toString();
    return user;
  } else {
    try {
      user.message = jsonDecode(response.body)['message'].toString();
    } on Exception catch (exception) {
      user.message = "error";
    } catch (error) {
      user.message = "خطا";
    }
    return user;
  }
}

Future<Tos> getTos() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}/tos';
  final client = new http.Client();
  final response = await client.get(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    // body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200) {
    tos = Tos.fromJson(json.decode(response.body)['data']);
    return tos;
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    tos.message = "حدث خطأ ما";
    return tos;
  } else {
    tos.message = jsonDecode(response.body)['data'].toString();
    return tos;
  }
}

Future<User> restPassFirstStep(User user) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}password/email';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200 &&
      response.body.toString().contains("activation")) {
    user.message = "تم استعاده كلمه المرور على الايميل";
    return user;
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    user.message = "اسم المستخدم او كلمه المرور خطأ";
    return user;
  } else {
    user.message = "خطأ";
    return user;
  }
}

Future<User> register(User user) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}/register';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser = User.fromJSON(json.decode(response.body)['data']);
  }

  if (response.statusCode == 200 &&
      response.body.toString().contains("api_token")) {
    setCurrentUser(response.body);
    currentUser = User.fromJSON(json.decode(response.body)['data']);
    return currentUser;
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    currentUser.message = "حدث خطأ بالاتصال";
    return currentUser;
  } else {
    currentUser.message = jsonDecode(response.body)['data'].toString();
    return currentUser;
  }
}

Future<void> logout() async {
  currentUser = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('current_user', jsonString);
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.clear();
  if (prefs.containsKey('current_user')) {
    currentUser = User.fromJSON(json.decode(await prefs.get('current_user')));
  }
  return currentUser;
}

Future<User> saveToken(String token) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}fcm/save';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${currentUser?.apiToken}"
    },
    body: json.encode({
      'device_token': token,
    }),
  );
  currentUser = User.fromJSON(json.decode(response.body)['data']);
  return currentUser;
}

Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}users?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMapUploadImage()),
  );
  // setCurrentUser(response.body);
  return User.fromJSON(json.decode(response.body)['data']);
}
