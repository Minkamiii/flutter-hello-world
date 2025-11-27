import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/ui/pages/register/state/register_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/ui/pages/register/state/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthRepository authRepository;
  final AppLocalizations loc;

  RegisterBloc(this.authRepository, this.loc) : super(RegisterInitial()) {
    on<CreateAccountButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      if(event.password.isNotEmpty && event.confirm.isEmpty && event.password != event.confirm){
        emit(RegisterFailed(loc.password_and_confirm_dont_match));
      }
      int registerSuccess = await authRepository.register(event.username, event.password, event.email);
      if(registerSuccess != 0){
        emit(RegisterSuccess());
      }
      else{
        emit(RegisterFailed(loc.invalid_credentials));
      }
    });
  }
}