import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
// import 'city_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showModuleCities(
  BuildContext context,
  String title,
  List<CityModel> options,
  Function(CityModel) callback,
) {
  final TextEditingController searchController = TextEditingController();

  // полный список и отфильтрованный
  List<CityModel> filtered = List<CityModel>.from(options);

  CityModel? selectedCity;

  showMaterialModalBottomSheet(
    context: context,
    expand: false,
    backgroundColor: AppColors.kGray1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          final media = MediaQuery.of(ctx);

          return SizedBox(
            height: media.size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // Заголовок + крестик
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title.isEmpty ? 'Область/Район ОГД' : title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1.1,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: Image.asset(
                          Assets.icons.defaultCloseIcon.path,
                          scale: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),

                // Поиск
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAECED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 18,
                            height: 18,
                            child: Image.asset(
                              Assets.icons.defaultSearchIcon.path,
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                final query = value.toLowerCase();
                                filtered = options.where((CityModel city) {
                                  final text = (city.city ?? city.name ?? '')
                                      .toLowerCase();
                                  return text.contains(query);
                                }).toList();

                                // если выбранный город исчез из фильтра
                                if (selectedCity != null &&
                                    !filtered
                                        .any((c) => c.id == selectedCity!.id)) {
                                  selectedCity = null;
                                }
                              });
                            },
                            style: AppTextStyles.size16Weight400,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: 'Поиск',
                              hintStyle: AppTextStyles.size16Weight400.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          color: AppColors.kGray2,
                        ),
                        itemBuilder: (context, index) {
                          final city = filtered[index];
                          final bool isSelected =
                              selectedCity?.city == city.city;

                          final String titleText = city.city ?? city.name ?? '';

                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(() {
                                selectedCity = city;
                              });
                            },
                            child: Container(
                              height: 52,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      titleText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
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
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Кнопка "Выбрать"
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16 + media.viewPadding.bottom,
                  ),
                  child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: selectedCity != null
                            ? () {
                                callback(selectedCity!);
                                Navigator.pop(ctx);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainPurpleColor,
                          disabledBackgroundColor:
                              AppColors.boxDecorBackgroundPurpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Выбрать',
                          style: AppTextStyles.size18Weight600
                              .copyWith(color: AppColors.kWhite),
                        ),
                      )),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
