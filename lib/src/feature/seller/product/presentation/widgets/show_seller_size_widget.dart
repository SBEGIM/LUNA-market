import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/optom_price_seller_dto.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/size_count_seller_dto.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_cats_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerSizeOptions(BuildContext context, String title,
    List<CatsModel>? mockSizes, Function callback) {
  int selectedCategory = -1;
  int price = 0;
  String sizeId = '';
  TextEditingController sizeCountController = TextEditingController();
  String? sizeName;

  showMaterialModalBottomSheet(
    context: context,
    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заголовок и крестик
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
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

                  SizedBox(height: 20),

                  // Row(
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.center,
                  //       margin: const EdgeInsets.only(right: 10),
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(8)),
                  //       width: 102,
                  //       height: 38,
                  //       child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               sizeName == '' ? 'Размер' : sizeName,
                  //               style: const TextStyle(
                  //                   fontSize: 12, fontWeight: FontWeight.w400),
                  //             ),
                  //             PopupMenuButton(
                  //               onSelected: (value) {
                  //                 // mockSizeAdds!.add(value as Cats);
                  //                 sizeId = value.id.toString();
                  //                 sizeName = value.name ?? 'Пустое';

                  //                 setState(() {});

                  //                 // mockSizeAdds!.forEach((element) {
                  //                 //   return print(element.name);
                  //                 // });
                  //               },
                  //               shape: const RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.all(
                  //                   Radius.circular(15.0),
                  //                 ),
                  //               ),
                  //               icon: SvgPicture.asset(
                  //                   'assets/icons/dropdown.svg'),
                  //               position: PopupMenuPosition.under,
                  //               offset: const Offset(0, 0),
                  //               itemBuilder: (
                  //                 BuildContext bc,
                  //               ) {
                  //                 return mockSizes!.map<PopupMenuItem>((e) {
                  //                   return PopupMenuItem(
                  //                     value: e,
                  //                     child: Text(
                  //                       e.name ?? 'Пустое',
                  //                       style: const TextStyle(
                  //                         color: Colors.black,
                  //                       ),
                  //                     ),
                  //                   );
                  //                 }).toList();
                  //               },
                  //             )

                  //             // SvgPicture.asset(
                  //             //     'assets/icons/dropdown.svg')
                  //           ]),
                  //     ),
                  //   ],
                  // ),

                  FieldsProductRequest(
                    titleText: 'Размеры',
                    hintText: sizeName ?? 'Выберите из списка',
                    star: true,
                    arrow: true,
                    hintColor: true,
                    onPressed: () {
                      showSellerCatsOptions(context, 'Размеры', mockSizes!,
                          (value) {
                        final CatsModel catsModel = value;

                        print(catsModel.name);

                        sizeId = catsModel.id.toString();
                        sizeName = catsModel.name ?? 'Пустое';

                        setState(() {});
                      });
                    },
                  ),

                  FieldsProductRequest(
                    titleText: 'Количество в наличии',
                    hintText: 'Введите количество',
                    star: true,
                    arrow: false,
                    hintColor: false,
                    controller: sizeCountController,
                  ),

                  // Кнопка "Выбрать"
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final data = SizeCountSellerDto(
                              id: sizeId,
                              name: sizeName ?? 'Пустое',
                              count: sizeCountController.text);
                          callback.call(data);
                          Navigator.pop(context, selectedCategory);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainPurpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Сохранить",
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
