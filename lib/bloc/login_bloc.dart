import "package:flutter_bloc/flutter_bloc.dart";
import "package:hello_world/event/login_event.dart";
import "package:hello_world/model/user_model.dart";
import "package:hello_world/repository/auth_repository.dart";
import "package:hello_world/state/login_state.dart";
import "package:shared_preferences/shared_preferences.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      User? loginSuccess = await authRepository.login(event.username, event.password);
      if(loginSuccess != null){

        final localStorage = await SharedPreferences.getInstance();
        await localStorage.setInt('userid', loginSuccess.id!);

        emit(LoginSucess());
      }
      else{
        emit(LoginFailed("Wrong username or password"));
      }
    });
  }
}