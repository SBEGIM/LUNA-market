import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/edit_product_page%20copy.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/show_alert_add_widget.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';

import '../../../../core/common/constants.dart';

Future<dynamic> showAlertEditWidget(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => Container(
      child: Material(
        type: MaterialType.transparency,
        color: Colors.white,
        elevation: 0,
        child: CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '  Редактировать',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    maxLines: 1,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ))
                ],
              ),
              onPressed: () {
                // showAlertAddWidget(context, product);
              },
            ),
            CupertinoActionSheetAction(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location.svg',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Тараз',
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
                  SvgPicture.asset(
                    'assets/icons/street.svg',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: null,
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
                  SvgPicture.asset(
                    'assets/icons/Route.svg',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: null,
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
                            const SizedBox(
                              width: 21,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: null,
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
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/Stairs.svg'),
                            const SizedBox(
                              width: 21,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: null,
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
                        )),
                  ),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/Key.svg',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: null,
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
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Сохранить',
              style: TextStyle(
                  color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          ),
        ),
      ),
    ),
  );
}
