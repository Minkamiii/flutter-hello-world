import 'package:equatable/equatable.dart';
import 'package:hello_world/model/user_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}
class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}
class ProfileUpdate extends ProfileState {}
class ProfileFailed extends ProfileState {
  final String error;
  ProfileFailed(this.error);

  @override
  List<Object?> get props => [error];
}