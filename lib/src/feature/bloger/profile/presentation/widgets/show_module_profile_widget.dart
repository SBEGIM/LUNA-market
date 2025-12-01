import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showModuleProfile(
  BuildContext context,
  String title,
  List<String> options,
  Function(String) callback,
) {
  List<String> _filteredCategories = [...options];

  String selectedReport = '';
  int selectedIndex = -1;

  showMaterialModalBottomSheet(
    context: context,
    expand: false,
    backgroundColor: AppColors.kGray1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 360.0,
              maxHeight: 360.clamp(360.0, 490.0).toDouble(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.1,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: Image.asset(Assets.icons.defaultCloseIcon.path, scale: 1.9),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: _filteredCategories.length * 58,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.separated(
                    controller: ModalScrollController.of(ctx),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 0),
                    itemBuilder: (context, index) {
                      final category = _filteredCategories[index];
                      final isSelected = (category == selectedReport);
                      return InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => setState(() {
                          selectedReport = category;
                          selectedIndex = index;
                        }),
                        child: SizedBox(
                          height: 56,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        category,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          height: 1.2,
                                          color: isSelected
                                              ? AppColors.mainPurpleColor
                                              : Colors.black,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check,
                                        color: AppColors.mainPurpleColor,
                                        size: 18,
                                      ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Divider(thickness: 0.2, height: 0, color: AppColors.kGray200),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52, // ← было 48
                    child: ElevatedButton(
                      onPressed: (selectedIndex >= 0 && selectedIndex < _filteredCategories.length)
                          ? () async {
                              callback.call(_filteredCategories[selectedIndex]);
                              Navigator.pop(ctx);
                              // final ok = await showBrandedAlert(
                              //   context,
                              //   title: 'Внимание',
                              //   message:
                              //       'Отправленная жалоба будет рассмотрена модераторами. Вы уверены, что хотите продолжить?',
                              //   mode: BrandedAlertMode.confirm,
                              //   cancelText: 'Отмена',
                              //   primaryText: 'Пожаловаться',
                              // );
                              // if (ok == true) {
                              //   await showBrandedAlert(
                              //     context,
                              //     title: 'Спасибо за ваш отзыв',
                              //     message:
                              //         'Мы проверим это видео и примем меры, если потребуется',
                              //     mode: BrandedAlertMode.acknowledge,
                              //     primaryText: 'Закрыть',
                              //     // если нужен свой градиент:
                              //     // primaryGradient: const LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF8C52FF)]),
                              //   );
                              // }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        disabledBackgroundColor: AppColors.mainPurpleColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        selectedIndex >= 0 ? "Выбрать" : "Отмена",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.0,
                        ),
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
