import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/feature/bloger/coop_request/presentation/ui/blogger_register_page.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../core/constant/generated/assets.gen.dart';
import '../../../../seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import '../../bloc/login_blogger_cubit.dart';
import '../../bloc/login_blogger_state.dart';

class BlogAuthPage extends StatefulWidget {
  const BlogAuthPage({Key? key}) : super(key: key);

  @override
  State<BlogAuthPage> createState() => _BlogAuthPageState();
}

class _BlogAuthPageState extends State<BlogAuthPage> {
  bool isButtonEnabled = false;
  bool _passwordVisible = false;
  bool _visibleIconClear = false;
  bool __visibleIconView = false;

  CountrySellerDto? countrySellerDto;

  setIsButtonEnabled(bool value) {
    // log("is button state changed $value");
    isButtonEnabled = value;

    setState(() {});
  }

  TextEditingController phoneControllerAuth =
      MaskedTextController(mask: '(000)-000-00-00');
  TextEditingController passwordController = TextEditingController();

  Map<String, String?> fieldErrors = {
    'phone': null,
    'password': null,
  };

  @override
  void initState() {
    countrySellerDto = CountrySellerDto(
        code: '+7', flagPath: Assets.icons.ruFlagIcon.path, name: 'Россия');

    for (final c in [
      phoneControllerAuth,
      passwordController,
    ]) {
      c.addListener(() => setState(() {}));
    }
    super.initState();
  }

  String? _validateError() {
    final rawDigits =
        phoneControllerAuth.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawDigits.length != 10) return 'Введите корректный номер телефона';

    final pass = passwordController.text;
    if (pass.isEmpty) return 'Введите пароль';

    return null;
  }

  void _validateFields() {
    final phone = phoneControllerAuth.text.replaceAll(RegExp(r'[^0-9]'), '');
    final pass = passwordController.text;

    setState(() {
      fieldErrors['phone'] =
          phone.length != 10 ? 'Введите корректный номер телефона' : null;

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
    return BlocConsumer<LoginBloggerCubit, LoginBloggerState>(
        listener: (context, state) {
      if (state is LoadedState) {
        final router = AutoRouter.of(context).root; // гарантированно корень
        context.read<AppBloc>().add(
              const AppEvent.chageState(
                  state: AppState.inAppBlogerState(index: 0)),
            );
        router.replaceAll([const LauncherRoute()]);

        // Get.to(() => ());

        // Get.to(() => const BaseBlogger(
        //       index: 0,
        //     ));

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Base()),
        // );
      }
    }, builder: (context, state) {
      if (state is InitState) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Войти',
                textAlign: TextAlign.start,
                style: AppTextStyles.defaultAppBarTextStyle
                    .copyWith(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 24),
              Text(
                  fieldErrors['phone'] == null
                      ? 'Номер телефона'
                      : fieldErrors['phone']!,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.size13Weight500.copyWith(
                      color: fieldErrors['phone'] == null
                          ? Color(0xFF636366)
                          : AppColors.mainRedColor)),
              SizedBox(height: 8),
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
                          border: fieldErrors['phone'] != null
                              ? Border.all(
                                  color: AppColors.mainRedColor, width: 1.0)
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              countrySellerDto!.flagPath,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 8),
                            Text('${countrySellerDto!.code}',
                                style: AppTextStyles.size16Weight400),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  // Поле ввода
                  Flexible(
                    child: Container(
                      height: 52,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      decoration: BoxDecoration(
                        color: AppColors.kGray2,
                        borderRadius: BorderRadius.circular(16),
                        border: fieldErrors['phone'] != null
                            ? Border.all(
                                color: AppColors.mainRedColor, width: 1.0)
                            : null,
                      ),
                      child: TextField(
                        controller: phoneControllerAuth,
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Введите номер телефона',
                          hintStyle: AppTextStyles.size16Weight400
                              .copyWith(color: Color(0xFF8E8E93)),
                          border: InputBorder.none,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .unfocus(); // закрыть клавиатуру
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                  fieldErrors['password'] == null
                      ? 'Пароль'
                      : fieldErrors['password']!,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.size13Weight500.copyWith(
                      color: fieldErrors['password'] == null
                          ? Color(0xFF636366)
                          : AppColors.mainRedColor)),
              SizedBox(height: 10),
              Container(
                height: 52,
                padding: EdgeInsets.symmetric(
                    horizontal: 16), // Increased horizontal padding
                decoration: BoxDecoration(
                  color: AppColors.kGray2,
                  borderRadius: BorderRadius.circular(16),
                  border: fieldErrors['phone'] != null
                      ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                      : null,
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите пароль',
                          hintStyle: AppTextStyles.size16Weight400
                              .copyWith(color: Color(0xFF8E8E93)),
                          contentPadding:
                              EdgeInsets.zero, // Better control over padding
                          isDense: true,
                        ),
                        onChanged: (value) {
                          setState(() {
                            __visibleIconView = value.isNotEmpty;
                            isButtonEnabled = value.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: Image.asset(
                        _passwordVisible
                            ? Assets.icons.passwordViewHiddenIcon.path
                            : Assets.icons.passwordViewIcon.path,
                        scale: 1.9,
                        color: AppColors.kGray300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom * 0.01,
                ),
                child: DefaultButton(
                  width: double.infinity,
                  backgroundColor: AppColors.mainPurpleColor,
                  text: 'Войти',
                  press: () {
                    _validateFields();
                    if (!_ensureValid()) return;

                    if (phoneControllerAuth.text.length >= 15 ||
                        passwordController.text.isEmpty) {
                      final login = BlocProvider.of<LoginBloggerCubit>(context);
                      login.login(context, phoneControllerAuth.text,
                          passwordController.text);
                    } else {
                      Get.snackbar('Ошибка запроса', 'Заполните все данныые',
                          backgroundColor: Colors.blueAccent);
                    }
                  },
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  context.router.push(const ForgotPasswordBloggerRoute());
                },
                child: Center(
                  child: Text(
                    'Забыли пароль?',
                    style: AppTextStyles.size18Weight600
                        .copyWith(color: AppColors.mainPurpleColor),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'У вас нет аккаунта? ',
                    style: AppTextStyles.size18Weight600.copyWith(
                      color: AppColors.kGray300,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.pushRoute(BlogRegisterRoute());
                      // Get.to(BlogRegisterPage());
                    },
                    child: Text(
                      'Зарегистрироваться',
                      style: AppTextStyles.size18Weight600
                          .copyWith(color: AppColors.mainPurpleColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
      if (state is ErrorState) {
        return Center(
          child: Text(
            state.message,
            style: const TextStyle(color: Colors.redAccent),
          ),
        );
      } else {
        return const Center(
            child: CircularProgressIndicator(color: Colors.indigoAccent));
      }
    });
  }
}
