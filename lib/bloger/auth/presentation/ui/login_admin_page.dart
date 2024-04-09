import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/admin/auth/data/bloc/login_admin_cubit.dart';
import 'package:haji_market/admin/auth/data/bloc/login_admin_state.dart';
import 'package:haji_market/admin/auth/presentation/ui/register_shop_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';

import 'forgot_blogger_password.dart';

class LoginAdminPage extends StatefulWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  State<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool __visibleIconView = false;
  bool isButtonEnabled = false;

  @override
  void initState() {
    BlocProvider.of<LoginAdminCubit>(context).emit(InitState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        // appBar: AppBar(
        //   // actions: [
        //   //   Padding(
        //   //     padding: const EdgeInsets.only(right: 22.0),
        //   //     child: CustomDropButton(
        //   //       onTap: () {},
        //   //     ),
        //   //   ),
        //   // ],
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   centerTitle: true,
        //   title: const Text(
        //     'Вход',
        //     style: AppTextStyles.appBarTextStyle,
        //   ),
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 22.0),
        //     child: CustomBackButton(onTap: () {
        //       Navigator.pop(context);
        //     }),
        //   ),
        // ),
        body: BlocConsumer<LoginAdminCubit, LoginAdminState>(listener: (context, state) {
          if (state is LoadedState) {
            context.router.push(RegisterShopRoute(shopName: nameController.text));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           RegisterShopPage(shopName: nameController.text)),
            // );
          }
        }, builder: (context, state) {
          if (state is InitState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          horizontalTitleGap: 0,
                          leading: Column(
                            children: [
                              const SizedBox(height: 18),
                              SvgPicture.asset(
                                'assets/icons/login.svg',
                                height: 22,
                                width: 22,
                              ),
                            ],
                          ),
                          title: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Ваш логин',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: 0,
                          leading: SvgPicture.asset(
                            'assets/icons/password.svg',
                            height: 24,
                            width: 24,
                          ),
                          title: TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: !_passwordVisible,

                            // inputFormatters: [maskFormatter],
                            // controller: phoneControllerAuth,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите пароль',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            onChanged: (value) {
                              passwordController.text.isEmpty ? __visibleIconView = false : __visibleIconView = true;
                              if (passwordController.text.isNotEmpty) {
                                isButtonEnabled = true;
                                setState(() {});
                              } else {
                                isButtonEnabled = false;
                                setState(() {});
                              }
                            },
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: __visibleIconView == true
                                ? Icon(
                                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                    color: const Color.fromRGBO(177, 179, 181, 1),
                                  )
                                : const SizedBox(width: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    context.router.push(const ForgotPasswordAdminRoute());
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const ForgotPasswordAdminPage()),
                    // );
                  },
                  child: const Center(
                    child: Text(
                      'Забыли пароль?',
                      style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom * 0.01,
                  ),
                  child: DefaultButton(
                      backgroundColor: AppColors.kPrimaryColor,
                      text: 'Войти',
                      press: () {
                        final login = BlocProvider.of<LoginAdminCubit>(context);

                        login.login(nameController.text, passwordController.text);
                      },
                      color: Colors.white,
                      width: 343),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
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
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        }));
  }
}
