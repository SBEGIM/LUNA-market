import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showCitiesOptions(
  BuildContext context,
  String title,
  List<CityModel> categories,
  Function(CityModel) callback,
) {
  List<CityModel> _filteredCategories = [...categories];

  int selectedCode = -1;
  int selectedIndex = -1;
  final TextEditingController searchController = TextEditingController();

  showMaterialModalBottomSheet(
    context: context,
    expand: false, // <- не растягиваем на весь экран
    backgroundColor: AppColors.kGray1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return SafeArea(
            top: false,
            child: Padding(
              // Поднимаем контент над клавиатурой
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: FractionallySizedBox(
                heightFactor:
                    0.9, // <- стабильная высота (не зависит от кол-ва элементов)
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Хедер
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          InkWell(
                              onTap: () => Navigator.of(ctx).pop(),
                              child: const Icon(Icons.close)),
                        ],
                      ),
                    ),

                    // Поиск
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
                              autofocus: true,
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                setState(() {
                                  _filteredCategories = categories
                                      .where((c) => (c.city ?? '')
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                  // Сброс выбора, если отфильтрованный список изменился
                                  selectedIndex = -1;
                                  selectedCode = -1;
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

                    // Список (всегда скролл внутри фиксированной высоты)
                    Expanded(
                      child: _filteredCategories.isEmpty
                          ? const Center(
                              child: Text(
                                'Ничего не найдено',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              // c ModalScrollController скролл взаимодействует с листом правильно
                              controller: ModalScrollController.of(ctx),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _filteredCategories.length,
                              itemBuilder: (context, index) {
                                final category = _filteredCategories[index];
                                final isSelected =
                                    category.code == selectedCode;

                                return GestureDetector(
                                  onTap: () => setState(() {
                                    selectedCode = category.code ?? 0;
                                    // сохраняем индекс относительно фильтрованного массива
                                    selectedIndex = index;
                                  }),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: isSelected
                                          ? Border.all(
                                              color: AppColors.mainPurpleColor,
                                              width: 1.5,
                                            )
                                          : null,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          category.city ?? '',
                                          style: TextStyle(
                                            color: isSelected
                                                ? AppColors.mainPurpleColor
                                                : Colors.black,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),
                                        if (isSelected)
                                          const Icon(Icons.check,
                                              color: AppColors.mainPurpleColor,
                                              size: 18),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    const SizedBox(height: 12),

                    // Кнопка
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: (selectedIndex >= 0 &&
                                  selectedIndex < _filteredCategories.length)
                              ? () {
                                  callback
                                      .call(_filteredCategories[selectedIndex]);
                                  Navigator.pop(ctx);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainPurpleColor,
                            disabledBackgroundColor:
                                AppColors.mainPurpleColor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
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
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
