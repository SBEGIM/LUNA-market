import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_state.dart';
import '../../../seller/profile/data/bloc/profile_edit_admin_cubit.dart';
import '../../../../core/common/constants.dart';
import '../../../auth/bloc/login_cubit.dart';

Future<dynamic> showAlertCityWidget(BuildContext context, bool shop) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      int? selectedIndex;
      int? cityCode;
      String? cityName;
      final TextEditingController controller = TextEditingController();

      return StatefulBuilder(
        builder: (context, setState) {
          final size = MediaQuery.of(context).size;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.black.withOpacity(0.4), // полупрозрачный фон
              child: SafeArea(
                top: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.9,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        // Заголовок + крестик
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Область/Район ОГД',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => Get.back(),
                                child: const Icon(
                                  CupertinoIcons.xmark,
                                  size: 22,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Поиск
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CupertinoSearchTextField(
                            controller: controller,
                            placeholder: 'Поиск',
                            onChanged: (value) {
                              BlocProvider.of<CityCubit>(context).searchCdekCity(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Карточка со списком
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: BlocConsumer<CityCubit, CityState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is LoadedState) {
                                    return ListView.separated(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      itemCount: state.city.length,
                                      separatorBuilder: (_, __) =>
                                          const Divider(height: 1, color: AppColors.kGray2),
                                      itemBuilder: (context, index) {
                                        final item = state.city[index];
                                        final bool isSelected = selectedIndex == index;

                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                              cityCode = item.code as int?;
                                              cityName = item.city;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? const Color(0xFFF2EDFF)
                                                  : Colors.white,
                                              borderRadius: isSelected
                                                  ? BorderRadius.circular(8)
                                                  : null,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${item.city}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: isSelected
                                                        ? FontWeight.w600
                                                        : FontWeight.w400,
                                                    color: isSelected
                                                        ? AppColors.mainPurpleColor
                                                        : Colors.black,
                                                  ),
                                                ),
                                                if (isSelected)
                                                  const Icon(
                                                    Icons.check,
                                                    size: 18,
                                                    color: AppColors.mainPurpleColor,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (state is NodataState) {
                                    return Center(
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(24),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/icons/no_data.png'),
                                            const SizedBox(height: 16),
                                            const Text(
                                              'Нет данных',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              'Для этой страны не найдены города',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff717171),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
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
                        const SizedBox(height: 12),
                        // Кнопка "Выбрать" как внизу на iOS
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16 + MediaQuery.of(context).viewPadding.bottom,
                          ),
                          child: CupertinoButton.filled(
                            borderRadius: BorderRadius.circular(16),
                            onPressed: () async {
                              if (cityCode == null) {
                                Get.back(); // или можно ничего не делать
                                return;
                              }

                              if (!shop) {
                                final edit = BlocProvider.of<LoginCubit>(context);
                                await edit.cityCode(cityCode);
                              } else {
                                await BlocProvider.of<ProfileEditAdminCubit>(
                                  context,
                                ).cityCode(cityCode);
                              }

                              if (cityName != null) {
                                GetStorage().write('city', cityName);
                              }

                              Get.back();
                            },
                            child: const Text(
                              'Выбрать',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
