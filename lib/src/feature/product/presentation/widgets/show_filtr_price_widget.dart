import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showFiltrPriceOptions(
    BuildContext context, String title, Function callback) {
  RangeValues values = const RangeValues(1, 100000);

  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: AppColors.kGray1,
    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 200,
              maxHeight: (300).toDouble().clamp(200, 300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.kGray200,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'от ${values.start.toInt()}',
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.kGray200,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'до ${values.end.toInt()}',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      child: RangeSlider(
                          divisions: 60,
                          activeColor: AppColors.mainPurpleColor,
                          inactiveColor: AppColors.kGray300,
                          min: 1,
                          max: 100000,
                          values: values,
                          onChanged: (value) {
                            setState(() {
                              values = value;
                              GetStorage().write('priceFilter', value);
                            });
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainPurpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Выбрать",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        },
      );
    },
  );
}
