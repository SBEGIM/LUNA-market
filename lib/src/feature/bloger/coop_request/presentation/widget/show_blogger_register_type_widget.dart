import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBloggerRegisterType(BuildContext context, int? prevType,
    {required Function typeCall}) {
  int type = prevType ?? 1;

  showMaterialModalBottomSheet(
    backgroundColor: AppColors.kWhite,
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ваш юридический статус',
                        style: AppTextStyles.size16Weight600,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            Assets.icons.defaultCloseIcon.path,
                            height: 24,
                            width: 24,
                          ))
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: AppColors.kGray1,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 47,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ИП',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.size16Weight600
                                    .copyWith(color: Color(0xFF3A3A3C)),
                              ),
                              InkWell(
                                onTap: () {
                                  type = type == 1 ? 0 : 1;
                                  setState(() {});
                                },
                                child: Image.asset(
                                  type == 1
                                      ? Assets.icons.defaultCheckIcon.path
                                      : Assets.icons.defaultUncheckIcon.path,
                                  color: type == 1
                                      ? AppColors.kLightBlackColor
                                      : AppColors.kGray300,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              // Theme(
                              //   data: Theme.of(context).copyWith(
                              //     checkboxTheme: CheckboxThemeData(
                              //       shape: CircleBorder(),
                              //       side: BorderSide(
                              //         color: AppColors.kGray300,
                              //         width: 1, // Толщина обводки чекбокса
                              //       ),
                              //       fillColor: WidgetStateProperty.all(
                              //           type == 1
                              //               ? AppColors.kLightBlackColor
                              //               : AppColors.kWhite),
                              //       checkColor: WidgetStateProperty.all(
                              //           AppColors.kWhite), // Цвет галочки
                              //     ),
                              //   ),
                              //   child: Checkbox(
                              //     value: type == 1,
                              //     onChanged: ((value) {
                              //       type = 1;
                              //       setState(() {});
                              //     }),
                              //   ),
                              // )
                            ]),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: AppColors.kGray1,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 47,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Самозанятый',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.size16Weight600
                                    .copyWith(color: Color(0xFF3A3A3C)),
                              ),
                              InkWell(
                                onTap: () {
                                  type = type == 2 ? 0 : 2;
                                  setState(() {});
                                },
                                child: Image.asset(
                                  type == 2
                                      ? Assets.icons.defaultCheckIcon.path
                                      : Assets.icons.defaultUncheckIcon.path,
                                  color: type == 2
                                      ? AppColors.kLightBlackColor
                                      : AppColors.kGray300,
                                  height: 20,
                                  width: 20,
                                ),
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
                        style: AppTextStyles.size18Weight600
                            .copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
