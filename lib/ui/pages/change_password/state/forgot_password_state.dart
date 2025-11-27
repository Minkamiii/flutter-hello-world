abstract class ForgotPasswordState{}
class ForgotPasswordInitial extends ForgotPasswordState{}
class ForgotPasswordLoading extends ForgotPasswordState{}
class ForgotPasswordChooseUsername extends ForgotPasswordState{}
class ForgotPasswordChangePassword extends ForgotPasswordState{}
class ForgotPasswordSuccess extends ForgotPasswordState{}
class ForgotPasswordFailed extends ForgotPasswordState{
  final String error;
  ForgotPasswordFailed(this.error);
}