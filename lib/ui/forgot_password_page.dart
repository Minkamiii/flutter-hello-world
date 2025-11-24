import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/bloc/forgot_password_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/login_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/event/forgot_password_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/state/forgot_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {

  final TextEditingController usernameOrEmail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();

  ForgotPasswordPage({super.key});

  void forgotPasswordListener(BuildContext context, ForgotPasswordState state){
    if(state is ForgotPasswordSuccess){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password change success"))
      );

      context.go('/login');
    }
    if(state is ForgotPasswordFailed){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error))
      );
    }
  }

  Widget forgotPasswordBuilder(BuildContext context, ForgotPasswordState state){
    if(state is ForgotPasswordLoading){
      return CircularProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Forgot Password",
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text("Enter your username or email"),
          SizedBox(height: 30),
          LoginField(
            type: LoginType.username,
            label: "Username",
            icon: Icons.account_circle,
            controller: usernameOrEmail,
          ),
          if(state is ForgotPasswordChangePassword)
            SizedBox(height: 12),
          if(state is ForgotPasswordChangePassword)
            LoginField(
              type: LoginType.password,
              label: "New Password",
              icon: Icons.lock,
              controller: password,
            ),
          if(state is ForgotPasswordChangePassword)
            SizedBox(height: 12),
          if(state is ForgotPasswordChangePassword)
            LoginField(
              type: LoginType.password,
              label: "Confirm New Password",
              icon: Icons.lock,
              controller: confirm,
            ),
          SizedBox(height: 10),
          LoginButton(
            text: state is ForgotPasswordChangePassword ? "Change Password" : "Find User",
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
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(AuthRepository()),
      child: Scaffold(
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: forgotPasswordListener,
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: forgotPasswordBuilder,
          ),
        ),
      )
    );
  }

}