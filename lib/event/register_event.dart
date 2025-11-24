abstract class RegisterEvent {}
class CreateAccountButtonPressed extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String confirm;
  CreateAccountButtonPressed(this.username, this.email, this.password, this.confirm);
}