import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/ui/pages/change_password/state/forgot_password_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/ui/pages/change_password/state/forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  final AuthRepository authRepository;
  final AppLocalizations loc;

  ForgotPasswordBloc(this.authRepository, this.loc) : super(ForgotPasswordInitial()) {
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
        emit(ForgotPasswordFailed(loc.username_or_email_dont_exists));
      }
    }
    catch (e) {
      emit(ForgotPasswordFailed(e.toString()));
    }
  }

  Future<void> _onPasswordChange(OnPasswordChange event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    if(event.password != event.confirm){
      emit(ForgotPasswordFailed(loc.password_and_confirm_dont_match));
    }
    try{
      int changePassword = await authRepository.changePassword(event.usernameOrEmail, event.password);
      if(changePassword != 0) {
        emit(ForgotPasswordSuccess());
      } 
      else {
        emit(ForgotPasswordFailed(loc.cant_update_password));
      }
    }
    catch (e){
      emit(ForgotPasswordFailed(e.toString()));
    }
  }
}