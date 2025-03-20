import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_country_basket_widget.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/address_cubit.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/country_cubit.dart'
    as countryCubit;
import '../../../../core/common/constants.dart';
import '../../../app/bloc/navigation_cubit/navigation_cubit.dart' as navCubit;
import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/basket_state.dart';
import '../widgets/show_alert_statictics_widget.dart';

@RoutePage()
class BasketOrderAddressPage extends StatefulWidget {
  final String fulfillment;
  final String? deleveryDay;
  final String? office;

  const BasketOrderAddressPage(
      {required this.fulfillment, this.deleveryDay, this.office, Key? key})
      : super(key: key);

  @override
  _BasketOrderAddressPageState createState() => _BasketOrderAddressPageState();
}

class _BasketOrderAddressPageState extends State<BasketOrderAddressPage> {
  bool courier = false;
  bool point = false;
  bool shop = false;
  bool fbs = false;
  String address = '';
  String? fulfillment = '';

  String? office;

  void getAddress() {
    address =
        "${(GetStorage().read('country') ?? '*') + ', г. ' + (GetStorage().read('city') ?? '*') + ', ул. ' + (GetStorage().read('street') ?? '*') + ', дом ' + (GetStorage().read('home') ?? '*') + ',подъезд ' + (GetStorage().read('porch') ?? '*') + ',этаж ' + (GetStorage().read('floor') ?? '*') + ',кв ' + (GetStorage().read('room') ?? '*')}";
  }

  @override
  void initState() {
    getAddress();
    fulfillment = widget.fulfillment;

    if (widget.office != null) {
      office = widget.office;
    }
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
          // Get.to(const Base(index: 1));
          context.router
              .popUntil((route) => route.settings.name == LauncherRoute.name);
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
              alignment: Alignment.center,
              color:
                  widget.fulfillment != 'fbs' ? Colors.red[200] : Colors.white,
              height: widget.fulfillment != 'fbs' ? 100 : 165,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (widget.fulfillment != 'fbs') {
                      Get.snackbar('Доставка', 'Не доступно для этого товара',
                          backgroundColor: Colors.orangeAccent);
                    } else {
                      setState(() {
                        courier = true;
                        shop = false;
                        point = false;
                        fbs = false;
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: widget.fulfillment != 'fbs' ? 32 : 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        widget.fulfillment != 'fbs'
                            ? Container(
                                padding:
                                    const EdgeInsets.only(top: 12, right: 10),
                                alignment: Alignment.topCenter,
                                child: const Icon(Icons.lock))
                            : Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                checkColor: Colors.white,
                                activeColor: AppColors.kPrimaryColor,
                                value: courier,
                                onChanged: (bool? value) {
                                  if (widget.fulfillment != 'fbs') {
                                    Get.snackbar('Доставка',
                                        'Не доступно для этого товара',
                                        backgroundColor: Colors.orangeAccent);
                                  } else {
                                    setState(() {
                                      courier = value!;
                                      shop = false;
                                      point = false;
                                      fbs = false;
                                    });
                                  }
                                },
                              ),
                        widget.fulfillment != 'fbs'
                            ? Container(
                                padding: const EdgeInsets.only(top: 12),
                                child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Курьерская доставка',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Пока что не доступно',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]),
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 12),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Курьерская доставка',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        widget.deleveryDay != null &&
                                                widget.deleveryDay != '0'
                                            ? 'Доставка: ${widget.deleveryDay} дня'
                                            : 'Доставка: Нет срока доставки СДЕК',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
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
                                        onTap: () async {
                                          Future.wait([
                                            BlocProvider.of<AddressCubit>(
                                                    context)
                                                .address()
                                          ]);
                                          showAlertAddressWidget(context, () {
                                            // context.router.pop();

                                            getAddress();
                                            setState(() {});
                                          });

                                          // if (GetStorage().read('name') !=
                                          //     'Не авторизированный') {
                                          //   Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => EditProfilePage(
                                          //               name: GetStorage().read('name'),
                                          //               phone: GetStorage().read('phone') ??
                                          //                   '',
                                          //               gender:
                                          //                   GetStorage().read('gender') ??
                                          //                       '',
                                          //               birthday:
                                          //                   GetStorage().read('birthday') ??
                                          //                       '',
                                          //               country:
                                          //                   GetStorage().read('country') ??
                                          //                       '',
                                          //               city:
                                          //                   GetStorage().read('city') ?? '',
                                          //               street:
                                          //                   GetStorage().read('street') ??
                                          //                       '',
                                          //               home:
                                          //                   GetStorage().read('home') ?? '',
                                          //               porch: GetStorage().read('porch') ??
                                          //                   '',
                                          //               floor: GetStorage().read('floor') ??
                                          //                   '',
                                          //               room:
                                          //                   GetStorage().read('room') ?? '',
                                          //               email: GetStorage().read('email') ??
                                          //                   '',
                                          //             )),
                                          //   );
                                          // }
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
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              alignment: Alignment.center,
              color:
                  widget.fulfillment != 'fbs' ? Colors.red[200] : Colors.white,
              height: widget.fulfillment != 'fbs' ? 100 : 155,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (widget.fulfillment != 'fbs') {
                      Get.snackbar('Доставка', 'Не доступно для этого товара',
                          backgroundColor: Colors.orangeAccent);
                    } else {
                      point = true;
                      shop = false;
                      courier = false;
                      fbs = false;
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: widget.fulfillment != 'fbs' ? 32 : 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        widget.fulfillment != 'fbs'
                            ? Container(
                                padding:
                                    const EdgeInsets.only(top: 12, right: 10),
                                alignment: Alignment.topCenter,
                                child: const Icon(Icons.lock))
                            : Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                checkColor: Colors.white,
                                activeColor: AppColors.kPrimaryColor,
                                value: point,
                                onChanged: (bool? value) {
                                  if (widget.fulfillment != 'fbs') {
                                    Get.snackbar('Доставка',
                                        'Не доступно для этого товара',
                                        backgroundColor: Colors.orangeAccent);
                                  } else {
                                    setState(() {
                                      point = value!;
                                      shop = false;
                                      courier = false;
                                      fbs = false;
                                    });
                                  }
                                },
                              ),
                        widget.fulfillment != 'fbs'
                            ? Container(
                                padding: const EdgeInsets.only(top: 12),
                                child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Самовывоз',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Пока что не доступно',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]),
                              )
                            : Container(
                                padding: EdgeInsets.only(top: 12),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Самовывоз',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        widget.deleveryDay != null &&
                                                widget.deleveryDay != '0'
                                            ? 'Доставка: ${widget.deleveryDay} дня'
                                            : 'Доставка: Нет срока доставки СДЕК',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
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
                                          //  final data = await Get.to(() => const Mapp());
                                          // final data = '';
                                          Future.wait([
                                            BlocProvider.of<
                                                    countryCubit
                                                    .CountryCubit>(context)
                                                .country()
                                          ]);
                                          showAlertCountryBasketWidget(context,
                                              () {
                                            // context.router.pop();
                                            // setState(() {});
                                          }, true);
                                          // office = data;
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
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            // Container(
            //   alignment: Alignment.center,
            //   //  color: widget.fulfillment != 'realFBS' ? Colors.red[200] : Colors.white,
            //   height: widget.fulfillment != 'realFBS' ? 100 : 0,

            //   color: Colors.white,

            //   child: Material(
            //     color: Colors.transparent,
            //     child: InkWell(
            //       onTap: () {
            //         if (widget.fulfillment != 'realFBS') {
            //           Get.snackbar('Доставка', 'Не доступно для этого товара', backgroundColor: Colors.orangeAccent);
            //         } else {
            //           courier = false;
            //           point = false;
            //           shop = true;
            //           fbs = true;
            //           setState(() {});
            //         }
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 16),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisSize: MainAxisSize.max,
            //           children: [
            //             widget.fulfillment != 'realFBS'
            //                 // ? Container(
            //                 //     padding: const EdgeInsets.only(top: 12, right: 10),
            //                 //     alignment: Alignment.topCenter,
            //                 //     child: const Icon(Icons.lock))
            //                 ? SizedBox()
            //                 : Container(
            //                     padding: const EdgeInsets.only(bottom: 128),
            //                     margin: EdgeInsets.zero,
            //                     child: Checkbox(
            //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //                       checkColor: Colors.white,
            //                       activeColor: AppColors.kPrimaryColor,
            //                       value: shop,
            //                       onChanged: (bool? value) {
            //                         if (widget.fulfillment != 'realFBS') {
            //                           Get.snackbar('Доставка', 'Не доступно для этого товара',
            //                               backgroundColor: Colors.orangeAccent);
            //                         } else {
            //                           courier = false;
            //                           point = false;
            //                           shop = true;
            //                           fbs = true;
            //                           setState(() {});
            //                         }
            //                       },
            //                     ),
            //                   ),
            //             widget.fulfillment != 'realFBS'
            //                 ? SizedBox()

            //                 //  Container(
            //                 //     padding: const EdgeInsets.only(
            //                 //       top: 12,
            //                 //     ),
            //                 //     child: Column(
            //                 //         mainAxisAlignment: MainAxisAlignment.start,
            //                 //         crossAxisAlignment: CrossAxisAlignment.start,
            //                 //         children: [
            //                 //           const Text(
            //                 //             'real FBS (доставка силами продавца)',
            //                 //             style: TextStyle(
            //                 //               fontSize: 16,
            //                 //               fontWeight: FontWeight.w500,
            //                 //             ),
            //                 //             maxLines: 1,
            //                 //           ),
            //                 //           widget.fulfillment != 'realFBS' ? const SizedBox(height: 12) : const SizedBox(),
            //                 //           SizedBox(
            //                 //             width: MediaQuery.of(context).size.width / 1.2,
            //                 //             child: const Text(
            //                 //               'Пока что не доступно',
            //                 //               // 'г. Алматы , Шевченко 90 (БЦ Каратал)',
            //                 //               style: TextStyle(
            //                 //                 fontSize: 14,
            //                 //                 fontWeight: FontWeight.w400,
            //                 //               ),
            //                 //             ),
            //                 //           ),
            //                 //         ]),
            //                 //   )
            //                 : Container(
            //                     padding: const EdgeInsets.only(top: 12),
            //                     child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           const Text(
            //                             'real FBS (доставка силами продавца)',
            //                             style: TextStyle(
            //                               fontSize: 16,
            //                               fontWeight: FontWeight.w500,
            //                             ),
            //                             maxLines: 1,
            //                           ),
            //                           const SizedBox(height: 8),
            //                           Text(
            //                             widget.deleveryDay != null && widget.deleveryDay != '0'
            //                                 ? widget.fulfillment == 'realFBS'
            //                                     ? 'Срок доставка:  не известна'
            //                                     : 'Срок доставка:  ${widget.deleveryDay} дня'
            //                                 : 'Срок доставка: Нет срока доставки СДЕК',
            //                             style: const TextStyle(
            //                               fontSize: 14,
            //                               fontFamily: 'SF Pro Text',
            //                               fontWeight: FontWeight.w400,
            //                             ),
            //                           ),
            //                           const SizedBox(height: 8),
            //                           SizedBox(
            //                             width: MediaQuery.of(context).size.width / 1.2,
            //                             child: Text(
            //                               '$address',
            //                               // 'г. Алматы , Шевченко 90 (БЦ Каратал)',
            //                               style: const TextStyle(
            //                                 fontSize: 14,
            //                                 fontWeight: FontWeight.w400,
            //                               ),
            //                             ),
            //                           ),
            //                           const SizedBox(height: 8),
            //                           GestureDetector(
            //                             onTap: () async {
            //                               //  showAlertAddressWidget(context);
            //                               Future.wait([BlocProvider.of<AddressCubit>(context).address()]);
            //                               showAlertAddressWidget(context, () {
            //                                 // context.router.pop();

            //                                 getAddress();
            //                                 setState(() {});
            //                               });
            //                             },
            //                             child: const Text(
            //                               'Изменить адрес доставки',
            //                               style: TextStyle(
            //                                   fontSize: 14,
            //                                   fontWeight: FontWeight.w400,
            //                                   color: AppColors.kPrimaryColor),
            //                             ),
            //                           ),
            //                           const SizedBox(height: 8),
            //                           GestureDetector(
            //                             onTap: () {
            //                               Get.to(() => MessagePage(
            //                                   userId: state.basketShowModel.first.product?.shopId,
            //                                   name: state.basketShowModel.first.shopName,
            //                                   avatar: state.basketShowModel.first.image?.first ?? '',
            //                                   chatId: state.basketShowModel.first.chatId ?? null));
            //                             },
            //                             child: const Text(
            //                               'Уточните срок и цену доставки',
            //                               style: TextStyle(
            //                                   fontSize: 14, fontWeight: FontWeight.w400, color: Colors.orangeAccent),
            //                             ),
            //                           ),
            //                           const SizedBox(height: 4),
            //                         ]),
            //                   )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const Divider(
            //   height: 0,
            //   color: AppColors.kGray400,
            // ),
            Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 32),
              // margin: EdgeInsets.symmetric(vertical: 32),
              alignment: Alignment.center,
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Тип доставки',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${widget.fulfillment}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ]),
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
            context.router.push(BasketOrderRoute(
                fbs: fbs,
                address: point ? office : address,
                fulfillment: widget.fulfillment));
            // Get.to(BasketOrderPage(
            //   fbs: fbs,
            // ));

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
