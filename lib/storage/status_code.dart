class UserLoginStatusCode {
  int name;
  late String message;
  UserLoginStatusCode({required this.name});

  factory UserLoginStatusCode.fromName(int name) {
    UserLoginStatusCode statusCode = UserLoginStatusCode(name: name);
    if (statusCode.name == 200) {
      statusCode.message = '';
    } else if (statusCode.name == 401) {
      statusCode.message = 'Ошибка в имени пользователя или пароле';
    } else {
      statusCode.message = 'Неизвестаня ошибка';
    }
    return statusCode;
  }
}