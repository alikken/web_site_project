import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/cinema.dart';
import '../storage/storage.dart';
import 'api_models.dart';

final _base = "http://192.168.1.6:8000";
final _signInURL = "/api/token/";
final _registrationEndpoint = "/api/registration/";

final _login = _base + _signInURL;
final _registration = _base + _registrationEndpoint;

Future<void> loginApi(UserLogin userLogin) async {
  final http.Response response = await http.post(
    Uri.parse(_login),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );

  if (response.statusCode == 200) {
    Token token = Token.fromJson(json.decode(response.body));

    SecureStorage storage = SecureStorage();
    storage.addTokenToDb(token.token, token.refreshToken);
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<List> registrationApi(UserRegistration userRegistration) async {
  final http.Response response = await http.post(
    Uri.parse(_registration),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userRegistration.toDatabaseJson()),
  );
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  return result;
}

Future<List<dynamic>> theaterApi() async {
  var asd = await SecureStorage().getUsername();
  String url = 'http://192.168.1.6:8000/api/cinema/';
  if (asd != null) {
    url = url + '?username=' + asd;
    print("fSFSfsefesfsef ${url}");
  }
  http.Response response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));

// Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
//   List<dynamic> result = jsonResponse.values.toList();

  return result;
}
