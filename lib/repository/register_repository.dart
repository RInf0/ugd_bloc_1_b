import '../model/user.dart';

class FailedLogin implements Exception {
  String errorMessage() {
    return "Register Failed";
  }
}

// variabel global
class GlobalVariable {
  static List<User> listUsers = [];
}

class RegisterRepository {
  Future<User> register(String username, String password, String email,
      String no, String tglLahir) async {
    // print("Register...");
    User userData = User();
    await Future.delayed(const Duration(seconds: 3), () {
      if (username == '' ||
          password == '' ||
          email == '' ||
          no == '' ||
          tglLahir == '') {
        throw 'Harap Isi Semua Field';
      } else if (username.isNotEmpty &&
          password.isNotEmpty &&
          email.isNotEmpty &&
          no.isNotEmpty &&
          tglLahir.isNotEmpty) {
        userData = User(
            name: username,
            password: password,
            email: email,
            no: no,
            tglLahir: tglLahir);
        GlobalVariable.listUsers.add(userData);
      } else {
        throw FailedLogin();
      }
    }); //Process request dan response
    return userData;
  }
}
