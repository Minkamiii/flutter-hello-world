import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/ui/pages/home/state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  
  HomeCubit() : super(HomeState(0));

  void changeIndex(int index){
    emit(HomeState(index));
  }
}