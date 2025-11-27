import 'package:equatable/equatable.dart';
import 'package:hello_world/service/sqlite/model/user_model.dart';

abstract class ProfileState extends Equatable {
  final bool isEditable;

  const ProfileState({this.isEditable = false});

  @override
  List<Object?> get props => [isEditable];
}
class ProfileInitial extends ProfileState {
  const ProfileInitial({super.isEditable});
}
class ProfileLoading extends ProfileState {
  const ProfileLoading({super.isEditable});
}
class ProfileLoaded extends ProfileState {
  final User user;
  const ProfileLoaded(this.user, {super.isEditable});

  ProfileLoaded copyWith({User? user, bool? isEditable}){
    return ProfileLoaded(
      user ?? this.user,
      isEditable: isEditable ?? this.isEditable
    );
  }

  @override
  List<Object?> get props => [user, isEditable];
}
class ProfileUpdate extends ProfileState {
  const ProfileUpdate({super.isEditable});
}
class ProfileFailed extends ProfileState {
  final String error;
  const ProfileFailed(this.error, {super.isEditable});

  @override
  List<Object?> get props => [error, isEditable];
}