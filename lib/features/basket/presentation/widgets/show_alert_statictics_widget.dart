import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';
import 'package:haji_market/features/basket/presentation/widgets/show_alert_edit_widget.dart';
import 'package:haji_market/features/basket/presentation/widgets/show_alert_statictics_widget%20copy.dart';
import 'package:haji_market/features/basket/presentation/widgets/show_alert_store_widget.dart';
import 'package:haji_market/features/drawer/data/bloc/address_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/address_state.dart';
import '../../../../core/common/constants.dart';
import '../ui/basket_order_address_page.dart';

Future<dynamic> showAlertAddressWidget(BuildContext context) async {
  String? country;
  String? city;
  String? street;
  String? home;
  String? porch;
  String? floor;
  String? room;

  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => StatefulBuilder(builder: (context, setState) {
      return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text(
              'Выберите адрес доставки',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            onPressed: () {},
          ),
          CupertinoActionSheetAction(
            child: BlocConsumer<AddressCubit, AddressState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return Container(
                    constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height) * 0.85),
                    height: state.addressModel.length * 50,
                    child: ListView.builder(
                        itemCount: state.addressModel.length,
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                GetStorage().write('basket_address_box', index);

                                country = state.addressModel[index].country;
                                city = state.addressModel[index].city;
                                street = state.addressModel[index].street;
                                home = state.addressModel[index].home;
                                porch = state.addressModel[index].porch;
                                floor = state.addressModel[index].floor;
                                room = state.addressModel[index].room;

                                // Navigator.pop(context);
                                // showAlertAddressWidget(context);

                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    GetStorage().read('basket_address_box') == index
                                        ? Icons.check_circle
                                        : Icons.check_box_outline_blank,
                                    color: AppColors.kPrimaryColor,
                                    size: 24.0,
                                  ),
                                  const SizedBox(width: 6),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      "${(state.addressModel[index].country ?? '*') + ', г. ' + (state.addressModel[index].city ?? '*') + ', ул. ' + (state.addressModel[index].street ?? '*') + ', дом ' + (state.addressModel[index].home ?? '*') + ',подъезд ' + (state.addressModel[index].porch ?? '*') + ',этаж ' + (state.addressModel[index].floor ?? '*') + ',кв ' + (state.addressModel[index].room ?? '*')}",
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);

                                      showAlertEditDestroyWidget(
                                          context,
                                          state.addressModel[index].id!,
                                          state.addressModel[index].country,
                                          state.addressModel[index].city,
                                          state.addressModel[index].street,
                                          state.addressModel[index].home,
                                          state.addressModel[index].floor,
                                          state.addressModel[index].porch,
                                          state.addressModel[index].room);
                                    },
                                    child: const Icon(
                                      Icons.more_horiz,
                                      color: AppColors.kPrimaryColor,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else if (state is NoDataState) {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset('assets/icons/no_data.png'),
                        const Text(
                          'У вас нет адресов для доставки',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'Добавьте адреса для доставки товаров',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff717171)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  );
                }
              },
            ),
            onPressed: () {},
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Добавить новый адрес',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
            ),
            onPressed: () {
              // showAlertAddWidget(context, product);
              Navigator.pop(context);
              showAlertStoreWidget(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Выбрать',
            style: TextStyle(color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            country != null ? GetStorage().write('country', country) : null;
            city != null ? GetStorage().write('city', city) : null;
            street != null ? GetStorage().write('street', street) : null;
            home != null ? GetStorage().write('home', home) : null;
            porch != null ? GetStorage().write('porch', porch) : null;
            floor != null ? GetStorage().write('floor', floor) : null;
            room != null ? GetStorage().write('home', room) : null;

            Get.back();
            Get.back();
            Get.to(() => new BasketOrderAddressPage());
          },
        ),
      );
    }),
  );
}
