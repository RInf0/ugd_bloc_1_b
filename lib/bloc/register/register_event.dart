abstract class RegisterEvent {}

class IsPasswordVisibleChanged extends RegisterEvent {}

class FormSumitted extends RegisterEvent {
  String username;
  String password;
  String email;
  String no;
  String tglLahir;

  FormSumitted({required this.username, required this.password, required this.email,required this.no, required this.tglLahir});
}