import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/component/notification/snack_bar_notification.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';
import 'package:hello_world/ui/pages/profile/state/profile_bloc.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/component/text_field/description_field.dart';
import 'package:hello_world/component/text_field/profile_field.dart';
import 'package:hello_world/ui/pages/profile/state/profile_event.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/ui/pages/profile/state/profile_state.dart';

class ProfileViewPage extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController role = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController description = TextEditingController();

  ProfileViewPage({super.key});

  void profileListener(BuildContext context, ProfileState state){
    if(state is ProfileUpdate){
      SnackBarNotification().showSnackBar(
        context: context, 
        text: AppLocalizations.of(context)!.update_profile_success
      );
    }
    if(state is ProfileFailed){
      SnackBarNotification().showSnackBar(
        context: context, 
        text: state.error,
        success: false
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
              AppLocalizations.of(context)!.profile,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 34),
            ProfileField(
              label: AppLocalizations.of(context)!.full_name,
              controller: fullname,
              isEditable: state.isEditable,
              value: state.user.fullname
            ),
            SizedBox(height: 12),
            ProfileField(
              label: AppLocalizations.of(context)!.email,
              controller: email,
              isEditable: state.isEditable,
              value: state.user.email,
            ),
            SizedBox(height: 12),
            ProfileField(
              label: AppLocalizations.of(context)!.role,
              controller: role,
              isEditable: state.isEditable,
              value: state.user.role,
            ),
            SizedBox(height: 12),
            DescriptionField(
              label: AppLocalizations.of(context)!.description,
              controller: description,
              isEditable: state.isEditable,
              value: state.user.description
            ),
            SizedBox(height: 12),
            if (state is! ProfileUpdate)
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
                text: AppLocalizations.of(context)!.update_profile,
              ),
          ],
        ),
      );
    }

    return Center();
  }
  
  @override
  Widget build(BuildContext context) {
    return BasePage<ProfileBloc, ProfileState>(
      onCreate: (_) => ProfileBloc(getIt<AuthRepository>(), AppLocalizations.of(context)!)..add(LoadProfile()),
      listener: profileListener,
      builder: profileBuilder,
      floatingActionButton: (context, state) =>
          (state is ProfileLoaded && !state.isEditable)
          ? FloatingActionButton(
              onPressed: () =>
                  context.read<ProfileBloc>().add(ToggleEditProfile()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
              child: Icon(Icons.edit, size: 28),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}