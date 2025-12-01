import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/size_count_seller_dto.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerSizeCountOptions(
  BuildContext context,
  String title,
  List<SizeCountSellerDto>? subCharacteristics,
  Function(List<SizeCountSellerDto>) callback,
) {
  List<SizeCountSellerDto> filteredCategories = [...subCharacteristics!];
  List<SizeCountSellerDto> selectedCategory = [];

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
                        var category = filteredCategories[index];

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    color: category.count != '0'
                                        ? AppColors.mainPurpleColor
                                        : Colors.black,
                                    fontWeight: category.count != '0'
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                width: 111,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.kGray1,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          final myInt = int.parse(category.count);

                                          if (myInt <= 0) {
                                            return;
                                          }
                                          final updatedCategory = category.copyWith(
                                            count: (myInt - 1).toString(),
                                          );
                                          filteredCategories[index] = updatedCategory;

                                          if (int.parse(updatedCategory.count) <= 0) {
                                            selectedCategory.removeWhere(
                                              (element) => element.id == updatedCategory.id,
                                            );
                                            return;
                                          }

                                          int indexModel = -1;

                                          indexModel = selectedCategory.indexWhere(
                                            (e) => e.id == updatedCategory.id,
                                          );
                                          if (indexModel != -1) {
                                            // Элемент найден — обновляем
                                            selectedCategory[indexModel] = updatedCategory;
                                          } else {
                                            // Элемента нет — добавляем
                                            selectedCategory.add(updatedCategory);
                                          }
                                        });
                                      },
                                      child: Icon(Icons.remove, color: AppColors.mainPurpleColor),
                                    ),
                                    Text(category.count, style: AppTextStyles.aboutTextStyle),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          final myInt = int.parse(category.count);
                                          final updatedCategory = category.copyWith(
                                            count: (myInt + 1).toString(),
                                          );
                                          filteredCategories[index] = updatedCategory;

                                          int indexModel = -1;

                                          indexModel = selectedCategory.indexWhere(
                                            (e) => e.id == updatedCategory.id,
                                          );
                                          if (indexModel != -1) {
                                            // Элемент найден — обновляем
                                            selectedCategory[indexModel] = updatedCategory;
                                          } else {
                                            // Элемента нет — добавляем
                                            selectedCategory.add(updatedCategory);
                                          }
                                        });
                                      },
                                      child: Icon(Icons.add, color: AppColors.mainPurpleColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                        callback.call(selectedCategory);
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
