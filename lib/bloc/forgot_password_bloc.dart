import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/event/forgot_password_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/state/forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  final AuthRepository authRepository;

  ForgotPasswordBloc(this.authRepository) : super(ForgotPasswordInitial()) {
    on<OnUsernameSearch>(_onUsernameSearch);
    on<OnPasswordChange>(_onPasswordChange);
  }

  Future<void> _onUsernameSearch(OnUsernameSearch event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try{
      bool usernameExists = await authRepository.userExists(event.usernameOrEmail);
      if(usernameExists){
        emit(ForgotPasswordChangePassword());
      }
      else{
        emit(ForgotPasswordFailed("Username or Email don't exists"));
      }
    }
    catch (e) {
      emit(ForgotPasswordFailed(e.toString()));
    }
  }

  Future<void> _onPasswordChange(OnPasswordChange event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    if(event.password != event.confirm){
      emit(ForgotPasswordFailed("Password and Confirm password don't match"));
    }
    try{
      int changePassword = await authRepository.changePassword(event.usernameOrEmail, event.password);
      if(changePassword != 0) {
        emit(ForgotPasswordSuccess());
      } 
      else {
        emit(ForgotPasswordFailed("Can't update password"));
      }
    }
    catch (e){
      emit(ForgotPasswordFailed(e.toString()));
    }
  }
}