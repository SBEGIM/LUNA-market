import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_switch_button.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBasketBottomSheetOptions(BuildContext context, String title, int optom,
    ProductModel product, Function callback) {
  int selectedCategory = -1;
  int compoundPrice = (product.price!.toInt() - product.compound!.toInt());

  int basketCount = 0;
  int basketPrice = 0;
  bool isOptom = false;

  int selectedIndex3 = 0;
  int segmentValue = 0;

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

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
            constraints: BoxConstraints(
              minHeight: product.bloc?.length != 0 ? 350 : 300,
              maxHeight: product.bloc?.length != 0 ? 450 : 300,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок и крестик
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
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
                ),
                product.bloc?.length != 0
                    ? Container(
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 16,
                          bottom: 8,
                          right: 16,
                          // right: screenSize.height * 0.016,
                        ),
                        child: CustomSwitchButton<int>(
                          groupValue: segmentValue,
                          children: {
                            0: Container(
                              alignment: Alignment.center,
                              height: 39,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Штучно',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: segmentValue == 0
                                      ? Colors.black
                                      : const Color(0xff9B9B9B),
                                ),
                              ),
                            ),
                            1: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              height: 39,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Оптом',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: segmentValue == 1
                                      ? Colors.black
                                      : const Color(0xff9B9B9B),
                                ),
                              ),
                            ),
                          },
                          onValueChanged: (int? value) {
                            if (value != null) {
                              segmentValue = value;
                              setState(() {});
                            }
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                segmentValue == 0
                    ? Container(
                        height: product.bloc?.isEmpty != true ? 210 : 200,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      "https://lunamarket.ru/storage/${product.path?.first}",
                                      fit: BoxFit.cover,
                                      height: 114,
                                      width: 94,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const ErrorImageWidget(
                                        height: 283,
                                        width: 345,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      compoundPrice != 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  // width: 75,
                                                  child: Text(
                                                    '${formatPrice(compoundPrice)} ₽ ',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                Text(
                                                  '${formatPrice(product.price!)} ₽ ',
                                                  style: const TextStyle(
                                                    color: AppColors.kGray300,
                                                    letterSpacing: -1,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        AppColors.kGray300,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              '${formatPrice(product.price!)} ₽ ',
                                              style: const TextStyle(
                                                color: AppColors.kGray900,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          '${product.name}',
                                          maxLines: 2,
                                          style: AppTextStyles.categoryTextStyle
                                              .copyWith(
                                                  color: AppColors.kGray300),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'В наличии: ${product.product_count}',
                                        style: AppTextStyles.categoryTextStyle
                                            .copyWith(
                                                color: AppColors.kGray300),
                                      ),
                                      SizedBox(height: 14),
                                    ])
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 154),
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  InkWell(
                                    splashColor: AppColors.kWhite,
                                    onTap: () {
                                      /// FIXME
                                      // BlocProvider.of<BasketCubit>(context)
                                      //     .basketMinus(
                                      //         widget.product.id.toString(),
                                      //         '1',
                                      //         0,
                                      //         'fbs');

                                      // BlocProvider.of<productCubit.ProductCubit>(
                                      //         context)
                                      //     .updateProductByIndex(
                                      //   index: widget.index,
                                      //   updatedProduct: widget.product.copyWith(
                                      //     basketCount: basketCount - 1,
                                      //   ),
                                      //);
                                      setState(() {
                                        if (basketCount == 0) {
                                          return;
                                          // isvisible = false;
                                        } else {
                                          // isvisible = true;
                                        }
                                        basketCount -= 1;
                                      });
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 32,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: AppColors.mainPurpleColor,
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 14,
                                  // ),
                                  Container(
                                    width: 28,
                                    alignment: Alignment.center,
                                    child: Text('$basketCount'),
                                  ),
                                  // const SizedBox(
                                  //   width: 14,
                                  // ),
                                  InkWell(
                                    splashColor: AppColors.kWhite,
                                    onTap: () {
                                      // BlocProvider.of<BasketCubit>(context)
                                      //     .basketAdd(widget.product.id.toString(),
                                      //         '1', 0, '', '');
                                      // BlocProvider.of<productCubit.ProductCubit>(
                                      //         context)
                                      //     .updateProductByIndex(
                                      //   index: widget.index,
                                      //   updatedProduct: widget.product.copyWith(
                                      //     basketCount: basketCount + 1,
                                      //   ),
                                      //  );

                                      /// FIXME
                                      setState(() {
                                        basketCount += 1;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      // child: SvgPicture.asset(
                                      //     'assets/icons/add_1.svg'),
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.mainPurpleColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        height: 230,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      "https://lunamarket.ru/storage/${product.path?.first}",
                                      fit: BoxFit.cover,
                                      height: 114,
                                      width: 94,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const ErrorImageWidget(
                                        height: 283,
                                        width: 345,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      compoundPrice != 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  // width: 75,
                                                  child: Text(
                                                    '${formatPrice(compoundPrice)} ₽ ',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                Text(
                                                  '${formatPrice(product.price!)} ₽ ',
                                                  style: const TextStyle(
                                                    color: AppColors.kGray300,
                                                    letterSpacing: -1,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        AppColors.kGray300,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              '${formatPrice(product.price!)} ₽ ',
                                              style: const TextStyle(
                                                color: AppColors.kGray900,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${product.name}',
                                        style: AppTextStyles.categoryTextStyle
                                            .copyWith(
                                                color: AppColors.kGray300),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'В наличии: ${product.bloc?.length} шт',
                                        style: AppTextStyles.categoryTextStyle
                                            .copyWith(
                                                color: AppColors.kGray300),
                                      ),
                                      SizedBox(height: 14),
                                    ])
                              ],
                            ),
                            Divider(),
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Row(children: [
                                    SizedBox(
                                      height: 28,
                                      child: ListView.builder(
                                        itemCount: product.bloc?.length ?? 0,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              if (selectedIndex3 == index) {
                                                selectedIndex3 = -1;
                                                setState(() {
                                                  basketCount = 0;
                                                  basketPrice = 0;
                                                  isOptom = false;
                                                });
                                              } else {
                                                selectedIndex3 = index;
                                                setState(() {
                                                  basketCount = product
                                                          .bloc?[index].count ??
                                                      0;
                                                  basketPrice = product
                                                          .bloc?[index].price ??
                                                      0;
                                                  isOptom = true;
                                                });
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: Container(
                                                width: 54,
                                                decoration: BoxDecoration(
                                                  color: selectedIndex3 == index
                                                      ? AppColors
                                                          .mainPurpleColor
                                                      : AppColors.kGray1,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    width: 1,
                                                    color:
                                                        selectedIndex3 == index
                                                            ? AppColors
                                                                .mainPurpleColor
                                                            : AppColors.kGray1,
                                                  ),
                                                ),
                                                // padding: const EdgeInsets.only(
                                                //   top: 8,
                                                //   bottom: 8,
                                                // ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'x${product.bloc?[index].count ?? 0}шт',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: selectedIndex3 ==
                                                              index
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Spacer(),

                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment(-0.6, -1),
                                          end: Alignment(1, 1),
                                          colors: [
                                            Color(0xFF7D2DFF),
                                            Color(0xFF41DDFF),
                                          ],
                                          stops: [0.2685, 1.0],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(
                                          2), // Толщина границы
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .white, // Цвет внутреннего фона
                                          borderRadius: BorderRadius.circular(
                                              12 - 1), // Чуть меньше радиус
                                        ),
                                        child: ShaderMask(
                                          shaderCallback: (bounds) =>
                                              const LinearGradient(
                                            colors: [
                                              Color(0xFF7D2DFF),
                                              Color(0xFF41DDFF)
                                            ],
                                          ).createShader(bounds),
                                          child: Text(
                                            selectedIndex3 != -1
                                                ? " = ${product.bloc![selectedIndex3].price} ₽"
                                                : '',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors
                                                  .white, // Неважно — будет заменён градиентом
                                            ),
                                          ),
                                        ), // Ваш контент
                                      ),
                                    ),

                                    // Text(
                                    //   ' x${count != -1 ? count : 0}',
                                    //   style: const TextStyle(
                                    //       fontSize: 12,
                                    //       fontWeight: FontWeight.w400,
                                    //       color: Colors.grey),
                                    // ),
                                    // Spacer(),
                                    // Text(
                                    //     ' = ${(selectedIndex3 != -1 ? product.bloc![selectedIndex3].price as int : 1)}₽',
                                    //     style: const TextStyle(
                                    //         fontSize: 16,
                                    //         letterSpacing: 0,
                                    //         fontWeight: FontWeight.w500,
                                    //         color: Colors.black)),
                                  ]),
                                ),

                                // Container(
                                //   alignment: Alignment.topRight,
                                //   padding: const EdgeInsets.only(right: 16),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       InkWell(
                                //         onTap: () {
                                //           // BlocProvider.of<BasketCubit>(context)
                                //           //     .basketMinus(
                                //           //         widget.product.id.toString(), '1');
                                //           if (count != 0) {
                                //             if (selectedIndex3 != -1) {
                                //               count -= 1;
                                //               // BlocProvider.of<BasketCubit>(
                                //               //         context)
                                //               //     .basketMinus(
                                //               //         widget.product.id
                                //               //             .toString(),
                                //               //         (widget
                                //               //                 .product
                                //               //                 .bloc![
                                //               //                     selectedIndex3!]
                                //               //                 .count! *
                                //               //             count),
                                //               //         (widget
                                //               //                 .product
                                //               //                 .bloc![
                                //               //                     selectedIndex3!]
                                //               //                 .price! *
                                //               //             count),
                                //               //         'fbs');
                                //             }
                                //           } else {
                                //             isvisible = false;
                                //           }

                                //           setState(() {});
                                //         },
                                //         child: Container(
                                //           height: 32,
                                //           width: 32,
                                //           padding: const EdgeInsets.all(4),
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(6),
                                //             color: Colors.white,
                                //             boxShadow: [
                                //               BoxShadow(
                                //                 color: Colors.grey
                                //                     .withOpacity(0.1),
                                //                 spreadRadius: 1,
                                //                 blurRadius: 1,
                                //                 offset: const Offset(0,
                                //                     1), // changes position of shadow
                                //               ),
                                //             ],
                                //           ),
                                //           child: const Icon(
                                //             Icons.remove,
                                //             color: AppColors.kPrimaryColor,
                                //           ),
                                //         ),
                                //       ),
                                //       // const SizedBox(
                                //       //   width: 14,
                                //       // ),
                                //       Container(
                                //         width: 28,
                                //         alignment: Alignment.center,
                                //         child: Text('$count'),
                                //       ),
                                //       // const SizedBox(
                                //       //   width: 14,
                                //       // ),
                                //       InkWell(
                                //         onTap: () {
                                //           // BlocProvider.of<BasketCubit>(context)
                                //           //     .basketAdd(
                                //           //         widget.product.id.toString(), '1');

                                //           if (selectedIndex3 != -1) {
                                //             count += 1;
                                //             isvisible = true;

                                //             // BlocProvider.of<BasketCubit>(
                                //             //         context)
                                //             //     .basketAdd(
                                //             //         widget.product.id
                                //             //             .toString(),
                                //             //         (widget
                                //             //                 .product
                                //             //                 .bloc![
                                //             //                     selectedIndex3!]
                                //             //                 .count! *
                                //             //             count),
                                //             //         (widget
                                //             //                 .product
                                //             //                 .bloc![
                                //             //                     selectedIndex3!]
                                //             //                 .price! *
                                //             //             count),
                                //             //         colorValue,
                                //             //         sizeValue,
                                //             //         isOptom: true);

                                //             setState(() {});
                                //           }
                                //         },
                                //         child: Container(
                                //           padding: const EdgeInsets.all(4),
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(10),
                                //             color: Colors.white,
                                //             boxShadow: [
                                //               BoxShadow(
                                //                 color: Colors.grey
                                //                     .withOpacity(0.1),
                                //                 spreadRadius: 1,
                                //                 blurRadius: 1,
                                //                 offset: const Offset(0,
                                //                     1), // changes position of shadow
                                //               ),
                                //             ],
                                //           ),
                                //           // child: SvgPicture.asset(
                                //           //     'assets/icons/add_1.svg'),
                                //           child: const Icon(
                                //             Icons.add,
                                //             color: AppColors.kPrimaryColor,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // const SizedBox(height: 14),

                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF7D2DFF),
                                          Color(0xFF41DDFF),
                                        ],
                                      ).createShader(bounds),
                                      blendMode: BlendMode.srcIn,
                                      child: const Icon(
                                        Icons.card_giftcard_outlined,
                                        size: 24,
                                        color: Colors
                                            .white, // Будет заменён градиентом
                                      ),
                                    ),
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        colors: [
                                          Color(0xFF7D2DFF),
                                          Color(0xFF41DDFF)
                                        ],
                                      ).createShader(bounds),
                                      child: Text(
                                        'Экономия',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors
                                              .white, // Неважно — будет заменён градиентом
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${selectedIndex3 != -1 ? ((((product.price! - product.price! / 100 * product.compound!) * product.bloc![selectedIndex3].count!) - product.bloc![selectedIndex3].price!)) : 0} ₽',
                                      style: const TextStyle(
                                          color: AppColors.kLightBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            )
                            // : SizedBox.shrink(),
                            ,
                          ],
                        ),
                      ),
                const SizedBox(height: 12),

                // Кнопка "Выбрать"
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        callback.call(basketCount, basketPrice, isOptom);
                        Navigator.pop(context, selectedCategory);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "В корзину",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          const Text(
                            "Уточните срок и цену доставки у продавца",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
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
