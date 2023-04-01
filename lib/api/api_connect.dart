import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import '../storage/storage.dart';
import 'api_models.dart';

final _base = "http://192.168.10.117:8000";
final _signInURL = "/token/";
final _signUpEndpoint = "/api/register/";
final _newsListEndPoint = "/api/news/";
final _newsList = _base + _newsListEndPoint;
final _login = _base + _signInURL;

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

Future<void> newApi() async {
  final http.Response response = await http.get(
    Uri.parse(_login),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    );

  if (response.statusCode == 200) {
    
  } else {
    throw Exception(json.decode(response.body));
  }
}