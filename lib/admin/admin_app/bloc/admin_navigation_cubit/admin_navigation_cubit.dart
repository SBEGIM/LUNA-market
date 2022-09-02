import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_navigation_state.dart';
part 'admin_navigation_cubit.freezed.dart';

class AdminNavigationCubit extends Cubit<AdminNavigationState> {
  AdminNavigationCubit() : super(const HomeAdminState());

  Future<void> getNavBarItemAdmin(AdminNavigationState state) async {
    // final bool auth = await checkToken();

    state.when(
      homeAdmin: () => emit(const HomeAdminState()),
      tapeAdmin: () => emit(const TapeAdminState()),
      myOrderAdmin: () => emit(const MyOrderAdminState()),
      profile: () => emit(const ProfileState()),
      adminAuth: () => emit(const AdminAuthState()),
    );
  }
}
