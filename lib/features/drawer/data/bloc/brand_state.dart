

import '../../../home/data/model/Cats.dart';

abstract class BrandState{}


class InitState extends BrandState{}

class LoadingState extends BrandState{}

class LoadedState extends BrandState{
  List<Cats> cats;
  LoadedState(this.cats);
}

class ErrorState extends BrandState{
  String message;
  ErrorState({required this.message});

}

