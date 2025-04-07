import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/custom_cupertino_action_sheet.dart';
import 'package:haji_market/src/feature/basket/presentation/ui/map_picker.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_state.dart';
import '../../../../core/common/constants.dart';

Future<dynamic> showAlertCityBasketWidget(
    BuildContext context, bool shop) async {
  int? city;
  int? cityCode;
  double? lat;
  double? long;
  TextEditingController controller = TextEditingController();

  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) =>
        StatefulBuilder(builder: (context, setState) {
      return CustomCupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Выберите город',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    color: AppColors.kDark,
                  ),
                )
              ],
            ),
            onPressed: () {},
          ),
          CupertinoActionSheetAction(
            child: BlocConsumer<CityCubit, CityState>(
              listener: (context, state) {
                if (state is LoadedState) {
                  setState(() {});
                }
              },
              builder: (context, state) {
                if (state is LoadedState) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: CupertinoTextField(
                          controller: controller,
                          placeholder: 'Поиск городов ...',
                          onChanged: (value) {
                            BlocProvider.of<CityCubit>(context)
                                .searchCdekCity(value);
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                (MediaQuery.of(context).size.height) * 0.85),
                        height: state.city.length * 50,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.city.length,
                            itemBuilder: (context, int index) {
                              return SizedBox(
                                height: 50,
                                child: GestureDetector(
                                  onTap: () {
                                    city = index;
                                    cityCode = state.city[index].code as int;
                                    lat = state.city[index].lat;
                                    long = state.city[index].long;
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        city == index
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: AppColors.kPrimaryColor,
                                        size: 24.0,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "${state.city[index].city ?? ''}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "${state.city[index].code ?? '--'}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                  // } else if (state is NoDataState) {
                  //   return SizedBox(
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Image.asset('assets/icons/no_data.png'),
                  //         const Text(
                  //           'У вас нет адресов для доставки',
                  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         const Text(
                  //           'Добавьте адреса для доставки товаров',
                  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff717171)),
                  //           textAlign: TextAlign.center,
                  //         )
                  //       ],
                  //     ),
                  //   );
                  // }
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
            ),
            onPressed: () {},
          ),
          // CupertinoActionSheetAction(
          //   child: const Text(
          //     'Добавить новый адрес',
          //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          //   ),
          //   onPressed: () {
          //     // showAlertAddWidget(context, product);
          //     Navigator.pop(context);
          //     showAlertStoreWidget(context);
          //   },
          // ),
        ],
        cancelButton: GestureDetector(
          onTap: () async {
            // city != null ? GetStorage().write('country', country) : null;
            // Get.back();
            // if (!shop) {
            //   final edit = BlocProvider.of<LoginCubit>(context);
            //   await edit.cityCode(cityCode);
            // } else {
            //   await BlocProvider.of<ProfileEditAdminCubit>(context).cityCode(cityCode);
            // }

            final data = await Get.to(() => MapPickerPage(
                  cc: cityCode,
                  lat: lat,
                  long: long,
                ));

            GetStorage().write('cc', data);

            //  Get.back(result: place);

            // Get.back();

            if (data != null) {
              context.router.push(
                  BasketOrderAddressRoute(fulfillment: 'fbs', office: data));

              // Get.to(() => BasketOrderAddressPage(
              //       office: data,
              //       fulfillment: 'fbs',
              //     ));
            }

            // callBack?.call();
          },
          child: CupertinoActionSheetAction(
            child: const Text(
              'Выбрать',
              style: TextStyle(
                  color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
            ),
            onPressed: () async {},
          ),
        ),
      );
    }),
  );
}
