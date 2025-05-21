import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_country_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/country_cubit.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/bank_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerServicePage extends StatefulWidget {
  @override
  State<SellerServicePage> createState() => _SellerServicePage();
}

class _SellerServicePage extends State<SellerServicePage> {
  final services = [
    {
      "name": "Пуш",
      "status": "Не подключен",
      "statusColor": Colors.red,
      "button": "Подключить",
      "buttonColor": Color(0xFFEDE6FF),
      "buttonTextColor": Colors.purple,
      "isLoading": false,
      "type": 'push'
    },
    {
      "name": "CDEK",
      "status": "В ожидании",
      "statusColor": Colors.orange,
      "button": "Подключить",
      "buttonColor": Colors.grey.shade200,
      "buttonTextColor": Colors.grey,
      "isLoading": true,
      "type": 'delivery'
    },
    {
      "name": "Т-Банк",
      "status": "Не подключен",
      "statusColor": Colors.orange,
      "button": "Подключить",
      "buttonColor": Colors.grey.shade200,
      "buttonTextColor": Colors.grey,
      "isLoading": false,
      "type": 'payment'
    },
    {
      "name": "Области продаж",
      "status": "Не доступен",
      "statusColor": Colors.red,
      "type": 'zone'
    },
  ];

  final _box = GetStorage();

  Function? disposeListen;
  Function? disposeListenDeviceToken;
  Function? disposeOrganizationTypeToken;

  bool exists = GetStorage().hasData('shop_location_code');
  String? city = GetStorage().read('city_shop');
  String? _deviceToken = GetStorage().read('device_token');
  String? _organizationType = GetStorage().read('seller_type_organization');

  @override
  void initState() {
    // TODO: implement initState

    if (_deviceToken != null) {
      services[0] = {
        "name": "Пуш",
        "status": "Подключен",
        "statusColor": Colors.greenAccent,
        "button": "Обновить",
        "buttonColor": Color.fromARGB(255, 242, 241, 246),
        "buttonTextColor": Colors.blueAccent,
        "isLoading": false,
        "type": 'push'
      };
    }

    if (_organizationType != null) {
      services[2] = {
        "name": "Т-Банк",
        "status": "Не подключен",
        "statusColor": Colors.orange,
        "button": "Обновить",
        "buttonColor": Color.fromARGB(255, 242, 241, 246),
        "buttonTextColor": Colors.blueAccent,
        "isLoading": false,
        "type": 'payment'
      };
    }

    if (!exists) {
      services[1] = {
        "name": "Cдэк доставка",
        "status": "Не подкючен",
        "statusColor": Colors.red,
        "button": "Подключить",
        "buttonColor": Colors.grey.shade200,
        "buttonTextColor": Colors.green,
        "isLoading": false,
        "type": 'delivery'
      };
    } else {
      services[1] = {
        "name": "Cдэк  (ваш город $city)",
        "status": "Подкючен",
        "statusColor": Colors.greenAccent,
        "button": "Обновить",
        "buttonColor": Color.fromARGB(255, 242, 241, 246),
        "buttonTextColor": Colors.blueAccent,
        "isLoading": false,
        "type": 'delivery'
      };
    }

    disposeListen = _box.listenKey('city_shop', (value) {
      if (mounted) {
        city = value;
        services[1]['name'] = "Cдэк  (ваш город $city)";
        setState(() {});
      }
    });

    disposeListenDeviceToken = _box.listenKey('device_token', (value) {
      if (mounted) {
        _deviceToken = value;
        services[0]['isLoading'] = false;
        services[0]['status'] = "Подключен";
        setState(() {});

        Get.snackbar('Успешно', 'Пуш обновлен',
            backgroundColor: Colors.blueAccent);
      }
    });

    disposeOrganizationTypeToken =
        _box.listenKey('seller_type_organization', (value) {
      if (mounted) {
        print(value);
        services[2]['isLoading'] = false;
        services[2]['status'] = "Подключен";
        setState(() {});

        Get.snackbar('Успешно', 'Бан обновлен на ООО',
            backgroundColor: Colors.blueAccent);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    disposeListen?.call();
    disposeListenDeviceToken?.call();
    super.dispose();
  }

  _cdeKService() {
    services[1]['isLoading'] = true;
    services[1]['status'] = "В процессе";
    setState(() {});
    Future.wait([BlocProvider.of<CountryCubit>(context).country()]);
    showAlertCountryWidget(context, () {}, true);
  }

  _pushService() async {
    final deviceToken = await FirebaseMessaging.instance.getToken();

    if (deviceToken != null) {
      await _box.write('device_token', deviceToken.toString());
    }
  }

  _bankService() async {
    services[2]['isLoading'] = true;
    services[2]['status'] = "В процессе";
    setState(() {});

    final data = Get.to(BankPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Список сервисов", style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          Flexible(
            child: ListView.separated(
              itemCount: services.length,
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(services[index]['name'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Статус", style: TextStyle(color: Colors.grey)),
                          Text(services[index]['status'].toString(),
                              style: TextStyle(
                                  color:
                                      services[index]['statusColor'] as Color,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      if (services[index].containsKey("button")) ...[
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: services[index]["isLoading"] == true
                              ? null
                              : () {
                                  if (services[index]["type"] == 'delivery') {
                                    _cdeKService();
                                  }

                                  if (services[index]["type"] == 'push') {
                                    services[0]['isLoading'] = true;
                                    services[0]['status'] = "В процессе";
                                    setState(() {});
                                    _pushService();
                                  }

                                  if (services[index]["type"] == 'payment') {
                                    _bankService();
                                  }
                                },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: services[index]["buttonColor"] as Color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: services[index]["isLoading"] == true
                                ? SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.grey),
                                  )
                                : Text(
                                    services[index]["button"].toString(),
                                    style: TextStyle(
                                        color: services[index]
                                            ["buttonTextColor"] as Color,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
