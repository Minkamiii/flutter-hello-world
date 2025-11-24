abstract class RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterFailed extends RegisterState {
  final String error;
  RegisterFailed(this.error);
}
class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}