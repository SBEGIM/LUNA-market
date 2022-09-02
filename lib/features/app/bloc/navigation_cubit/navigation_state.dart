part of 'navigation_cubit.dart';

@freezed
abstract class NavigationState with _$NavigationState {
  const factory NavigationState.home() = HomeState;
  const factory NavigationState.tape() = TapeState;
  const factory NavigationState.favorite() = FavoriteState;
  const factory NavigationState.basket() = BasketState;
  const factory NavigationState.myOrder() = MyOrderState;
  const factory NavigationState.auth() = AuthState;
}
