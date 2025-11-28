import "package:flutter_bloc/flutter_bloc.dart";
import "package:hello_world/l10n/app_localizations.dart";
import "package:hello_world/service/get_it/get_it.dart";
import "package:hello_world/ui/pages/login/state/login_event.dart";
import "package:hello_world/service/sqlite/model/user_model.dart";
import "package:hello_world/repository/auth_repository.dart";
import "package:hello_world/ui/pages/login/state/login_state.dart";
import "package:shared_preferences/shared_preferences.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository authRepository;
  final AppLocalizations loc;

  LoginBloc(this.authRepository, this.loc) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      User? loginSuccess = await authRepository.login(event.username, event.password);
      if(loginSuccess != null){

        getIt<SharedPreferences>().setInt('userid', loginSuccess.id!);

        emit(LoginSucess());
      }
      else{
        emit(LoginFailed(loc.wrong_username_or_password));
      }
    });
  }
}