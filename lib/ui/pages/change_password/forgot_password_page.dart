import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/component/notification/snack_bar_notification.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/ui/pages/change_password/state/forgot_password_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/login_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/ui/pages/change_password/state/forgot_password_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/ui/pages/change_password/state/forgot_password_state.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';

class ForgotPasswordPage extends StatelessWidget {

  final TextEditingController usernameOrEmail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();

  ForgotPasswordPage({super.key});

  void forgotPasswordListener(BuildContext context, ForgotPasswordState state){
    if(state is ForgotPasswordSuccess){
      SnackBarNotification().showSnackBar(
        context: context,
        text: AppLocalizations.of(context)!.password_change_success,
      );

      context.go('/login');
    }
    if(state is ForgotPasswordFailed){
      SnackBarNotification().showSnackBar(
        context: context,
        text: state.error,
        success: false,
      );
    }
  }

  Widget forgotPasswordBuilder(BuildContext context, ForgotPasswordState state){
    if(state is ForgotPasswordLoading){
      return CircularProgressIndicator();
    }
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            loc.forget_password,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(loc.enter_username_or_email),
          SizedBox(height: 30),
          LoginField(
            type: LoginType.username,
            label: loc.username,
            icon: Icons.account_circle,
            controller: usernameOrEmail,
          ),
          if(state is ForgotPasswordChangePassword)
            SizedBox(height: 12),
          if(state is ForgotPasswordChangePassword)
            LoginField(
              type: LoginType.password,
              label: loc.new_password,
              icon: Icons.lock,
              controller: password,
            ),
          if(state is ForgotPasswordChangePassword)
            SizedBox(height: 12),
          if(state is ForgotPasswordChangePassword)
            LoginField(
              type: LoginType.password,
              label: loc.confirm_new_password,
              icon: Icons.lock,
              controller: confirm,
            ),
          SizedBox(height: 10),
          LoginButton(
            text: state is ForgotPasswordChangePassword ? loc.change_password : loc.find_user,
            onPressed: () {
              if (state is ForgotPasswordChangePassword) {
                context.read<ForgotPasswordBloc>().add(
                  OnPasswordChange(
                    usernameOrEmail.text,
                    password.text,
                    confirm.text
                  ),
                );
              }
              else{
                context.read<ForgotPasswordBloc>().add(
                  OnUsernameSearch(usernameOrEmail.text),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onCreate: (_) => ForgotPasswordBloc(AuthRepository(), AppLocalizations.of(context)!),
      listener: forgotPasswordListener,
      builder: forgotPasswordBuilder,
    );
  }

}