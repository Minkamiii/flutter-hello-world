import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent{}
class UpdateProfileButtonClicked extends ProfileEvent{
  final String email;
  final String role;
  final String fullName;
  final String description;
  UpdateProfileButtonClicked(this.email, this.role, this.fullName, this.description);

  @override
  List<Object?> get props => [email,role,fullName,description];
}
class ToggleEditProfile extends ProfileEvent{}