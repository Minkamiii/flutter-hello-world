import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/component/notification/snack_bar_notification.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';
import 'package:hello_world/ui/pages/register/state/register_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/register_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/ui/pages/register/state/register_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/ui/pages/register/state/register_state.dart';

class Register extends StatelessWidget{

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  Register({super.key});

  void registerListener(BuildContext context, RegisterState state) {
    if(state is RegisterSuccess){
      SnackBarNotification().showSnackBar(
        context: context, 
        text: AppLocalizations.of(context)!.create_account_success
      );

      context.go('/login');
    }
    if(state is RegisterFailed){
      SnackBarNotification().showSnackBar(
        context: context, 
        text: state.error,
        success: false
      );
    }
  }

  Widget registerBuilder(BuildContext context, RegisterState state){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.create_account,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(AppLocalizations.of(context)!.create_account_to_get_started),
          SizedBox(height: 30),
          RegisterField(
            type: RegisterType.username, 
            label: AppLocalizations.of(context)!.username, 
            icon: Icons.account_circle,
            controller: usernameController,
          ),
          SizedBox(height: 12),
          RegisterField(
            type: RegisterType.email, 
            label: AppLocalizations.of(context)!.email, 
            icon: Icons.email,
            controller: emailController,
          ),
          SizedBox(height: 12),
          RegisterField(
            type: RegisterType.password, 
            label: AppLocalizations.of(context)!.password, 
            icon: Icons.lock,
            controller: passwordController,
          ),
          SizedBox(height: 12),
          RegisterField(
            type: RegisterType.password, 
            label: AppLocalizations.of(context)!.confirm_password, 
            icon: Icons.lock,
            controller: confirmController,
          ),
          SizedBox(height: 12),
          LoginButton(
            text: AppLocalizations.of(context)!.create_account,
            onPressed: () {
              context.read<RegisterBloc>().add(
                CreateAccountButtonPressed(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                  confirmController.text
                ),
              );
            },
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.already_have_account, style: TextStyle(fontSize: 18)),
              TextButton(
                onPressed: () {
                  context.go("/login");
                },
                child: Text(
                  AppLocalizations.of(context)!.sign_in_here,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[300],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BasePage<RegisterBloc, RegisterState>(
      onCreate: (_) => RegisterBloc(getIt<AuthRepository>(), AppLocalizations.of(context)!), 
      listener: registerListener, 
      builder: registerBuilder
    );
  }

}