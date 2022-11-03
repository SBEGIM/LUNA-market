


import 'package:haji_market/features/drawer/data/models/shops_drawer_model.dart';

abstract class ShopsDrawerState{}


class InitState extends ShopsDrawerState{}

class LoadingState extends ShopsDrawerState{}

class LoadedState extends ShopsDrawerState{
  List<ShopsDrawerModel> shopsDrawer;
  LoadedState(this.shopsDrawer);
}

class ErrorState extends ShopsDrawerState{
  String message;
  ErrorState({required this.message}) : assert(message != null);

}

