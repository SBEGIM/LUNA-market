import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerCatsOptions(
  BuildContext context,
  String title,
  List<CatsModel> categories,
  Function callback,
) {
  List<CatsModel> filteredCategories = [...categories];
  int selectedCategory = -1;
  int selectIndex = -1;
  TextEditingController searchController = TextEditingController();

  showMaterialModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: AppColors.kGray1,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 350.0,
              maxHeight: (filteredCategories.length * 90).clamp(350.0, 500.0).toDouble(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок и крестик
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                // Поисковое поле
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEEEF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              filteredCategories = categories.where((cat) {
                                return (cat.name ?? '').toLowerCase().contains(value.toLowerCase());
                              }).toList();
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Поиск',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Список категорий
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category.id == selectedCategory;
                      final isMatch = category.name!.toLowerCase().contains(
                        searchController.text.toLowerCase(),
                      );

                      if (!isMatch) return const SizedBox.shrink();

                      return GestureDetector(
                        onTap: () => setState(() {
                          selectedCategory = category.id!;
                          selectIndex = index;
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected
                                ? Border.all(color: AppColors.mainPurpleColor, width: 1.5)
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.name!,
                                style: TextStyle(
                                  color: isSelected ? AppColors.mainPurpleColor : Colors.black,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check, color: AppColors.mainPurpleColor, size: 18),
                            ],
                          ),
                        ),
                      );
                    },
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
                        callback.call(categories[selectIndex]);
                        Navigator.pop(context, selectedCategory);
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
