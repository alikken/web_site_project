import 'package:mobileapp/storage/storage.dart';

import '../api/api_connect.dart';
import '../api/api_models.dart';

class HomeController {
  Future<void> loginUser(String username, String password) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    await loginApi(userLogin);
    SecureStorage storage = SecureStorage();
    storage.addUsernameToDb(username);
  }
}