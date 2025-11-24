import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/bloc/register_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/register_field.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/event/register_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/state/register_state.dart';

class Register extends StatelessWidget{

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  Register({super.key});

  void registerListener(BuildContext context, RegisterState state) {
    if(state is RegisterSuccess){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(("Create account Success")))
      );

      context.go('/login');
    }
    if(state is RegisterFailed){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text((state.error)))
      );
    }
  }

  Widget registerBuilder(BuildContext context, RegisterState state){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Create Account",
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text("Create new account to get started"),
          SizedBox(height: 30),
          RegisterField(
            type: RegisterType.username, 
            label: "Username", 
            icon: Icons.account_circle,
            controller: usernameController,
          ),
          SizedBox(height: 12),
          RegisterField(
            type: RegisterType.email, 
            label: "Email Address", 
            icon: Icons.email,
            controller: emailController,
          ),
          SizedBox(height: 12),
          RegisterField(
            type: RegisterType.password, 
            label: "Password", 
            icon: Icons.lock,
            controller: passwordController,
          ),
          SizedBox(height: 12),
          RegisterField(
            type: RegisterType.password, 
            label: "Confirm Password", 
            icon: Icons.lock,
            controller: confirmController,
          ),
          SizedBox(height: 12),
          LoginButton(
            text: "Create Account",
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
              Text("Already have an account?", style: TextStyle(fontSize: 18)),
              TextButton(
                onPressed: () {
                  context.go("/login");
                },
                child: Text(
                  "Sign in here",
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
      create: (_) => RegisterBloc(AuthRepository()),
      child: Scaffold(
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: registerListener,
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: registerBuilder,
          ),
        ),
      ), 
    );
  }

}