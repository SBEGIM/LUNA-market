import 'package:equatable/equatable.dart';

import '../data/model/cat_model.dart';

sealed class CatsState extends Equatable {
  const CatsState();
}

class CatsStateInitial extends CatsState {
  const CatsStateInitial();

  @override
  List<Object?> get props => [];
}

class CatsStateLoading extends CatsState {
  const CatsStateLoading();

  @override
  List<Object?> get props => [];
}

class CatsStateNoData extends CatsState {
  const CatsStateNoData();

  @override
  List<Object?> get props => [];
}

class CatsStateLoaded extends CatsState {
  final List<CatsModel> cats;
  const CatsStateLoaded(this.cats);

  @override
  List<Object?> get props => [cats];
}

class CatsStateError extends CatsState {
  final String message;
  const CatsStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
