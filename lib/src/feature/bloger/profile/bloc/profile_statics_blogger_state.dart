import '../data/model/profile_statics_blogger_model.dart';

abstract class ProfileStaticsBloggerState {}

class InitState extends ProfileStaticsBloggerState {}

class LoadingState extends ProfileStaticsBloggerState {}

class LoadedState extends ProfileStaticsBloggerState {
  ProfileStaticsBloggerModel loadedProfile;
  LoadedState({required this.loadedProfile});
}

class ErrorState extends ProfileStaticsBloggerState {
  String message;

  ErrorState({required this.message});
}
