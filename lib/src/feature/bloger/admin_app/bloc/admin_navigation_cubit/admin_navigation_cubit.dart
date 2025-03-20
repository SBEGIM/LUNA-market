import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_navigation_state.dart';
part 'admin_navigation_cubit.freezed.dart';

class AdminNavigationCubit extends Cubit<AdminNavigationState> {
  AdminNavigationCubit() : super(const HomeAdminState());

  Future<void> getNavBarItemAdmin(AdminNavigationState state) async {
    // final bool auth = await checkToken();

    state.when(
      tapeAdmin: () => emit(const TapeAdminState()),
      homeAdmin: () => emit(const HomeAdminState()),
      myOrderAdmin: () => emit(const MyOrderAdminState()),
      profile: () => emit(const ProfileState()),
      adminAuth: () => emit(const AdminAuthState()),
    );
  }
}
