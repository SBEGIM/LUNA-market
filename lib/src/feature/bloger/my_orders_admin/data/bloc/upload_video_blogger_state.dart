abstract class UploadVideoBloggerCubitState {}

class InitState extends UploadVideoBloggerCubitState {}

class LoadingState extends UploadVideoBloggerCubitState {}

class OrderState extends UploadVideoBloggerCubitState {}

class LoadedState extends UploadVideoBloggerCubitState {}

class LoadedOrderState extends UploadVideoBloggerCubitState {}

class ErrorState extends UploadVideoBloggerCubitState {
  String message;
  ErrorState({required this.message});
}
