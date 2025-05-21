import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerRegisterType(BuildContext context, int? prevType,
    {required Function typeCall}) {
  int type = prevType ?? 1;

  showMaterialModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Тип магазина',
                        style: AppTextStyles.defaultButtonTextStyle,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close_rounded))
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 350,
                      height: 47,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ИП',
                              textAlign: TextAlign.center,
                            ),
                            Checkbox(
                              shape: const CircleBorder(),
                              value: type == 1,
                              activeColor: AppColors.mainPurpleColor,
                              onChanged: ((value) {
                                type = 1;
                                setState(() {});
                              }),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 350,
                      height: 47,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'OОО',
                              textAlign: TextAlign.center,
                            ),
                            Checkbox(
                              value: type == 2,
                              shape: const CircleBorder(),
                              activeColor: AppColors.mainPurpleColor,
                              onChanged: ((value) {
                                type = 2;
                                setState(() {});
                              }),
                            ),
                          ]),
                    ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   alignment: Alignment.centerLeft,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   width: 100,
                    //   height: 47,
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const Text(
                    //           'ОГРН',
                    //           textAlign: TextAlign.center,
                    //         ),
                    //         Checkbox(
                    //           shape: const CircleBorder(),
                    //           value: typeOrganization == 3,
                    //           activeColor: AppColors.kPrimaryColor,
                    //           onChanged: ((value) {
                    //             typeOrganization = 3;
                    //             setState(() {});
                    //           }),
                    //         ),
                    //       ]),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    typeCall.call(type);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 52,
                    width: 358,
                    decoration: BoxDecoration(
                        color: AppColors.mainPurpleColor,
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: Text(
                      'Выбрать',
                      style: AppTextStyles.defButtonTextStyle,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}
