import '../data/models/review_product_model.dart';

abstract class ReviewState {}

class InitState extends ReviewState {}

class LoadingState extends ReviewState {}

class LoadedState extends ReviewState {
  List<ReviewProductModel> reviewModel;
  LoadedState(this.reviewModel);
}

class ErrorState extends ReviewState {
  String message;
  ErrorState({required this.message});
}
