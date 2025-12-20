import 'package:equatable/equatable.dart';
import 'package:haji_market/src/feature/seller/main/data/model/stories_seller_model.dart';

sealed class StoriesSellerState extends Equatable {
  const StoriesSellerState();

  @override
  List<Object?> get props => [];
}

class StoriesSellerStateInitial extends StoriesSellerState {
  const StoriesSellerStateInitial();
}

class StoriesSellerStateLoading extends StoriesSellerState {
  const StoriesSellerStateLoading();
}

class StoriesSellerStateLoaded extends StoriesSellerState {
  final List<SellerStoriesModel> storiesSeelerModel;

  const StoriesSellerStateLoaded({required this.storiesSeelerModel});

  @override
  List<Object?> get props => [storiesSeelerModel];
}

class StoriesSellerStateError extends StoriesSellerState {
  final String message;

  const StoriesSellerStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
