import 'package:jwt_decoder/jwt_decoder.dart';

class UserLogin {
  String username;
  String password;

  UserLogin({required this.username, required this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"username": this.username, "password": this.password};
}

class Token {
  String token;
  String refreshToken;

  Token({required this.token, required this.refreshToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        token: json['access'].toString(),
        refreshToken: json['refresh'].toString());
  }

  Map<String, dynamic> fetchUser(String token) {
    Map<String, dynamic> userCreds = JwtDecoder.decode(token);

    return userCreds;
  }
}

class UserRegistration {
  String username;
  String email;
  String password1;
  String password2;

  UserRegistration({
    required this.username,
    required this.email,
    required this.password1,
    required this.password2,
  });

  Map<String, dynamic> toDatabaseJson() => {
        "username": username,
        "email": email,
        "password1": password1,
        "password2": password2,
      };
}
