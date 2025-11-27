abstract class ForgotPasswordEvent {}
class OnUsernameSearch extends ForgotPasswordEvent{
  final String usernameOrEmail;
  OnUsernameSearch(this.usernameOrEmail);
}
class OnPasswordChange extends ForgotPasswordEvent{
  final String usernameOrEmail;
  final String password;
  final String confirm;
  OnPasswordChange(this.usernameOrEmail, this.password, this.confirm);
}