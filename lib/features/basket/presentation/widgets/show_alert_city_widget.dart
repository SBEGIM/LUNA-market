import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/app/widgets/custom_cupertino_action_sheet.dart';
import 'package:haji_market/features/drawer/data/bloc/city_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/city_state.dart';
import '../../../../core/common/constants.dart';

Future<dynamic> showAlertCityWidget(BuildContext context) async {
  int? city;

  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => StatefulBuilder(builder: (context, setState) {
      return CustomCupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text(
              'Выберите город для СДЕК',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            onPressed: () {},
          ),
          CupertinoActionSheetAction(
            child: BlocConsumer<CityCubit, CityState>(
              listener: (context, state) {
                print(state);
                if (state is LoadedState) {
                  setState(() {});
                }
              },
              builder: (context, state) {
                if (state is LoadedState) {
                  return Container(
                    constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height) * 0.85),
                    height: state.city.length * 50,
                    child: ListView.builder(
                        itemCount: state.city.length,
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                city = index;
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    city == index ? Icons.check_circle : Icons.check_box_outline_blank,
                                    color: AppColors.kPrimaryColor,
                                    size: 24.0,
                                  ),
                                  const SizedBox(width: 6),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      "${state.city[index].name ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
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
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Выбрать',
            style: TextStyle(color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            // city != null ? GetStorage().write('country', country) : null;
            // Get.back();
            Get.back();
            // Get.to(() => new BasketOrderAddressPage());
            // callBack?.call();
          },
        ),
      );
    }),
  );
}
