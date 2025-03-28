import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/app/widgets/custom_cupertino_action_sheet.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_city_basket_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart'
    as cityCubit;
import 'package:haji_market/src/feature/drawer/bloc/country_state.dart';
import '../../../../core/common/constants.dart';
import '../../../drawer/bloc/country_cubit.dart';

Future<dynamic> showAlertCountryBasketWidget(
    BuildContext context, Function()? callBack, bool shop) async {
  int? country;
  String? countryCode;

  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) =>
        StatefulBuilder(builder: (context, setState) {
      return CustomCupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text(
              'Выберите страну для СДЕК',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            onPressed: () {},
          ),
          CupertinoActionSheetAction(
            child: BlocConsumer<CountryCubit, CountryState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return Container(
                    constraints: BoxConstraints(
                        maxHeight: (MediaQuery.of(context).size.height) * 0.85),
                    height: state.country.length * 50,
                    child: ListView.builder(
                        itemCount: state.country.length,
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                country = index;
                                countryCode = state.country[index].code;
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    country == index
                                        ? Icons.check_circle
                                        : Icons.check_box_outline_blank,
                                    color: AppColors.kPrimaryColor,
                                    size: 24.0,
                                  ),
                                  const SizedBox(width: 6),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      "${state.country[index].name ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                      maxLines: 1,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 270,
                                  //   child: ListView.builder(

                                  //     itemCount: 3,
                                  //     itemBuilder: (context, state) {
                                  //       return
                                  //     },
                                  //   ),
                                  // ),
                                  //   GestureDetector(
                                  //     onTap: () {
                                  //       Navigator.pop(context);

                                  //       // showAlertEditDestroyWidget(
                                  //       //         context,
                                  //       //         state.addressModel[index].id!,
                                  //       //         state.addressModel[index].country,
                                  //       //         state.addressModel[index].city,
                                  //       //         state.addressModel[index].street,
                                  //       //         state.addressModel[index].home,
                                  //       //         state.addressModel[index].floor,
                                  //       //         state.addressModel[index].porch,
                                  //       //         state.addressModel[index].room)
                                  //       //     .whenComplete(() {
                                  //       //   callBack?.call();
                                  //       // });
                                  //     },
                                  //     child: const Icon(
                                  //       Icons.more_horiz,
                                  //       color: AppColors.kPrimaryColor,
                                  //       size: 24.0,
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ),
                          );
                        }),
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
                } else {
                  return const CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  );
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
          onTap: () {
            Get.back();
            // GetStorage().write('country', 'Казахстан');
            // GetStorage().write('user_country_id', countryId.toString());

            Future.wait([
              BlocProvider.of<cityCubit.CityCubit>(context)
                  .citiesCdek(countryCode ?? 'KZ')
            ]);

            showAlertCityBasketWidget(context, shop);
          },
          child: CupertinoActionSheetAction(
            child: const Text(
              'Выбрать',
              style: TextStyle(
                  color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
            ),
            onPressed: () {},
          ),
        ),
      );
    }),
  );
}
