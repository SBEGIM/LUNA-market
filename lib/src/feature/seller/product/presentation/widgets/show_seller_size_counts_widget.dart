import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/size_count_seller_dto.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerSizeCountOptions(
  BuildContext context,
  String title,
  List<SizeCountSellerDto>? subCharacteristics,
  Function(List<SizeCountSellerDto>) callback,
) {
  List<SizeCountSellerDto> _filteredCategories = [...subCharacteristics!];
  List<SizeCountSellerDto> selectedCategory = [];
  TextEditingController searchController = TextEditingController();

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
              maxHeight: (_filteredCategories.length * 85 + 100)
                  .toDouble()
                  .clamp(250, 500),
            ),
            child: Column(
              children: [
                // Заголовок
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
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
                      itemCount: _filteredCategories.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, thickness: 0.5),
                      itemBuilder: (context, index) {
                        var category = _filteredCategories[index];
                        final isSelected = selectedCategory.contains(category);

                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
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
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('minus');

                                        setState(() {
                                          final myInt =
                                              int.parse(category.count);

                                          if (myInt <= 0) {
                                            return;
                                          }
                                          final updatedCategory =
                                              category.copyWith(
                                                  count:
                                                      (myInt - 1).toString());
                                          _filteredCategories[index] =
                                              updatedCategory;

                                          if (int.parse(
                                                  updatedCategory.count) <=
                                              0) {
                                            selectedCategory.removeWhere(
                                                (element) =>
                                                    element.id ==
                                                    updatedCategory.id);
                                            return;
                                          }

                                          int indexModel = -1;

                                          indexModel =
                                              selectedCategory.indexWhere((e) =>
                                                  e.id == updatedCategory.id);
                                          if (indexModel != -1) {
                                            // Элемент найден — обновляем
                                            selectedCategory[indexModel] =
                                                updatedCategory;
                                          } else {
                                            // Элемента нет — добавляем
                                            selectedCategory
                                                .add(updatedCategory);
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: AppColors.mainPurpleColor,
                                      ),
                                    ),
                                    Text(
                                      '${category.count}',
                                      style: AppTextStyles.aboutTextStyle,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          final myInt =
                                              int.parse(category.count);
                                          final updatedCategory =
                                              category.copyWith(
                                                  count:
                                                      (myInt + 1).toString());
                                          _filteredCategories[index] =
                                              updatedCategory;

                                          int indexModel = -1;

                                          indexModel =
                                              selectedCategory.indexWhere((e) =>
                                                  e.id == updatedCategory.id);
                                          if (indexModel != -1) {
                                            // Элемент найден — обновляем
                                            selectedCategory[indexModel] =
                                                updatedCategory;
                                          } else {
                                            // Элемента нет — добавляем
                                            selectedCategory
                                                .add(updatedCategory);
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.mainPurpleColor,
                                      ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

class FieldsProductRequest extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final bool? hintColor;
  final TextEditingController? controller;
  final CatsModel? cats;
  final bool? textInputNumber;
  final bool readOnly;
  final void Function()? onPressed;
  final int? maxLines;
  final void Function(String)? onChanged; // добавили

  const FieldsProductRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.hintColor,
    this.controller,
    this.cats,
    this.textInputNumber,
    Key? key,
    this.onPressed,
    this.readOnly = false,
    this.maxLines,
    this.onChanged, // добавили
  }) : super(key: key);

  @override
  State<FieldsProductRequest> createState() => _FieldsProductRequestState();
}

class _FieldsProductRequestState extends State<FieldsProductRequest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.titleText,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.kGray900),
              ),
              widget.star == true
                  ? const Text(
                      '*',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.red),
                    )
                  : Container()
            ],
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
                color: AppColors.kGray2,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: TextField(
                controller: widget.controller,
                readOnly:
                    (widget.hintColor == false || widget.hintColor == null)
                        ? widget.readOnly
                        : true,
                keyboardType: (widget.maxLines != null && widget.maxLines! > 1)
                    ? TextInputType.multiline
                    : ((widget.textInputNumber == false ||
                            widget.textInputNumber == null)
                        ? TextInputType.text
                        : const TextInputType.numberWithOptions(
                            signed: true, decimal: true)),
                maxLines: widget.maxLines ?? 1,
                onChanged: widget.onChanged, // добавили
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color:
                          (widget.hintColor == null || widget.hintColor != true)
                              ? const Color.fromRGBO(194, 197, 200, 1)
                              : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: widget.arrow == true
                      ? IconButton(
                          onPressed: widget.onPressed,
                          icon: SvgPicture.asset('assets/icons/back_menu.svg',
                              color: Colors.grey),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
