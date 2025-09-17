import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

enum UserRole { buyer, seller, blogger }

void showRolePicker(BuildContext context, String type) {
  UserRole? selectedRole =
      type == 'change_cabinet' ? UserRole.seller : UserRole.buyer;
  final _box = GetStorage();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (dialogContext, setState) {
              return Container(
                height: 494,
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                // margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Выберите роль',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type != 'change_cabinet'
                          ? 'чтобы зарегистрироваться:'
                          : 'для входа в:',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (type != 'change_cabinet')
                      _buildRoleOption(
                        title: 'Покупатель',
                        value: UserRole.buyer,
                        selected: selectedRole,
                        onChanged: (val) => setState(() => selectedRole = val),
                        selectedIconAsset: Assets.icons.defaultCheckIcon.path,
                        unselectedIconAsset:
                            Assets.icons.defaultUncheckIcon.path,
                      ),
                    _buildRoleOption(
                      title: 'Продавец',
                      value: UserRole.seller,
                      selected: selectedRole,
                      onChanged: (val) => setState(() => selectedRole = val),
                      selectedIconAsset: Assets.icons.defaultCheckIcon.path,
                      unselectedIconAsset: Assets.icons.defaultUncheckIcon.path,
                    ),
                    _buildRoleOption(
                      title: 'Блогер',
                      value: UserRole.blogger,
                      selected: selectedRole,
                      onChanged: (val) => setState(() => selectedRole = val),
                      selectedIconAsset: Assets.icons.defaultCheckIcon.path,
                      unselectedIconAsset: Assets.icons.defaultUncheckIcon.path,
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: 310,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainPurpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop(selectedRole);

                          if (UserRole.blogger == selectedRole) {
                            _box.read('blogger_token') != null
                                ? BlocProvider.of<AppBloc>(context).add(
                                    const AppEvent.chageState(
                                        state: AppState.inAppBlogerState()))
                                : context.router.push(BlogAuthRegisterRoute());
                          }

                          if (UserRole.seller == selectedRole) {
                            _box.read('seller_token') != null
                                ? BlocProvider.of<AppBloc>(context).add(
                                    const AppEvent.chageState(
                                        state: AppState.inAppAdminState()))
                                : context.router.push(AuthSellerRoute());
                          }

                          if (UserRole.buyer == selectedRole) {
                            // GetStorage().remove('token');
                            // BlocProvider.of<AppBloc>(context)
                            //     .add(const AppEvent.exiting());

                            BlocProvider.of<AppBloc>(context).add(
                                const AppEvent.chageState(
                                    state: AppState.notAuthorizedState(
                                        button: true)));
                          }
                        },
                        child: const Text(
                          'Далее',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

/// Кастомная опция роли с иконками (asset или дефолтный кружок/чек)
Widget _buildRoleOption({
  required String title,
  required UserRole value,
  required UserRole? selected,
  required ValueChanged<UserRole?> onChanged,

  // (необязательно) свои иконки
  String? selectedIconAsset, // напр. 'assets/icons/radio_on.png'
  String? unselectedIconAsset, // напр. 'assets/icons/radio_off.png'
}) {
  final bool isSelected = value == selected;

  return InkWell(
    onTap: () => onChanged(value),
    borderRadius: BorderRadius.circular(16),
    child: Container(
      width: 310,
      height: 52,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: const EdgeInsets.only(bottom: 12, left: 0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0,
              fontFamily: 'SFProDisplay',
              color: Colors.black,
            ),
          ),
          _RoleTrailingIcon(
            isSelected: isSelected,
            selectedIconAsset: selectedIconAsset,
            unselectedIconAsset: unselectedIconAsset,
          ),
        ],
      ),
    ),
  );
}

/// Трейлинг-иконка: если передали assets — используем их,
/// иначе рисуем аккуратный кастом (кружок с чек-иконкой)
class _RoleTrailingIcon extends StatelessWidget {
  const _RoleTrailingIcon({
    required this.isSelected,
    this.selectedIconAsset,
    this.unselectedIconAsset,
  });

  final bool isSelected;
  final String? selectedIconAsset;
  final String? unselectedIconAsset;

  @override
  Widget build(BuildContext context) {
    // Кастомные картинки, если заданы
    if (selectedIconAsset != null && unselectedIconAsset != null) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: Image.asset(
          isSelected ? selectedIconAsset! : unselectedIconAsset!,
          key: ValueKey(isSelected),
          width: 24,
          height: 24,
          color: isSelected ? AppColors.kLightBlackColor : Color(0xffD1D1D6),
        ),
      );
    }

    // Дефолтная кастомная «радио»-иконка
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.black : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.black : const Color(0xFFCDCED1),
          width: 1.2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ]
            : null,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : const SizedBox.shrink(),
    );
  }
}
