import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerCatsOptions(
  BuildContext context,
  String title,
  List<CatsModel> categories,
  bool? searchWidget,
  Function callback,
) {
  List<CatsModel> _filteredCategories = [...categories];

  int selectedCategory = -1;

  int selectIndex = -1;
  TextEditingController searchController = TextEditingController();

  showMaterialModalBottomSheet(
    context: context,

    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Color(0xffF7F7F7),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 350.0,
              maxHeight: (_filteredCategories.length * 90).clamp(350.0, 500.0).toDouble(),
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
                      Text(title, style: AppTextStyles.size16Weight500),
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

                searchWidget == true
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAECED),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.icons.defaultSearchIcon.path,
                              height: 18,
                              width: 18,
                              scale: 1.9,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  setState(() {
                                    _filteredCategories = categories.where((cat) {
                                      return (cat.name ?? '').toLowerCase().contains(
                                        value.toLowerCase(),
                                      );
                                    }).toList();
                                  });
                                },
                                style: AppTextStyles.size16Weight400,
                                decoration: InputDecoration(
                                  hintText: 'Поиск',
                                  hintStyle: AppTextStyles.size16Weight400.copyWith(
                                    color: Color(0xFF8E8E93),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),

                const SizedBox(height: 12),

                // Список категорий
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                            if (index == selectIndex) {
                              selectIndex = -1;
                              selectedCategory = -1;
                              return;
                            }
                            selectedCategory = category.id!;
                            selectIndex = index;
                          }),
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: null,
                              // borderRadius: BorderRadius.circular(8),
                              border: const Border(
                                bottom: BorderSide(color: Color(0xffEAECED), width: 1),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  category.name!,
                                  style: AppTextStyles.size16Weight400.copyWith(
                                    color: isSelected ? AppColors.mainPurpleColor : Colors.black,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                                if (isSelected)
                                  Image.asset(
                                    Assets.icons.selectIcon.path,
                                    color: AppColors.mainPurpleColor,
                                    scale: 1.9,
                                  ),
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
                        callback.call(categories[selectIndex]);
                        Navigator.pop(context, selectedCategory);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        "Выбрать",
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
