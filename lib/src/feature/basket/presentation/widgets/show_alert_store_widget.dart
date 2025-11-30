import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/drawer/bloc/address_cubit.dart';
import '../../../../core/common/constants.dart';
import '../ui/basket_order_address_page.dart';

Future<dynamic> showAlertStoreWidget(BuildContext context) async {
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController porchController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        return Material(
          type: MaterialType.transparency,
          color: Colors.white,
          elevation: 0,
          child: Container(
            constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height) * 0.85),
            height: (MediaQuery.of(context).size.height) - 200,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            alignment: Alignment.topCenter,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActionSheet(
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '  Добавить',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, 'Cancel');
                            },
                            child: const Icon(Icons.close, color: Colors.grey),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // showAlertAddWidget(context, product);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/country.svg', height: 24, width: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                GetStorage().write('country', value);
                              },
                              controller: countryController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Страна',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // showAlertAddWidget(context, product);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/location.svg', height: 24, width: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                GetStorage().write('city', value);
                              },
                              controller: cityController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Город',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // showAlertAddWidget(context, product);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/street.svg', height: 24, width: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: streetController,
                              onChanged: (value) {
                                GetStorage().write('street', value);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Улица',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // showAlertAddWidget(context, product);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/Route.svg', height: 24, width: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: homeController,
                              onChanged: (value) {
                                GetStorage().write('home', value);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Дом',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // showAlertAddWidget(context, product);
                      },
                    ),
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/Door-open.svg'),
                                  const SizedBox(width: 21),
                                  Expanded(
                                    child: TextFormField(
                                      controller: porchController,
                                      onChanged: (value) {
                                        GetStorage().write('porch', value);
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Подъезд',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          // borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/Stairs.svg'),
                                  const SizedBox(width: 21),
                                  Expanded(
                                    child: TextFormField(
                                      controller: floorController,
                                      onChanged: (value) {
                                        GetStorage().write('floor', value);
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Этаж',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          // borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //  const Text('3 этаж'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CupertinoActionSheetAction(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/Key.svg', height: 24, width: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: roomController,
                              onChanged: (value) {
                                GetStorage().write('room', value);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Квартира',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // showAlertAddWidget(context, product);
                      },
                    ),
                  ],
                  // cancelButton: null,
                ),
                GestureDetector(
                  onTap: () async {
                    await BlocProvider.of<AddressCubit>(context).store(
                      context,
                      countryController.text,
                      cityController.text,
                      streetController.text,
                      homeController.text,
                      floorController.text,
                      porchController.text,
                      roomController.text,
                      '',
                      '',
                    );

                    Get.back();
                    Get.back();
                    Get.to(() => new BasketOrderAddressPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                //   cancelButton: CupertinoActionSheetAction(
                //     child: GestureDetector(
                //       onTap: () {
                //         print('qwewqewq');
                //         // await BlocProvider.of<AddressCubit>(context).store(AddressModel(
                //         //     country: countryController.text,
                //         //     city: cityController.text,
                //         //     home: homeController.text,
                //         //     floor: floorController.text,
                //         //     room: roomController.text,
                //         //     porch: porchController.text));

                //         // Navigator.pop(context, 'Cancel');
                //         //  Get.to(() => BasketOrderAddressPage());
                //       },
                //       child: const Text(
                //         'Сохранить',
                //         style: TextStyle(
                //             color: AppColors.kPrimaryColor,
                //             fontWeight: FontWeight.w600),
                //       ),
                //     ),
                //     onPressed: () async {},
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
