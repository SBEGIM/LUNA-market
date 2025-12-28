import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showOrderCancel(
  BuildContext context,
  String title,
  List<String> options,
  Function(String) callback,
) {
  int selectedIndex = -1;

  showMaterialModalBottomSheet(
    context: context,
    expand: false,
    backgroundColor: AppColors.kBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Заголовок (аналог appBar из CancelOrderWidget)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          style: AppTextStyles.appBarTextStyle,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: Image.asset(Assets.icons.defaultCloseIcon.path, scale: 1.9),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 8),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 450),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: ModalScrollController.of(ctx),
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final text = options[index];
                        final isSelected = selectedIndex == index;

                        // как в CancelOrderWidget: для длинных — 68, остальных — 48
                        final double itemHeight = (index == 4 || index == 5 || text.contains('\n'))
                            ? 68
                            : 48;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedIndex == index) {
                                selectedIndex = -1;
                              } else {
                                selectedIndex = index;
                              }
                            });
                          },
                          child: Container(
                            height: itemHeight,
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    text,
                                    maxLines: 2,
                                    style: AppTextStyles.size16Weight600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    isSelected
                                        ? Assets.icons.defaultCheckIcon.path
                                        : Assets.icons.defaultUncheckIcon.path,
                                    scale: 2.1,
                                    color: isSelected ? AppColors.kLightBlackColor : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Кнопка как в CancelOrderWidget (Отменить заказ)
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: selectedIndex == -1
                          ? null
                          : () {
                              callback.call(options[selectedIndex]);
                              Navigator.pop(ctx);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        disabledBackgroundColor: AppColors.mainPurpleColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Отменить заказ',
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
