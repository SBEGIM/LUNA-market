import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/widgets/custom_cupertino_action_sheet.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_state.dart';
import '../../../seller/profile/data/bloc/profile_edit_admin_cubit.dart';
import '../../../../core/common/constants.dart';
import '../../../auth/bloc/login_cubit.dart';

Future<dynamic> showAlertCityWidget(BuildContext context, bool shop) async {
  int? city;
  int? cityCode;
  String? cityName;
  TextEditingController controller = TextEditingController();

  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) =>
        StatefulBuilder(builder: (context, setState) {
      return CustomCupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Column(children: [
              Text(
                'Выберите город',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F7),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: CupertinoTextField(
                        controller: controller,
                        onChanged: (value) {
                          BlocProvider.of<CityCubit>(context)
                              .searchCdekCity(value);
                        },
                        placeholder: 'Поиск города',
                        textAlign: TextAlign.start,
                        placeholderStyle: const TextStyle(color: Colors.grey),
                        decoration: null,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              BlocConsumer<CityCubit, CityState>(
                listener: (context, state) {
                  if (state is LoadedState) {
                    setState(() {});
                  }
                },
                builder: (context, state) {
                  if (state is LoadedState) {
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight:
                              (MediaQuery.of(context).size.height) * 0.85),
                      height: state.city.length * 50,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.city.length,
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                city = index;
                                cityCode = state.city[index].code as int;

                                cityName = state.city[index].city;
                                setState(() {});
                              }),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: city == index
                                      ? BorderRadius.circular(8)
                                      : null,
                                  border: city == index
                                      ? Border.all(
                                          color: AppColors.mainPurpleColor,
                                          width: 1.5,
                                        )
                                      : const Border(
                                          bottom: BorderSide(
                                            color: AppColors.kGray2,
                                            width: 1.0,
                                          ),
                                        ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${state.city[index].city}',
                                      style: TextStyle(
                                          color: city == index
                                              ? AppColors.mainPurpleColor
                                              : Colors.black,
                                          fontWeight: city == index
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    if (city == index)
                                      const Icon(Icons.check,
                                          color: AppColors.mainPurpleColor,
                                          size: 18),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else if (state is NodataState) {
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset('assets/icons/no_data.png'),
                          const Text(
                            'Нет данных',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'Для этой страны не найдены города',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff717171)),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator.adaptive();
                  }
                },
              )
            ]),
            onPressed: () {},
          ),
        ],
        cancelButton: GestureDetector(
          onTap: () async {
            if (!shop) {
              final edit = BlocProvider.of<LoginCubit>(context);
              await edit.cityCode(cityCode);
            } else {
              await BlocProvider.of<ProfileEditAdminCubit>(context)
                  .cityCode(cityCode);
            }

            GetStorage().write('city_shop', cityName);

            Get.back();
          },
          child: CupertinoActionSheetAction(
            child: const Text(
              'Выбрать',
              style: TextStyle(
                  color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
            ),
            onPressed: () async {
              // city != null ? GetStorage().write('country', country) : null;
              // Get.back();

              // Get.to(() => new BasketOrderAddressPage());
              // callBack?.call();
            },
          ),
        ),
      );
    }),
  );
}
