import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/presentation/guest_user_page.dart';
import 'package:haji_market/src/feature/app/widget/show_city_widget.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_city_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import '../../../core/constant/generated/assets.gen.dart';

class GeoPositionPage extends StatefulWidget {
  int contryId;
  String countryCode;

  GeoPositionPage({required this.contryId, required this.countryCode, super.key});

  @override
  State<GeoPositionPage> createState() => _GeoPositionPageState();
}

class _GeoPositionPageState extends State<GeoPositionPage> {
  final List<Map<String, dynamic>> countries = [
    {'icon': Assets.icons.ruFlagIcon.path, 'name': 'Россия'},
    {'icon': Assets.icons.belFlagIcon.path, 'name': 'Беларусь'},
    {'icon': Assets.icons.kzFlagIcon.path, 'name': 'Казахстан'},
    {'icon': Assets.icons.krFlagIcon.path, 'name': 'Киргизия'},
    {'icon': Assets.icons.arFlagIcon.path, 'name': 'Армения'},
    {'icon': Assets.icons.uzFlagIcon.path, 'name': 'Узбекстан'},
  ];

  int _select = -1;

  List<CityModel> _cities = [];

  @override
  void initState() {
    BlocProvider.of<CityCubit>(context).citiesCdek(widget.countryCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 149),
            Image.asset(Assets.images.geoPosition.path, height: 346),
            SizedBox(height: 71),
            Text(
              'Разрешите доступ \nк геопозиции',
              style: AppTextStyles.defButtonTextStyle.copyWith(
                color: AppColors.kLightBlackColor,
                fontWeight: FontWeight.w600,
                fontSize: 32,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Покажем, какие есть способы доставки',
              style: AppTextStyles.catalogTextStyle.copyWith(
                color: AppColors.kNeutralBlackColor,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                height: 24 / 18,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 46),
            DefaultButton(
              text: 'Продолжить',
              press: () {
                Get.off(GuestUserPage());
                // BlocProvider.of<AppBloc>(context)
                //     .add(const AppEvent.checkAuth());
              },
              color: AppColors.kWhite,
              backgroundColor: AppColors.mainPurpleColor,
              textStyle: AppTextStyles.aboutTextStyle.copyWith(
                color: AppColors.kWhite,
                fontSize: 18,
                height: 24 / 18,
                fontWeight: FontWeight.w600,
              ),
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                GetStorage().write('country', 'Казахстан');
                GetStorage().write('user_country_id', widget.contryId.toString());

                List<CityModel> _cities = await BlocProvider.of<CityCubit>(
                  context,
                ).citiesList(widget.countryCode);

                showCitiesOptions(context, 'Выберите город', _cities, (CityModel value) {
                  GetStorage().write('city_shop', value.city);
                });
              },
              child: Center(
                child: Text(
                  'Указать город вручную',
                  style: AppTextStyles.aboutTextStyle.copyWith(
                    color: AppColors.mainPurpleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
