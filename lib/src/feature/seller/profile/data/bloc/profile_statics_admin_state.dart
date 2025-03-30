import 'package:haji_market/src/feature/seller/profile/data/model/profile_statics_admin_model.dart';

abstract class ProfileStaticsAdminState {}

class InitState extends ProfileStaticsAdminState {}

class LoadingState extends ProfileStaticsAdminState {}

class LoadedState extends ProfileStaticsAdminState {
  ProfileStaticsAdminModel loadedProfile;
  LoadedState({required this.loadedProfile});
}

class ErrorState extends ProfileStaticsAdminState {
  String message;

  ErrorState({required this.message});
}
