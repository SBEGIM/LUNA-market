import '../data/model/profile_month_blogger_statics.dart';

abstract class ProfileMonthStaticsBloggerState {}

class InitState extends ProfileMonthStaticsBloggerState {}

class LoadingState extends ProfileMonthStaticsBloggerState {}

class LoadedState extends ProfileMonthStaticsBloggerState {
  List<ProfileMonthStatics> loadedProfile;
  LoadedState({required this.loadedProfile});
}

class ErrorState extends ProfileMonthStaticsBloggerState {
  String message;

  ErrorState({required this.message});
}
