import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ugd_bloc_1_b/bloc/form_submission_state.dart';
import 'package:ugd_bloc_1_b/bloc/register/register_event.dart';
import 'package:ugd_bloc_1_b/bloc/register/register_state.dart';
import 'package:ugd_bloc_1_b/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository = RegisterRepository();
  RegisterBloc() : super(RegisterState()) {
    on<IsPasswordVisibleChanged>((event, emit) => _onIsPasswordVisibleChanged(event, emit));
    on<FormSumitted>((event, emit) => _onFormSubmitted(event, emit));
  }

  void _onIsPasswordVisibleChanged(IsPasswordVisibleChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
      formSubmissionState: const InitialFormState(),
    ));
  }
  
  void _onFormSubmitted(FormSumitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(formSubmissionState:  FormSubmitting()));
    try{
      await registerRepository.register(event.username, event.password, event.email, event.no, event.tglLahir);
      emit(state.copyWith(formSubmissionState: SubmissionSuccess()));
    } on FailedLogin catch (e){
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e.errorMessage())));
    } on String catch (e){
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e)));
    } catch (e){
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e.toString())));
    }
  }
}