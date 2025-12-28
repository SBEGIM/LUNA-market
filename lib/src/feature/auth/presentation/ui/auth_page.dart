import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../bloc/login_cubit.dart';
import '../../bloc/login_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isButtonEnabled = false;
  bool _passwordVisible = false;

  void setIsButtonEnabled(bool value) {
    // log("is button state changed $value");
    isButtonEnabled = value;
    setState(() {});
  }

  CountrySellerDto? countrySellerDto;

  TextEditingController phoneControllerAuth = MaskedTextController(mask: '(000)-000-00-00');
  TextEditingController passwordControllerAuth = TextEditingController();

  Map<String, String?> fieldErrors = {'phone': null, 'password': null};

  @override
  void initState() {
    countrySellerDto = CountrySellerDto(
      code: '+7',
      flagPath: Assets.icons.ruFlagIcon.path,
      name: 'Россия',
    );

    for (final c in [phoneControllerAuth, passwordControllerAuth]) {
      c.addListener(() => setState(() {}));
    }
    super.initState();
  }

  String? _validateError() {
    final rawDigits = phoneControllerAuth.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawDigits.length != 10) return 'Введите корректный номер телефона';

    final pass = passwordControllerAuth.text;
    if (pass.isEmpty) return 'Введите пароль';

    return null;
  }

  void _validateFields() {
    final phone = phoneControllerAuth.text.replaceAll(RegExp(r'[^0-9]'), '');
    final pass = passwordControllerAuth.text;

    setState(() {
      fieldErrors['phone'] = phone.length != 10 ? 'Введите корректный номер телефона' : null;

      fieldErrors['password'] = pass.isEmpty ? 'Введите пароль' : null;
    });
  }

  bool _ensureValid() {
    final msg = _validateError();
    if (msg != null) {
      AppSnackBar.show(context, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStateSuccess && state.action == LoginAction.login) {
          final router = AutoRouter.of(context).root;

          context.read<AppBloc>().add(
            const AppEvent.chageState(state: AppState.inAppUserState(index: 0)),
          );
          router.replaceAll([const LauncherRoute()]);
        }

        if (state is LoginStateError && state.action == LoginAction.login) {
          AppSnackBar.show(context, state.message, type: AppSnackType.error);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is LoginStateLoading && state.action == LoginAction.login;

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Войти', textAlign: TextAlign.start, style: AppTextStyles.size28Weight700),
                  SizedBox(height: 24),
                  Text(
                    'Номер телефона',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.size13Weight500.copyWith(color: Color(0xFF636366)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showSellerLoginPhone(
                            context,
                            countryCall: (dto) {
                              countrySellerDto = dto;
                              setState(() {});
                            },
                          );
                        },
                        child: Shimmer(
                          child: Container(
                            height: 52,
                            width: 83,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: AppColors.kGray2,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(countrySellerDto!.flagPath, width: 24, height: 24),
                                SizedBox(width: 8),
                                Text(
                                  '${countrySellerDto?.code}',
                                  style: AppTextStyles.size16Weight400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6),

                      // Поле ввода
                      Flexible(
                        child: Container(
                          height: 52,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.kGray2,
                            borderRadius: BorderRadius.circular(16),
                            border: fieldErrors['phone'] != null
                                ? Border.all(color: Colors.red, width: 1.0)
                                : null,
                          ),
                          child: TextField(
                            controller: phoneControllerAuth,
                            keyboardType: TextInputType.phone,
                            style: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF636366)),
                            decoration: InputDecoration(
                              hintText: 'Введите номер телефона',
                              hintStyle: AppTextStyles.size16Weight400.copyWith(
                                color: Color(0xFF8E8E93),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (fieldErrors['phone'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 4),
                      child: Text(
                        fieldErrors['phone']!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  SizedBox(height: 12),
                  Text(
                    'Пароль',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.size13Weight500.copyWith(color: Color(0xFF636366)),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 16), // Increased horizontal padding
                    decoration: BoxDecoration(
                      color: AppColors.kGray2,
                      borderRadius: BorderRadius.circular(16),
                      border: fieldErrors['password'] != null
                          ? Border.all(color: Colors.red, width: 1.0)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: passwordControllerAuth,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите пароль',
                              hintStyle: AppTextStyles.size16Weight400.copyWith(
                                color: Color(0xFF8E8E93),
                              ),
                              contentPadding: EdgeInsets.zero, // Better control over padding
                              isDense: true,
                            ),
                            onChanged: (value) {
                              setState(() {
                                isButtonEnabled = value.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        // if (__visibleIconView) // Only show icon when there's text
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Image.asset(
                              _passwordVisible
                                  ? Assets.icons.passwordViewHiddenIcon.path
                                  : Assets.icons.passwordViewIcon.path,
                              scale: 1.9,
                              color: AppColors.kGray300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (fieldErrors['password'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 4),
                      child: Text(
                        fieldErrors['password']!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 36),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.01,
                    ),
                    child: DefaultButton(
                      backgroundColor: AppColors.mainPurpleColor,
                      text: 'Войти',
                      press: () {
                        if (isLoading) return;
                        _validateFields();

                        if (!_ensureValid()) return;
                        if (phoneControllerAuth.text.length >= 15 ||
                            passwordControllerAuth.text.isEmpty) {
                          final login = BlocProvider.of<LoginCubit>(context);
                          login.login(phoneControllerAuth.text, passwordControllerAuth.text);
                        } else {
                          AppSnackBar.show(
                            context,
                            'Заполните все данныые',
                            type: AppSnackType.error,
                          );
                        }
                      },
                      color: Colors.white,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      context.router.push(const ForgotPasswordRoute());
                    },
                    child: Center(
                      child: Text(
                        'Забыли пароль?',
                        style: AppTextStyles.size18Weight600.copyWith(
                          color: AppColors.mainPurpleColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'У вас нет аккаунта? ',
                        style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kGray300),
                      ),
                      InkWell(
                        onTap: () {
                          context.router.push(RegisterRoute());
                        },
                        child: Text(
                          'Зарегистрироваться',
                          style: AppTextStyles.size18Weight600.copyWith(
                            color: AppColors.mainPurpleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isLoading)
              const Positioned.fill(
                child: ColoredBox(
                  color: Colors.white70,
                  child: Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
                ),
              ),
          ],
        );
      },
    );
  }
}
