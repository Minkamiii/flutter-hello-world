import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/event/profile_event.dart';
import 'package:hello_world/model/user_model.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/state/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final AuthRepository repository;
  
  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>(_loadProfile);
    on<UpdateProfileButtonClicked>(_updateProfile);
  }

  Future<void> _loadProfile(LoadProfile event, Emitter<ProfileState> emit) async{
    emit(ProfileLoading());
    try{
      final localStorage = await SharedPreferences.getInstance();
      final userId = localStorage.getInt('userid');
      final user = await repository.get(userId!);

      emit(ProfileLoaded(user!));
    }
    catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }

  Future<void> _updateProfile(UpdateProfileButtonClicked event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try{
      final localStorage = await SharedPreferences.getInstance();
      final userId = localStorage.getInt('userid');
      final update = await repository.update(
        User.updateProfile(
          id: userId, 
          email: event.email, 
          fullname: event.fullName, 
          role: event.role, 
          description: event.description
        )
      );

      if(update!=0){
        emit(ProfileUpdate());
        add(LoadProfile());
      }
    }
    catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }
   
}