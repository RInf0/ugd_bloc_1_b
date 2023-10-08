class User {
  final String? name;
  final String? password;
  final String? token;
  final String? email;
  final String? no;
  final String? tglLahir;

  User({this.name, this.password, this.token, this.email, this.no, this.tglLahir});

  @override
  String toString() {
    return 'User{name: $name, password: $password, token: $token, email: $email, no: $no, tglLahir: $tglLahir}';
  }
}
