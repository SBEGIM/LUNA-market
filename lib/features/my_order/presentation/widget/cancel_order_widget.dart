import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';

class CancelOrderWidget extends StatefulWidget {
  CancelOrderWidget({Key? key}) : super(key: key);

  @override
  State<CancelOrderWidget> createState() => _CancelOrderWidgetState();
}

class _CancelOrderWidgetState extends State<CancelOrderWidget> {
  int selectIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                height: 9.5,
                width: 16.5,
                child: SvgPicture.asset('assets/icons/back_header.svg',
                    height: 9.5, width: 16.5),
              )),
          //   iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Выберите причину',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectIndex = 1;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: const Text(
                          'Не устрайвает сроки',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 1
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex = 2;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: const Text(
                          'Товара нет в наличи',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 2
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex = 3;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: const Text(
                          'Продовец попросил отменить',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 3
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex = 4;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: const Text(
                          'Другое',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 4
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Отменить заказ',
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
