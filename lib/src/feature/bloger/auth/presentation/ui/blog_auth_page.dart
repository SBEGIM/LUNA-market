import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/feature/bloger/coop_request/presentation/ui/coop_request_page.dart';
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

  @override
  void initState() {
    countrySellerDto = CountrySellerDto(
        code: '+7', flagPath: Assets.icons.ruFlagIcon.path, name: 'Россия');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloggerCubit, LoginBloggerState>(
        listener: (context, state) {
      if (state is LoadedState) {
        BlocProvider.of<AppBloc>(context)
            .add(const AppEvent.chageState(state: AppState.inAppBlogerState()));
        context.router
            .popUntil((route) => route.settings.name == LauncherRoute.name);
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
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Войти',
                textAlign: TextAlign.start,
                style: AppTextStyles.defaultAppBarTextStyle
                    .copyWith(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 23),
              Text('Номер телефона',
                  textAlign: TextAlign.start,
                  style: AppTextStyles.categoryTextStyle
                      .copyWith(fontSize: 13, color: AppColors.kGray300)),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.kGray2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              countrySellerDto!.flagPath,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 10),
                            Text('${countrySellerDto!.code}',
                                style: TextStyle(fontSize: 16)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.kGray2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: phoneControllerAuth,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Введите номер телефона',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Пароль',
                  textAlign: TextAlign.start,
                  style: AppTextStyles.categoryTextStyle
                      .copyWith(fontSize: 13, color: AppColors.kGray300)),
              SizedBox(height: 10),
              Container(
                height: 52,
                padding: EdgeInsets.symmetric(
                    horizontal: 16), // Increased horizontal padding
                decoration: BoxDecoration(
                  color: AppColors.kGray2,
                  borderRadius: BorderRadius.circular(12),
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
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
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
                    // if (__visibleIconView) // Only show icon when there's text
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.kGray200,
                          size: 20,
                        ),
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
                    if (phoneControllerAuth.text.length >= 15 ||
                        passwordController.text.isEmpty) {
                      final login = BlocProvider.of<LoginBloggerCubit>(context);
                      login.login(
                          phoneControllerAuth.text, passwordController.text);
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
                  context.router.push(const ForgotPasswordBLoggerRoute());
                },
                child: const Center(
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                        color: AppColors.mainPurpleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'У вас нет аккаунта? ',
                    style: AppTextStyles.defaultButtonTextStyle.copyWith(
                        fontSize: 16,
                        color: AppColors.kGray300,
                        fontWeight: FontWeight.w200),
                  ),
                  InkWell(
                    onTap: () {
                      // context.pushRoute(RegisterSellerRoute());
                      Get.to(BlogRegisterPage());
                    },
                    child: Text(
                      'Зарегистрироваться',
                      style: AppTextStyles.defaultButtonTextStyle.copyWith(
                          color: AppColors.mainPurpleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              )
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
