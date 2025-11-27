import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/home/bloc/popular_shops_cubit.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBlogerCatsOptions(
  BuildContext context,
  PopularShopsCubit cubit,
  List<CatsModel> categories,
  Function callback,
) {
  List<CatsModel> _filteredCategories = [...categories];

  int selectedCategory = -1;
  TextEditingController searchController = TextEditingController();

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
            constraints: const BoxConstraints(maxHeight: 500),
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
                      const Text('Категория и тип', style: AppTextStyles.size16Weight500),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Image.asset(
                          Assets.icons.defaultCloseIcon.path,
                          height: 24,
                          width: 24,
                        ),
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
                      Image.asset(Assets.icons.defaultSearchIcon.path, height: 18, width: 18),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              _filteredCategories = categories.where((cat) {
                                return (cat.name ?? '').toLowerCase().contains(value.toLowerCase());
                              }).toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Поиск',
                            hintStyle: AppTextStyles.size16Weight400.copyWith(
                              color: AppColors.kGray300,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Список категорий
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.separated(
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

                        return InkWell(
                          onTap: () => setState(() {
                            selectedCategory = category.id!;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 17),
                            // margin: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  category.name!,
                                  style: AppTextStyles.size16Weight500.copyWith(
                                    color: isSelected ? AppColors.mainPurpleColor : Colors.black,
                                  ),
                                ),
                                if (isSelected)
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      Assets.icons.selectIcon.path,
                                      color: AppColors.mainPurpleColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                // const Icon(Icons.check,
                                //     color: AppColors.mainPurpleColor, size: 18),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: 1, thickness: 0.33, color: Color(0xffEAECED));
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
