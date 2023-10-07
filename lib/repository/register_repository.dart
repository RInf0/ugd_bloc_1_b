import '../model/user.dart';

class FailedLogin implements Exception{
  String errorMessage(){
    return "Login Failed";
  }
}

class RegisterRepository{
  Future<User> register(String username, String password, String email, String no) async{
    print("Logining...");
    User userData = User();
    await Future.delayed(const Duration(seconds: 3), () {
      /*if(this.username == username && this.password == password){
        userData = User(
          name: username,
          password: password,
          token: "12345"); //Sebuah process permintaan ke server
      }else if(username == '' || password == ''){
        throw 'Username or password cannot be empty';
      }else{
        throw FailedLogin();
      }*/
    }); //Process request dan response
    return userData;
  }
}