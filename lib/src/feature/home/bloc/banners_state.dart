import 'package:equatable/equatable.dart';

import '../data/model/banner_model.dart';

sealed class BannersState extends Equatable {
  const BannersState();

  @override
  List<Object?> get props => [];
}

class BannerStateInitial extends BannersState {
  const BannerStateInitial();
}

class BannersStateLoading extends BannersState {}

class BannersStateLoaded extends BannersState {
  final List<BannerModel> banners;
  const BannersStateLoaded(this.banners);

  @override
  List<Object?> get props => [banners];
}

class BannersStateError extends BannersState {
  final String message;
  const BannersStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
