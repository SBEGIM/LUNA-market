import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_module_cities_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart'
    as cityCubit;
import 'package:haji_market/src/feature/drawer/bloc/country_state.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/common/constants.dart';
import '../../../drawer/bloc/country_cubit.dart';

Future<dynamic> showAlertCountryWidget(
  BuildContext context,
  Function()? callBack,
  bool shop,
) async {
  int? selectedCountryId;
  String? selectedCountryCode;
  String? selectedCountryName;

  final TextEditingController searchController = TextEditingController();
  final rootContext = Get.context ?? context;

  // тут будем хранить список стран из кубита и отфильтрованный
  List<dynamic> allCountries = [];
  List<dynamic> filteredCountries = [];

  return showMaterialModalBottomSheet(
    context: rootContext,
    expand: false,
    backgroundColor: AppColors.kGray1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          final media = MediaQuery.of(ctx);

          return SizedBox(
            height: media.size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Выберите страну для СДЕК',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1.1,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: SizedBox(
                            width: 22,
                            height: 22,
                            child: Image.asset(
                              Assets.icons.defaultCloseIcon.path,
                              fit: BoxFit.contain,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Список стран
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: BlocBuilder<CountryCubit, CountryState>(
                        builder: (context, state) {
                          if (state is LoadedState) {
                            // сохраняем список из кубита один раз
                            if (allCountries.isEmpty) {
                              allCountries = state.country;
                              if (searchController.text.isNotEmpty) {
                                final q = searchController.text.toLowerCase();
                                filteredCountries = allCountries.where((c) {
                                  final name =
                                      (c.name ?? '').toString().toLowerCase();
                                  return name.contains(q);
                                }).toList();
                              }
                            }

                            final list = (filteredCountries.isNotEmpty ||
                                    searchController.text.isNotEmpty)
                                ? filteredCountries
                                : allCountries;

                            return ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              itemCount: list.length,
                              separatorBuilder: (_, __) => const Divider(
                                height: 1,
                                color: AppColors.kGray2,
                              ),
                              itemBuilder: (context, index) {
                                final item = list[index];
                                final bool isSelected =
                                    selectedCountryId != null &&
                                        selectedCountryId == item.id;

                                return InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    setState(() {
                                      selectedCountryId = item.id as int?;
                                      selectedCountryCode =
                                          item.code?.toString();
                                      selectedCountryName =
                                          item.name?.toString();
                                    });
                                  },
                                  child: Container(
                                    height: 52,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.name ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 1.2,
                                              color: isSelected
                                                  ? AppColors.mainPurpleColor
                                                  : Colors.black,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          const Icon(
                                            Icons.check,
                                            color: AppColors.mainPurpleColor,
                                            size: 18,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Кнопка "Выбрать" — открывает модалку городов
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16 + media.viewPadding.bottom,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: selectedCountryId != null
                          ? () async {
                              // Берём кубит городов и стабильный контекст
                              final citiesCubit =
                                  BlocProvider.of<cityCubit.CityCubit>(ctx);
                              final navigatorContext = Get.context ?? ctx;

                              // закрываем модалку стран
                              Navigator.of(ctx).pop();

                              // сохраняем выбранную страну
                              if (selectedCountryName != null) {
                                GetStorage()
                                    .write('country', selectedCountryName);
                              }
                              if (selectedCountryId != null) {
                                GetStorage().write(
                                  'user_country_id',
                                  selectedCountryId.toString(),
                                );
                              }

                              // грузим города по коду страны
                              final data = await citiesCubit
                                  .citiesCdek(selectedCountryCode ?? 'KZ');

                              // открываем модалку городов в новом контексте
                              showModuleCities(
                                navigatorContext,
                                'Область/Район ОГД',
                                data,
                                (CityModel city) {
                                  print(city.lat);
                                  print(city.long);
                                  final box = GetStorage();
                                  box.write('city', city.toJson());
                                  callBack?.call();
                                },
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        disabledBackgroundColor:
                            AppColors.boxDecorBackgroundPurpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Выбрать',
                        style: AppTextStyles.size18Weight600
                            .copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
