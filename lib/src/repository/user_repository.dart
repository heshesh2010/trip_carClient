import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_car_client/generated/json/user_entity_helper.dart';
import 'package:trip_car_client/src/models/tos.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

ValueNotifier<UserDataUser> currentUser = new ValueNotifier(UserDataUser());

Tos tos = new Tos();

final String _apiToken = 'api_token=${currentUser.value.apiToken}';

Future<UserDataUser> loginUser(UserDataUser user) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}login';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toJson()),
  );

  if (response.statusCode == 200 &&
      json.decode(response.body)['data']['user'].toString().contains("name")) {
    return UserDataUser().fromJson(json.decode(response.body)['data']['user']);
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    currentUser.value.message = json.decode(response.body)['error'].toString();
    return currentUser.value;
  } else {
    try {
      currentUser.value.message = jsonDecode(response.body)['error'].toString();
    } on Exception catch (exception) {
      currentUser.value.message = "error";
    } catch (error) {
      currentUser.value.message = "خطا";
    }
    return currentUser.value..message = "خطا";
  }
}

Future<Tos> getTos() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}tos';
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

Future<String> restPassFinalStep(UserDataUser user) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}change_password';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    },
    body: json.encode(user.toJson()),
  );

  if (response.statusCode == 200 &&
      response.body.toString().contains("successfully")) {
    return "successfully";
  } else if (response.statusCode == 401 ||
      response.statusCode == 404 ||
      response.statusCode == 302 ||
      response.statusCode == 422) {
    return "الرمز الذي ادخلته غير صحيح";
  } else {
    return "الرمز الذي ادخلته غير صحيح";
  }
}

Future<String> restPassFirstStep(UserDataUser user) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}reset_password';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    },
    body: json.encode(user.toJson()),
  );

  if (response.statusCode == 200 &&
      response.body.toString().contains("check your email")) {
    return "true";
  } else if (response.statusCode == 401 ||
      response.statusCode == 404 ||
      response.statusCode == 302 ||
      response.statusCode == 422) {
    return "الحساب غير موجود";
  } else {
    return "خطأ";
  }
}

Future<UserDataUser> register(UserDataUser user) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}register';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    },
    body: json.encode(userDataUserToJsonReg(user)),
  );

  if (response.statusCode == 200 &&
      response.body.toString().contains("api_token")) {
    //setCurrentUser(response.body);
    currentUser.value =
        UserDataUser().fromJson(json.decode(response.body)['data']);
    return currentUser.value;
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    currentUser.value.message = "حدث خطأ بالاتصال";
    return currentUser.value;
  } else {
    currentUser.value.message = jsonDecode(response.body)['data'].toString();
    return currentUser.value;
  }
}

Future<void> logout() async {
  currentUser.value = new UserDataUser();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('current_user', jsonString);
}

Future<UserDataUser> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (prefs.containsKey('current_user')) {
    currentUser.value =
        UserDataUser().fromJson(json.decode(await prefs.get('current_user')));
    print(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<UserDataUser> saveToken(String token) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';

  final String url =
      '${GlobalConfiguration().getString('api_base_url')}save_token?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: json.encode({
      'device_token': token,
    }),
  );
  currentUser.value =
      UserDataUser().fromJson(json.decode(response.body)['data']);
  return currentUser.value;
}

Future<UserDataUser> update(UserDataUser user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}edit/profile?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    },
    body: json.encode(userDataUserToJsonUpdate(user)),
  );
  print(UserDataUser().fromJson(json.decode(response.body)['data']));
  if (response.statusCode == 200 &&
      json.decode(response.body)['data'].toString().contains("api_token")) {
    return UserDataUser().fromJson(json.decode(response.body)['data']);
    print(UserDataUser().fromJson(json.decode(response.body)['data']));
  } else if (response.statusCode == 401 || response.statusCode == 404) {
    currentUser.value.message =
        json.decode(response.body)['password'].toString();
    return currentUser.value;
  } else {
    try {
      currentUser.value.message =
          jsonDecode(response.body)['password'].toString();
    } on Exception catch (exception) {
      currentUser.value.message = "error";
    } catch (error) {
      currentUser.value.message = "خطا";
    }
    return currentUser.value..message = "خطا";
  }
}
