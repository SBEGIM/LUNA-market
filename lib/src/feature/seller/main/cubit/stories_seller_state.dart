import 'package:haji_market/src/feature/seller/main/data/model/stories_seller_model.dart';

abstract class StoriesSellerState {}

class InitState extends StoriesSellerState {}

class LoadingState extends StoriesSellerState {}

class LoadedState extends StoriesSellerState {
  List<SellerStoriesModel> storiesSeelerModel;

  LoadedState({required this.storiesSeelerModel});
}

class ErrorState extends StoriesSellerState {
  String message;

  ErrorState({required this.message});
}
