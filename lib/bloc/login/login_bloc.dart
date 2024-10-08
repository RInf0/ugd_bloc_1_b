import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ugd_bloc_1_b/bloc/form_submission_state.dart';
import 'package:ugd_bloc_1_b/bloc/login/login_event.dart';
import 'package:ugd_bloc_1_b/bloc/login/login_state.dart';
import 'package:ugd_bloc_1_b/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = LoginRepository();
  LoginBloc() : super(LoginState()) {
    on<IsPasswordVisibleChanged>(
        (event, emit) => _onIsPasswordVisibleChanged(event, emit));
    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
  }
  void _onIsPasswordVisibleChanged(
      IsPasswordVisibleChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
      formSubmissionState: const InitialFormState(),
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formSubmissionState: FormSubmitting()));
    try {
      await loginRepository.login(event.username, event.password);
      emit(state.copyWith(formSubmissionState: SubmissionSuccess()));
    } on FailedLogin catch (e) {
      emit(state.copyWith(
          formSubmissionState: SubmissionFailed(e.errorMessage())));
    } on String catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e)));
    } catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e.toString())));
    }
  }
}
