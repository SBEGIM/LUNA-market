import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/auth/bloc/sms_state.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import '../../bloc/sms_cubit.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  final String textEditingController;
  const ChangePasswordPage({super.key, required this.textEditingController});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordNew = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();

  bool _visibleIconView = true;
  bool _visibleIconViewRepeat = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: BlocConsumer<SmsCubit, SmsState>(
        listener: (context, state) {
          if (state is ResetSuccessState) {
            // context.router.pushAndPopUntil(
            //   ViewAuthRegisterRoute(backButton: true),
            //   predicate: (route) => route.settings.name == LauncherRoute.name,
            // );
            // context.router.replace(ViewAuthRegisterRoute(backButton: true));
            // context.router.replaceAll([
            //   ViewAuthRegisterRoute(backButton: true),
            // ]);

            // BlocProvider.of<AppBloc>(context).add(
            //   AppEvent.chageState(state: AppState.notAuthorizedState()),
            // );

            // final router = AutoRouter.of(context).root; // или context.router
            // for (var i = 0; i < 3; i++) {
            //   context.router.pop();
            // }
            // context.router.root.replaceAll([
            //   ViewAuthRegisterRoute(backButton: true),
            // ]);

            // context.router.pop();
            // BlocProvider.of<AppBloc>(context).add(const AppEvent.chageState(
            //     state: AppState.notAuthorizedState(button: true)));

            // context.router.push(ViewAuthRegisterRoute(backButton: true));

            AutoRouter.of(context).root.push(ViewAuthRegisterRoute(backButton: true));

            // AutoRouter.of(context).root.replaceAll([
            //   ViewAuthRegisterRoute(backButton: true),
            // ]);
          }
        },
        builder: (context, state) {
          if (state is InitState) {
            return Container(
              color: AppColors.kWhite,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Создайте новый пароль', style: AppTextStyles.size28Weight700),
                    SizedBox(height: 16),
                    FieldsCoopRequest(
                      titleText: 'Новый пароль',
                      hintText: 'Введите новый пароль',
                      star: false,
                      controller: passwordNew,
                      arrow: _visibleIconView,
                      onChanged: (value) {
                        setState(() {});
                      },
                      onPressed: () {
                        _visibleIconView = !_visibleIconView;
                        setState(() {});
                      },
                    ),
                    FieldsCoopRequest(
                      titleText: 'Повторите пароль',
                      hintText: 'Повторите новый пароль',
                      star: false,
                      arrow: _visibleIconViewRepeat,
                      onChanged: (value) {
                        setState(() {});
                      },
                      onPressed: () {
                        _visibleIconViewRepeat = !_visibleIconViewRepeat;
                        setState(() {});
                      },
                      controller: passwordRepeat,
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom * 0.001,
                      ),
                      child: DefaultButton(
                        backgroundColor: passwordNew.text == passwordRepeat.text
                            ? AppColors.mainPurpleColor
                            : AppColors.mainBackgroundPurpleColor,
                        text: 'Готово',
                        press: () {
                          if (passwordNew.text == passwordRepeat.text) {
                            final sms = BlocProvider.of<SmsCubit>(context);
                            sms.passwordReset(widget.textEditingController, passwordRepeat.text);
                          } else {
                            // Get.snackbar('Ошибка', 'Пароли не совпадают',
                            //     backgroundColor: Colors.blueAccent);
                          }
                        },
                        color: Colors.white,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.redAccent)),
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        },
      ),
    );
  }
}

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  const FieldsCoopRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText, style: AppTextStyles.size13Weight500.copyWith(color: Color(0xFF636366))),
          const SizedBox(height: 4),
          Container(
            height: 47,
            padding: const EdgeInsets.only(left: 16, right: 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.kBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              obscureText: arrow,
              keyboardType: TextInputType.text,
              controller: controller,
              textAlign: TextAlign.left,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF8E8E93)),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  // borderRadius: BorderRadius.circular(3),
                ),
                suffixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: onPressed,
                  icon: Image.asset(
                    arrow
                        ? Assets.icons.passwordViewHiddenIcon.path
                        : Assets.icons.passwordViewIcon.path,
                    scale: 1.9,
                    height: 22,
                    width: 22,
                    color: AppColors.kGray300,
                  ),
                ),

                // suffixIcon: IconButton(
                //     onPressed: () {},
                //     icon: SvgPicture.asset('assets/icons/back_menu.svg ',
                //         color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
