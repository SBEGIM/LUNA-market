import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerCharacteristicsOptions(
  BuildContext context,
  String title,
  List<CatsModel>? subCharacteristics,
  Function(List<CatsModel>) callback,
) {
  List<CatsModel> filteredCategories = [...subCharacteristics!];
  List<int> selectedCategoryIds = [];

  showMaterialModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 200,
              maxHeight: (filteredCategories.length * 85 + 100).toDouble().clamp(250, 500),
            ),
            child: Column(
              children: [
                // Заголовок
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                // Список опций
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredCategories.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, thickness: 0.5),
                      itemBuilder: (context, index) {
                        final category = filteredCategories[index];
                        final isSelected =
                            selectedCategoryIds.contains(category.id) || category.isSelect;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              filteredCategories[index] = category.copyWith(
                                isSelect: !category.isSelect,
                              );

                              if (selectedCategoryIds.contains(filteredCategories[index].id) ||
                                  filteredCategories[index].isSelect) {
                                selectedCategoryIds.remove(filteredCategories[index].id);
                              } else {
                                selectedCategoryIds.add(filteredCategories[index].id!);
                              }

                              if (isSelected || filteredCategories[index].isSelect) {
                                selectedCategoryIds.remove(category.id);
                              } else {
                                selectedCategoryIds.add(category.id!);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    category.name!,
                                    style: TextStyle(
                                      color: isSelected ? AppColors.mainPurpleColor : Colors.black,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check, color: AppColors.mainPurpleColor),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Кнопка "Выбрать"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        var selectedItems = subCharacteristics
                            .where((e) => selectedCategoryIds.contains(e.id))
                            .toList();

                        for (var e in filteredCategories) {
                          if (e.isSelect) {
                            selectedItems.add(CatsModel(id: e.id, name: e.name));
                          }
                        }

                        callback.call(selectedItems);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "Выбрать",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
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
