import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import '../../../core/constant/generated/assets.gen.dart';

@RoutePage()
class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  int contryId = 1;
  String contryCode = 'KZ';

  final List<Map<String, dynamic>> countries = [
    {'icon': Assets.icons.ruFlagIcon.path, 'id': 1, 'name': 'Россия', 'code': 'RU'},
    {'icon': Assets.icons.belFlagIcon.path, 'id': 2, 'name': 'Беларусь', 'code': 'BY'},
    {'icon': Assets.icons.kzFlagIcon.path, 'id': 3, 'name': 'Казахстан', 'code': 'KZ'},
    {'icon': Assets.icons.krFlagIcon.path, 'id': 4, 'name': 'Киргизия', 'code': 'KG'},
    {'icon': Assets.icons.arFlagIcon.path, 'id': 5, 'name': 'Армения', 'code': 'AM'},
    {'icon': Assets.icons.uzFlagIcon.path, 'id': 6, 'name': 'Узбекстан', 'code': 'UZ'},
  ];

  int _select = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFAD32F8), // Фиолетовый
              Color(0xFF3275F8), // Синий
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 72),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 646,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 54),
                    Text(
                      'Добро пожаловать!',
                      style: AppTextStyles.defButtonTextStyle.copyWith(
                        color: AppColors.kWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Пожалуйста, выберите страну:',
                      style: AppTextStyles.catalogTextStyle.copyWith(
                        color: AppColors.kGray1.withValues(alpha: 0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      // Это решает проблему ListView
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: countries.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (_select == index) {
                                _select = -1;
                                contryId = 1;
                                contryCode = 'KZ';

                                setState(() {});
                                return;
                              }
                              _select = index;
                              contryId = countries[index]['id'];
                              contryCode = countries[index]['code'];
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                height: 60,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEAECED).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('${countries[index]['icon']}', height: 32),
                                    SizedBox(width: 5),
                                    Text(
                                      '${countries[index]['name']}',
                                      style: AppTextStyles.catalogTextStyle.copyWith(
                                        color: AppColors.kWhite,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    _select == index
                                        ? SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Image.asset(
                                              Assets.icons.defaultCheckIcon.path,
                                              color: AppColors.kWhite,
                                            ),
                                          )
                                        : Icon(
                                            Icons.radio_button_unchecked,
                                            color: AppColors.kWhite,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 20),
              child: DefaultButton(
                text: 'Продолжить',
                press: () {
                  if (_select != -1) {
                    context.router.push(GeoPositionRoute(contryId: contryId, countryCode: contryCode));
                  }
                },
                color: AppColors.kLightBlackColor,
                backgroundColor: AppColors.kWhite,
                textStyle: AppTextStyles.titleTextStyle.copyWith(
                  height: 1.33,
                  color: _select != -1 ? Color(0xFF0F0F0F) : Color(0XFFD1D1D6),
                ),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
