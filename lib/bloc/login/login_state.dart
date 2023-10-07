import 'package:ugd_bloc_1_b/bloc/form_submission_state.dart';

class LoginState {
  final bool isPasswordVisible;
  final FormSubmissionState formSubmissionState;

  LoginState({
    // true => invisible at first
    this.isPasswordVisible = true,
    this.formSubmissionState = const InitialFormState(),
  });

  LoginState copyWith({
    bool? isPasswordVisible,
    FormSubmissionState? formSubmissionState,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
