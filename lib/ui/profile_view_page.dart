import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc/profile_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/description_field.dart';
import 'package:hello_world/component/text_field/profile_field.dart';
import 'package:hello_world/event/profile_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/state/profile_state.dart';

class ProfileViewPage extends StatefulWidget{
  const ProfileViewPage({super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPage();

}

class _ProfileViewPage extends State<ProfileViewPage> {

  final TextEditingController email = TextEditingController();
  final TextEditingController role = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController description = TextEditingController();

  bool isEditable = false;

  void profileListener(BuildContext context, ProfileState state){
    if(state is ProfileUpdate){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Update profile success")
        )
      );

      setState(() {
        isEditable = false;
      });
    }
    if(state is ProfileFailed){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
        )
      );
    }
  }

  Widget profileBuilder(BuildContext context, ProfileState state){
    if(state is ProfileLoading){
      return CircularProgressIndicator();
    }
    if(state is ProfileLoaded){
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 34),
            ProfileField(
              label: "Full name",
              controller: fullname,
              isEditable: isEditable,
              value: state.user.fullname
            ),
            SizedBox(height: 12),
            ProfileField(
              label: "Email",
              controller: email,
              isEditable: isEditable,
              value: state.user.email,
            ),
            SizedBox(height: 12),
            ProfileField(
              label: "Role",
              controller: role,
              isEditable: isEditable,
              value: state.user.role,
            ),
            SizedBox(height: 12),
            DescriptionField(
              label: "Description",
              controller: description,
              isEditable: isEditable,
              value: state.user.description
            ),
            SizedBox(height: 12),
            if (isEditable)
              LoginButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(
                    UpdateProfileButtonClicked(
                      email.text,
                      role.text,
                      fullname.text,
                      description.text,
                    ),
                  );
                },
                text: "Update profile",
              ),
          ],
        ),
      );
    }

    return Center();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(AuthRepository())..add(LoadProfile()),
      child: Scaffold(
        floatingActionButton: !isEditable ? FloatingActionButton(
          onPressed: () => setState(() {
            isEditable = true;
          }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          child: Icon(Icons.edit, size: 28),
        ) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: profileListener,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: profileBuilder
          )
        ),
      ),
    );
  }

}