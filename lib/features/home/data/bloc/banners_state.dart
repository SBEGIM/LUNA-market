


import '../model/Cats.dart';

abstract class CatsState{}


class InitState extends CatsState{}

class LoadingState extends CatsState{}

class LoadedState extends CatsState{
  List<Cats> cats;
  Set<String> catsSet;
  String dropdownCats;
  LoadedState(this.cats , this.catsSet , this.dropdownCats);
}

class ErrorState extends CatsState{
  String message;
  ErrorState({required this.message}) : assert(message != null);

}

