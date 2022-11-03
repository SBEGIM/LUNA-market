

import '../../../home/data/model/Cats.dart';

abstract class SubCatsState{}


class InitState extends SubCatsState{}

class LoadingState extends SubCatsState{}

class LoadedState extends SubCatsState{
  List<Cats> cats;
  LoadedState(this.cats);
}

class ErrorState extends SubCatsState{
  String message;
  ErrorState({required this.message}) : assert(message != null);

}

