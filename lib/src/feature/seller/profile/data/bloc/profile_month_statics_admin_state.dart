import '../model/profile_month_admin_statics.dart';

abstract class ProfileMonthStaticsAdminState {}

class InitState extends ProfileMonthStaticsAdminState {}

class LoadingState extends ProfileMonthStaticsAdminState {}

class LoadedState extends ProfileMonthStaticsAdminState {
  List<ProfileMonthStatics> loadedProfile;
  LoadedState({required this.loadedProfile});
}

class ErrorState extends ProfileMonthStaticsAdminState {
  String message;

  ErrorState({required this.message});
}
