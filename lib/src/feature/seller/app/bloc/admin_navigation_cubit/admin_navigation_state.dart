part of 'admin_navigation_cubit.dart';

@freezed
class AdminNavigationState with _$AdminNavigationState {
  const factory AdminNavigationState.tapeAdmin() = TapeAdminState;
  factory AdminNavigationState.detailTapeAdmin(int index, String name) = DetailTapeAdminState;
  const factory AdminNavigationState.homeAdmin() = HomeAdminState;
  const factory AdminNavigationState.myOrderAdmin() = MyOrderAdminState;
  const factory AdminNavigationState.profile() = ProfileState;
  const factory AdminNavigationState.chatAdmin() = ChatAdminState;
  const factory AdminNavigationState.adminAuth() = AdminAuthState;
}
