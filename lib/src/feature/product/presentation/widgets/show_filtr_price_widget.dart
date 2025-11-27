import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showFiltrPriceOptions(BuildContext context, String title, Function callback) {
  final filters = context.read<FilterProvider>();

  RangeValues values = RangeValues(
    (filters.minPrice ?? 1).toDouble(),
    (filters.maxPrice ?? 100000).toDouble(),
  );

  final minPrice = filters.minPrice;
  final maxPrice = filters.maxPrice;

  final bool hasMin = minPrice != null;
  final bool hasMax = maxPrice != null;
  final bool hasFilter = hasMin || hasMax;

  String? priceLabel;

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
              maxHeight: (250).toDouble().clamp(200, 250),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(Assets.icons.defaultCloseIcon.path),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 52,
                        width: MediaQuery.of(context).size.width * 0.42,
                        decoration: BoxDecoration(
                          color: Color(0xffEAECED),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'от ${values.start.toInt()}',
                          style: AppTextStyles.size16Weight400,
                        ),
                      ),
                      Container(
                        height: 52,
                        width: MediaQuery.of(context).size.width * 0.42,
                        decoration: BoxDecoration(
                          color: Color(0xffEAECED),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'до ${values.end.toInt()}',
                          style: AppTextStyles.size16Weight400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RangeSlider(
                    divisions: 60,
                    activeColor: AppColors.mainPurpleColor,
                    inactiveColor: Color(0xffEAECED),
                    min: 1,
                    max: 100000,
                    values: values,
                    onChanged: (value) {
                      setState(() {
                        values = value;
                        final filters = context.read<FilterProvider>();
                        filters.setPriceRange(value);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        values;
                        if (values.start != 1) {
                          final buffer = StringBuffer();
                          if (hasMin) buffer.write('${(values.start).toInt()} ₸');
                          if (hasMax) {
                            if (hasMin) buffer.write(' - ');
                            buffer.write('${(values.end).toInt()} ₸');
                          }
                          priceLabel = buffer.toString();
                        } else {
                          priceLabel = null;
                        }
                        callback.call(priceLabel);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        "Применить",
                        style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
