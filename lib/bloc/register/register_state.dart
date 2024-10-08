import 'package:ugd_bloc_1_b/bloc/form_submission_state.dart';

class RegisterState {
  final bool isPasswordVisible;
  final FormSubmissionState formSubmissionState;

  RegisterState({
    // true => invisible at first
    this.isPasswordVisible = true,
    this.formSubmissionState = const InitialFormState(),
  });

  RegisterState copyWith({
    bool? isPasswordVisible,
    FormSubmissionState? formSubmissionState,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
