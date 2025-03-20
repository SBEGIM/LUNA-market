part of 'navigation_cubit.dart';

@freezed
abstract class NavigationState with _$NavigationState {
  const factory NavigationState.home() = HomeState;
  const factory NavigationState.tape() = TapeState;
  factory NavigationState.detailTape(int index, String name) = DetailTapeState;
  factory NavigationState.detailBloggerTape(
          int bloggerId, String bloggerName, String bloggerAvatar) =
      DetailBloggerTapeState;
  const factory NavigationState.favorite() = FavoriteState;
  const factory NavigationState.basket() = BasketState;
  const factory NavigationState.myOrder() = MyOrderState;
  const factory NavigationState.auth() = AuthState;
  const factory NavigationState.notAuth() = NotAuthState;
}
