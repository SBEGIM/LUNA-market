import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<bool?> showModuleOrderSeller(
  BuildContext context,
  String appText,
  String title,
  String description,
  String? buttonText,
) {
  return showMaterialModalBottomSheet(
    context: context,
    expand: false,
    backgroundColor: AppColors.kGray1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return SizedBox(
            height: 488,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                  child: Center(
                    child: Text(
                      appText,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: title.length <= 25 ? 124 : 148,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: Image.asset(Assets.icons.successChangeStatusIcon.path),
                      ),
                      SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          title,
                          style: AppTextStyles.size18Weight700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Что делать дальше:', style: AppTextStyles.size18Weight700),
                        SizedBox(height: 16),
                        Text(
                          description,
                          style: AppTextStyles.size16Weight400.copyWith(color: Color(0xff636366)),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Container(
                    height: 52,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.mainPurpleColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      buttonText ?? 'Понятно',
                      style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
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
