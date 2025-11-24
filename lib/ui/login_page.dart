import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/bloc/login_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/login_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/event/login_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/state/login_state.dart';

class Login extends StatelessWidget {

  final TextEditingController userController = TextEditingController();
  final TextEditingController passswordController = TextEditingController();

  Login({super.key});

  void loginListener (BuildContext context, LoginState state) {
    if(state is LoginSucess){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(("Login Success")))
      );

      context.go('/home');
    }
    if(state is LoginFailed){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text((state.error)))
      );
    }
  }

  Widget loginBuilder (BuildContext context, LoginState state){
    if(state is LoginLoading){
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Log in",
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text("Enter your username and password"),
          SizedBox(height: 30),
          LoginField(
            type: LoginType.username,
            label: "Username",
            icon: Icons.account_circle,
            controller: userController,
          ),
          SizedBox(height: 12),
          LoginField(
            type: LoginType.password,
            label: "Password",
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
                  "Forget password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          LoginButton(
            text: "Login",
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
              Text("Don't have an account?", style: TextStyle(fontSize: 18)),
              TextButton(
                onPressed: () {
                  context.go("/register");
                },
                child: Text(
                  "Sign up here",
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
    return BlocProvider(
      create: (_) => LoginBloc(AuthRepository()),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: loginListener,
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: loginBuilder,
          ),
        ),
      ),
    );
  }
  
}