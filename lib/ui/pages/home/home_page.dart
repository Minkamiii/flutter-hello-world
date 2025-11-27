import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/ui/pages/home/state/home_cubit.dart';
import 'package:hello_world/ui/pages/home/state/home_state.dart';
import 'package:hello_world/ui/pages/home_view/home_view_page.dart';
import 'package:hello_world/ui/pages/main/base_page.dart';
import 'package:hello_world/ui/pages/profile/profile_view_page.dart';
import 'package:hello_world/ui/pages/settings/setting_page.dart';

class Home extends StatelessWidget{
  final pages = [
    HomeViewPage(),
    ProfileViewPage(),
    SettingPage()
  ];

  Home({super.key});

  void homeListener(BuildContext context, HomeState state){

  }

  Widget homeBuilder(BuildContext context, HomeState state){
    return pages[state.curentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeCubit, HomeState>(
      onCreate: (_) => HomeCubit(), 
      listener: homeListener, 
      builder: homeBuilder,
      bottomNavigationBar: (ctx, state) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: AppLocalizations.of(context)!.profile),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppLocalizations.of(context)!.settings)
        ],
        currentIndex: state.curentIndex,
        onTap: (index) => {
          ctx.read<HomeCubit>().changeIndex(index)
        },
      ),
    );
  }
}