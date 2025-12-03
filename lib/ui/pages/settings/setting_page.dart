import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/component/adaptive_layout/base_adaptive_layout.dart';
import 'package:hello_world/component/button/login_button.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/extension/app_theme_type_localization.dart';
import 'package:hello_world/extension/locale_type_localization.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/notifier/locale_provider.dart';
import 'package:hello_world/notifier/theme_provider.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';
import 'package:hello_world/ui/pages/settings/cubit/setting_cubit.dart';
import 'package:hello_world/ui/pages/settings/cubit/setting_scope.dart';
import 'package:hello_world/ui/pages/settings/cubit/setting_state.dart';

class SettingPage extends StatelessWidget with BaseAdaptiveLayout {
  const SettingPage({super.key});

  void settingListener (BuildContext context, SettingState state){
    if(state.loggedOut){
      context.go('/login');
    }
    if(!state.hadChanges){
      context.read<LocaleProvider>().setLocale(Locale(state.currentLocale.name));
      context.read<ThemeProvider>().setTheme(state.currentTheme);
    }
  }

  Widget settingBuilder (BuildContext context, SettingState state){
    return SettingScope(state: state, child: adaptiveLayout(context));
  }

  @override
  Widget buildPortraitMobile(BuildContext context, Size size) {
    final state = SettingScope.of(context).state;
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              loc.settings,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),
            Text(loc.locale, style: TextStyle(fontSize: 18)),
            SizedBox(height: 7),
            DropdownButton<LocaleType>(
              isExpanded: true,
              value: state.selectedLocale,
              onChanged: (LocaleType? newValue) => {
                if (newValue != null)
                  {context.read<SettingCubit>().changeLanguage(newValue)},
              },
              items: LocaleType.values
                  .map(
                    (type) => DropdownMenuItem<LocaleType>(
                      value: type,
                      child: Text(type.localized(context)),
                    ),
                  )
                  .toList(),
            ),

            SizedBox(height: 20),
            Text(loc.screen, style: TextStyle(fontSize: 18)),
            SizedBox(height: 7),
            DropdownButton<AppThemeType>(
              isExpanded: true,
              value: state.selectedTheme,
              onChanged: (AppThemeType? newValue) => {
                if (newValue != null)
                  {context.read<SettingCubit>().changeTheme(newValue)},
              },
              items: AppThemeType.values
                  .map(
                    (type) => DropdownMenuItem<AppThemeType>(
                      value: type,
                      child: Text(type.localized(context)),
                    ),
                  )
                  .toList(),
            ),

            SizedBox(height: 20),
            if(state.hadChanges)
              LoginButton(
                onPressed: (() {
                  context.read<SettingCubit>().confirmChanges();
                }),
                text: loc.accept_change,
              ),
              SizedBox(height: 20),
            LoginButton(
              onPressed: (() {
                context.read<SettingCubit>().logout();
              }),
              text: loc.logout,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onCreate: (_) => SettingCubit(AppLocalizations.of(context)!),
      listener: settingListener, 
      builder: settingBuilder
    );
  }
}