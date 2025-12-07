import 'package:equatable/equatable.dart';
import 'package:haji_market/src/feature/home/data/model/meta_model.dart';

sealed class MetaState extends Equatable {
  const MetaState();
}

class MetaStateInitial extends MetaState {
  @override
  List<Object?> get props => [];
}

class MetaStateLoading extends MetaState {
  @override
  List<Object?> get props => [];
}

class MetaStateLoaded extends MetaState {
  final MetaModel metas;

  const MetaStateLoaded(this.metas);

  @override
  List<Object?> get props => [metas];
}

class MetaStateError extends MetaState {
  final String message;
  const MetaStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
