import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
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
                padding: const EdgeInsets.all(24),
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 40),
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
                      ),
                    _buildRoleOption(
                      title: 'Продавец',
                      value: UserRole.seller,
                      selected: selectedRole,
                      onChanged: (val) => setState(() => selectedRole = val),
                    ),
                    _buildRoleOption(
                      title: 'Блогер',
                      value: UserRole.blogger,
                      selected: selectedRole,
                      onChanged: (val) => setState(() => selectedRole = val),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
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
                            GetStorage().remove('token');
                            BlocProvider.of<AppBloc>(context)
                                .add(const AppEvent.exiting());
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
                    SizedBox(height: 40)
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

Widget _buildRoleOption({
  required String title,
  required UserRole value,
  required UserRole? selected,
  required Function(UserRole?) onChanged,
}) {
  return Container(
    width: 310,
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFF6F6F6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: RadioListTile<UserRole>(
      value: value,
      groupValue: selected,
      onChanged: onChanged,
      activeColor: Colors.black,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0,
          fontFamily: 'SFProDisplay',
        ),
      ),
      controlAffinity: ListTileControlAffinity.trailing,
    ),
  );
}
