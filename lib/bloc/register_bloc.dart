import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/event/register_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/state/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<CreateAccountButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      if(event.password.isNotEmpty && event.confirm.isEmpty && event.password != event.confirm){
        emit(RegisterFailed("Password and Confirm password don't match"));
      }
      int registerSuccess = await authRepository.register(event.username, event.password, event.email);
      if(registerSuccess != 0){
        emit(RegisterSuccess());
      }
      else{
        emit(RegisterFailed("Invalid Credentials"));
      }
    });
  }
}