import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/component/adaptive_layout/base_adaptive_layout.dart';
import 'package:hello_world/component/notification/snack_bar_notification.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/ui/pages/login/state/login_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/login_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/ui/pages/login/state/login_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/ui/pages/login/state/login_state.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';

class Login extends StatelessWidget with BaseAdaptiveLayout {

  final TextEditingController userController = TextEditingController();
  final TextEditingController passswordController = TextEditingController();

  Login({super.key});

  void loginListener (BuildContext context, LoginState state) {
    if(state is LoginSucess){
      SnackBarNotification().showSnackBar(
        context: context, 
        text: AppLocalizations.of(context)!.login_success
      );

      context.go('/home');
    }
    if(state is LoginFailed){
      SnackBarNotification().showSnackBar(
        context: context, 
        text: state.error,
        success: false
      );
    }
  }

  Widget loginBuilder(BuildContext context, LoginState state){
    return switch(state){
      var s when s is LoginLoading => Center(child: CircularProgressIndicator()),
      _ => adaptiveLayout(context)
    };
  }

  @override
  Widget buildPortraitMobile(BuildContext context, Size size) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.login,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(AppLocalizations.of(context)!.enter_username_or_password),
            SizedBox(height: 30),
            LoginField(
              type: LoginType.username,
              label: AppLocalizations.of(context)!.username,
              icon: Icons.account_circle,
              controller: userController,
            ),
            SizedBox(height: 12),
            LoginField(
              type: LoginType.password,
              label: AppLocalizations.of(context)!.password,
              icon: Icons.lock,
              controller: passswordController,
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                TextButton(
                  onPressed: () {
                    context.go('/forgot-password');
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forget_password,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            LoginButton(
              text: AppLocalizations.of(context)!.login,
              onPressed: () {
                context.read<LoginBloc>().add(
                  LoginButtonPressed(
                    userController.text,
                    passswordController.text,
                  ),
                );
              },
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.dont_have_account,
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    context.go("/register");
                  },
                  child: Text(
                    AppLocalizations.of(context)!.sign_up_here,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[300],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BasePage<LoginBloc, LoginState>(
      onCreate: (_) => LoginBloc(getIt<AuthRepository>(), AppLocalizations.of(context)!), 
      listener: loginListener,
      builder: loginBuilder, 
    );
  }
}