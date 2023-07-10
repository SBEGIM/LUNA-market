import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.dart';
part 'navigation_cubit.freezed.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const HomeState());

  Future<void> getNavBarItem(NavigationState state) async {
    // final bool auth = await checkToken();

    state.when(
      tape: () => emit(const TapeState()),
      detailBloggerTape: (int j, String k, String i) =>
          emit(DetailBloggerTapeState(j, k, i)),
      home: () => emit(const HomeState()),
      detailTape: (int j, String k) => emit(DetailTapeState(j, k)),
      favorite: () => emit(const FavoriteState()),
      basket: () => emit(const BasketState()),
      myOrder: () => emit(const MyOrderState()),
      auth: () => emit(const AuthState()),
      notAuth: () => emit(const NotAuthState()),
    );
  }
}
