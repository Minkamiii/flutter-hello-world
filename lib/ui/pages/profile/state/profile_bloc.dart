import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/ui/pages/profile/state/profile_event.dart';
import 'package:hello_world/service/sqlite/model/user_model.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/ui/pages/profile/state/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final AuthRepository repository;
  final AppLocalizations loc;
  final localStorage = getIt<SharedPreferences>();
  
  ProfileBloc(this.repository, this.loc) : super(ProfileInitial()) {
    on<LoadProfile>(_loadProfile);
    on<UpdateProfileButtonClicked>(_updateProfile);
    on<ToggleEditProfile>(_toggleEditProfile);
  }

  Future<void> _loadProfile(LoadProfile event, Emitter<ProfileState> emit) async{
    emit(ProfileLoading());
    try{
      final userId = localStorage.getInt('userid');
      final user = await repository.get(userId!);

      emit(ProfileLoaded(user!, isEditable: state.isEditable));
    }
    catch (e) {
      emit(ProfileFailed(loc.cant_load_profile, isEditable: state.isEditable));
    }
  }

  Future<void> _updateProfile(UpdateProfileButtonClicked event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try{
      int userId = localStorage.getInt('userid')!;
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
        emit(ProfileUpdate(isEditable: false));
        add(LoadProfile());
      }
    }
    catch (e) {
      emit(ProfileFailed(loc.cant_update_profile));
    }
  }

  Future<void> _toggleEditProfile(ToggleEditProfile event, Emitter<ProfileState> emit) async {
    final currentState = state;
    if(currentState is ProfileLoaded){
      emit(currentState.copyWith(isEditable: !currentState.isEditable));
    }
  }
   
}