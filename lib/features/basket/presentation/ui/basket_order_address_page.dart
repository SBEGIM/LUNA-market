import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';

import '../../../../core/common/constants.dart';
import '../../../app/bloc/navigation_cubit/navigation_cubit.dart' as navCubit;
import '../../../app/presentaion/base.dart';
import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/basket_state.dart';
import '../../../profile/data/presentation/ui/edit_profile_page.dart';
import '../widgets/show_alert_statictics_widget.dart';
import 'basket_order_page.dart';
import 'map_picker.dart';

class BasketOrderAddressPage extends StatefulWidget {
  BasketOrderAddressPage({Key? key}) : super(key: key);

  @override
  _BasketOrderAddressPageState createState() => _BasketOrderAddressPageState();
}

class _BasketOrderAddressPageState extends State<BasketOrderAddressPage> {
  bool courier = false;
  bool point = false;
  bool shop = false;

  String? office;

  String address =
      "${(GetStorage().read('country') ?? '*') + ', г. ' + (GetStorage().read('city') ?? '*') + ', ул. ' + (GetStorage().read('street') ?? '*') + ', дом ' + (GetStorage().read('home') ?? '*') + ',подъезд ' + (GetStorage().read('porch') ?? '*') + ',этаж ' + (GetStorage().read('floor') ?? '*') + ',кв ' + (GetStorage().read('room') ?? '*')}";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
          ),
          title: const Text(
            'Способ доставки',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          )),
      body: BlocConsumer<BasketCubit, BasketState>(listener: (context, state) {
        if (state is OrderState) {
          BlocProvider.of<navCubit.NavigationCubit>(context)
              .getNavBarItem(const navCubit.NavigationState.home());
          Get.to(const Base(index: 1));
        }
      }, builder: (context, state) {
        if (state is ErrorState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 20.0, color: Colors.grey),
            ),
          );
        }

        if (state is LoadedState) {
          return Column(children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.center,
              color: Colors.white,
              height: 155,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    checkColor: Colors.white,
                    activeColor: AppColors.kPrimaryColor,
                    value: courier,
                    onChanged: (bool? value) {
                      setState(() {
                        courier = value!;
                        shop = false;
                        point = false;
                      });
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Доставка',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '1 июла , бесплатно',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              '$address',
                              // 'г. Алматы , Шевченко 90 (БЦ Каратал)',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              //  showAlertAddressWidget(context);

                              if (GetStorage().read('name') !=
                                  'Не авторизированный') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage(
                                            name: GetStorage().read('name'),
                                            phone: GetStorage().read('phone') ??
                                                '',
                                            gender:
                                                GetStorage().read('gender') ??
                                                    '',
                                            birthday:
                                                GetStorage().read('birthday') ??
                                                    '',
                                            country:
                                                GetStorage().read('country') ??
                                                    '',
                                            city:
                                                GetStorage().read('city') ?? '',
                                            street:
                                                GetStorage().read('street') ??
                                                    '',
                                            home:
                                                GetStorage().read('home') ?? '',
                                            porch: GetStorage().read('porch') ??
                                                '',
                                            floor: GetStorage().read('floor') ??
                                                '',
                                            room:
                                                GetStorage().read('room') ?? '',
                                            email: GetStorage().read('email') ??
                                                '',
                                          )),
                                );
                              }
                            },
                            child: const Text(
                              'Изменить адрес доставки',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kPrimaryColor),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ]),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.center,
              color: Colors.white,
              height: 155,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    checkColor: Colors.white,
                    activeColor: AppColors.kPrimaryColor,
                    value: point,
                    onChanged: (bool? value) {
                      setState(() {
                        point = value!;
                        shop = false;
                        courier = false;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Самовывоз',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '1 июла , бесплатно',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              office ?? 'Выберите пунк доставки',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              final data = await Get.to(() => const Mapp());
                              office = data;
                              setState(() {});
                            },
                            child: const Text(
                              'Изменить адрес самовывоза',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kPrimaryColor),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ]),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.center,
              color: Colors.white,
              height: 155,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    checkColor: Colors.white,
                    activeColor: AppColors.kPrimaryColor,
                    value: shop,
                    onChanged: (bool? value) {
                      setState(() {
                        courier = false;
                        point = false;
                        shop = value!;
                      });
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'От магазина',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '1 июла , бесплатно',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              '$address',
                              // 'г. Алматы , Шевченко 90 (БЦ Каратал)',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              //  showAlertAddressWidget(context);

                              if (GetStorage().read('name') !=
                                  'Не авторизированный') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage(
                                            name: GetStorage().read('name'),
                                            phone: GetStorage().read('phone') ??
                                                '',
                                            gender:
                                                GetStorage().read('gender') ??
                                                    '',
                                            birthday:
                                                GetStorage().read('birthday') ??
                                                    '',
                                            country:
                                                GetStorage().read('country') ??
                                                    '',
                                            city:
                                                GetStorage().read('city') ?? '',
                                            street:
                                                GetStorage().read('street') ??
                                                    '',
                                            home:
                                                GetStorage().read('home') ?? '',
                                            porch: GetStorage().read('porch') ??
                                                '',
                                            floor: GetStorage().read('floor') ??
                                                '',
                                            room:
                                                GetStorage().read('room') ?? '',
                                            email: GetStorage().read('email') ??
                                                '',
                                          )),
                                );
                              }
                            },
                            child: const Text(
                              'Изменить адрес доставки',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kPrimaryColor),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ]),
                  )
                ],
              ),
            ),
          ]);
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.indigoAccent));
        }
      }),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: InkWell(
          onTap: () {
            if (point == false && courier == false && shop == false) {
              Get.snackbar('Ошибка', 'Выберите способ доставки',
                  backgroundColor: Colors.redAccent);
              return;
            }

            if (point == true) {
              if (office == null) {
                Get.snackbar('Ошибка', 'Выберите адрес самовывоза',
                    backgroundColor: Colors.redAccent);
                return;
              }
            }

            if (courier == true) {
              if (address.isEmpty) {
                Get.snackbar('Ошибка', 'Напишите адрес для курьера',
                    backgroundColor: Colors.redAccent);
                return;
              }
            }

            if (shop == true) {
              if (address.isEmpty) {
                Get.snackbar('Ошибка', 'Напишите адрес для курьера',
                    backgroundColor: Colors.redAccent);
                return;
              }
            }

            Get.to(const BasketOrderPage());

            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Оформить заказ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
