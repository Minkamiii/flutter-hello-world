abstract class LoginState {}

class LoginInitial extends LoginState{}
class LoginLoading extends LoginState{}
class LoginSucess extends LoginState{}
class LoginFailed extends LoginState{
  final String error;
  LoginFailed(this.error);
}
