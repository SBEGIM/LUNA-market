import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/sms_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/sms_seller_state.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/login_forget_password_modal_bottom.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../../core/constant/generated/assets.gen.dart';

@RoutePage()
class ForgotPasswordSellerPage extends StatefulWidget {
  const ForgotPasswordSellerPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordSellerPage> createState() => _ForgotPasswordSellerPageState();
}

class _ForgotPasswordSellerPageState extends State<ForgotPasswordSellerPage> {
  TextEditingController phoneControllerAuth = MaskedTextController(mask: '(000)-000-00-00');

  bool _visibleIconView = false;
  CountrySellerDto? countrySellerDto;

  @override
  void initState() {
    // TODO: implement initState

    countrySellerDto = CountrySellerDto(
      code: '+7',
      flagPath: Assets.icons.ruFlagIcon.path,
      name: 'Россия',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CustomBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<SmsSellerCubit, SmsSellerState>(
        listener: (context, state) {
          if (state is LoadedState) {
            context.pushRoute(
              LoginForgotSellerPasswordRoute(
                countryCode: countrySellerDto!.code,
                textEditingController: phoneControllerAuth.text,
              ),
            );
            // LoginForgotSellerPasswordPage(
            //  ,
            // );
            // showModalBottomSheet(
            //     backgroundColor: Colors.white,
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(10.0),
            //           topRight: Radius.circular(10.0)),
            //     ),
            //     context: context,
            //     builder: (context) {
            //       return ();
            //     });
          }
        },
        builder: (context, state) {
          if (state is InitState) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Введите номер телефона', style: AppTextStyles.size28Weight700),
                  SizedBox(height: 23),
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
                                  '${countrySellerDto!.code}',
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
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.kGray2,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            onChanged: (value) {
                              phoneControllerAuth.text.length.toInt() != 0
                                  ? _visibleIconView = true
                                  : _visibleIconView = false;
                              setState(() {});
                            },
                            controller: phoneControllerAuth,
                            keyboardType: TextInputType.phone,
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
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.001,
                    ),
                    child: DefaultButton(
                      backgroundColor: phoneControllerAuth.text.length >= 15
                          ? AppColors.mainPurpleColor
                          : AppColors.mainBackgroundPurpleColor,
                      text: 'Получить код',
                      press: () {
                        if (phoneControllerAuth.text.length >= 15) {
                          final sms = BlocProvider.of<SmsSellerCubit>(context);
                          sms.resetSend(context, phoneControllerAuth.text);
                        } else {
                          AppSnackBar.show(
                            context,
                            'Номер телефона пустой',
                            type: AppSnackType.error,
                          );
                        }
                      },
                      color: Colors.white,
                      width: double.infinity,
                    ),
                  ),
                ],
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
