import 'package:ugd_bloc_1_b/repository/register_repository.dart';

import '../model/user.dart';

class FailedLogin implements Exception {
  String errorMessage() {
    return "Login Failed";
  }
}

class LoginRepository {
  Future<User> login(String username, String password) async {
    // print("Logining...");
    User userData = User();
    await Future.delayed(const Duration(seconds: 3), () {
      if (username == '' || password == '') {
        throw 'Username or password cannot be empty';
      }
      for (User user in GlobalVariable.listUsers) {
        if (user.name == username && user.password == password) {
          userData = User(name: username, password: password, token: "12345");
          return userData; //Sebuah process permintaan ke server
        }
      }
      throw FailedLogin();
    }); //Process request dan response
    return userData;
  }
}
