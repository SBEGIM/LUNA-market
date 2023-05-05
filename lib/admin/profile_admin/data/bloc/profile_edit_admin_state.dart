import 'package:haji_market/admin/profile_admin/data/model/profile_statics_admin_model.dart';

abstract class ProfileEditAdminState {}

class InitState extends ProfileEditAdminState {}

class LoadingState extends ProfileEditAdminState {}

class LoadedState extends ProfileEditAdminState {
  ProfileStaticsAdminModel loadedProfile;
  LoadedState({required this.loadedProfile});
}

class ErrorState extends ProfileEditAdminState {
  String message;

  ErrorState({required this.message});
}
