import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
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
    backgroundColor: AppColors.kBackgroundColor,
    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            top: false,
            bottom: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: product.bloc?.length != 0 ? 350 : 332,
                maxHeight: product.bloc?.length != 0 ? 450 : 332,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.size16Weight600,
                        ),
                        InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Image.asset(
                              Assets.icons.defaultCloseIcon.path,
                              height: 24,
                              width: 24,
                            )),
                      ],
                    ),
                  ),
                  product.bloc?.length != 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: CustomSwitchButton<int>(
                            groupValue: segmentValue,
                            backgroundColor: Color(0xffEDEDED),
                            thumbColor: AppColors.kWhite,
                            children: {
                              0: Container(
                                alignment: Alignment.center,
                                height: 39,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('Штучно',
                                    style:
                                        AppTextStyles.size16Weight600.copyWith(
                                      color: segmentValue == 0
                                          ? Colors.black
                                          : const Color(0xff9B9B9B),
                                    )),
                              ),
                              1: Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('Оптом',
                                    style: AppTextStyles.size16Weight600
                                        .copyWith(
                                            color: segmentValue == 0
                                                ? Colors.black
                                                : const Color(0xff9B9B9B))),
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: product.bloc?.isEmpty != true ? 210 : 162,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          padding:
                              EdgeInsets.only(top: 12, right: 12, left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 94,
                                    width: 114,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xffEAECED),
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        "https://lunamarket.ru/storage/${product.path?.first}",
                                        fit: BoxFit.cover,
                                        height: 94,
                                        width: 114,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const ErrorImageWidget(
                                          height: 94,
                                          width: 114,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                      color: Color(0xff8E8E93),
                                                      letterSpacing: -1,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Color(0xff8E8E93),
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
                                        SizedBox(height: 4),
                                        SizedBox(
                                          width: 212,
                                          child: Text(
                                            '${product.name} Смартфон Apple iPhone 16 512GB Pink',
                                            maxLines: 2,
                                            style: AppTextStyles.size13Weight400
                                                .copyWith(
                                                    color: Color(0xff636366)),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'В наличии: ${product.product_count}',
                                          style: AppTextStyles.size13Weight400
                                              .copyWith(
                                                  color: Color(0xff636366)),
                                        ),
                                      ])
                                ],
                              ),
                              SizedBox(height: 12),
                              Container(
                                // margin: EdgeInsets.only(left: 154),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                          decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(16)),
                          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 94,
                                    width: 114,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xffEAECED),
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        "https://lunamarket.ru/storage/${product.path?.first}",
                                        fit: BoxFit.cover,
                                        height: 94,
                                        width: 114,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const ErrorImageWidget(
                                          height: 94,
                                          width: 114,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        compoundPrice != 0
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${formatPrice(compoundPrice)} ₽ ',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    '${formatPrice(product.price!)} ₽ ',
                                                    style: const TextStyle(
                                                      color: AppColors.kGray300,
                                                      letterSpacing: -1,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                        SizedBox(height: 4),
                                        SizedBox(
                                          width: 212,
                                          child: Text(
                                            '${product.name} Смартфон Apple iPhone 16 512GB Pink',
                                            style: AppTextStyles.size13Weight400
                                                .copyWith(
                                                    color: Color(0xff636366)),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'В наличии: ${product.bloc?.length} шт',
                                          style: AppTextStyles.size13Weight400
                                              .copyWith(
                                                  color: Color(0xff636366)),
                                        ),
                                        SizedBox(height: 14),
                                      ])
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Divider(
                                thickness: 0.1, // толщина линии
                                height:
                                    1, // общая высота виджета (должна быть ≥ thickness)
                              ),
                              const SizedBox(height: 6),
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
                                                            .bloc?[index]
                                                            .count ??
                                                        0;
                                                    basketPrice = product
                                                            .bloc?[index]
                                                            .price ??
                                                        0;
                                                    isOptom = true;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                decoration: BoxDecoration(
                                                  color: selectedIndex3 == index
                                                      ? AppColors
                                                          .mainPurpleColor
                                                      : AppColors.kGray2,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    width: 1,
                                                    color:
                                                        selectedIndex3 == index
                                                            ? AppColors
                                                                .mainPurpleColor
                                                            : AppColors.kGray2,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(
                                            1), // Толщина границы
                                        child: Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .white, // Цвет внутреннего фона
                                            borderRadius: BorderRadius.circular(
                                                8), // Чуть меньше радиус
                                          ),
                                          child: ShaderMask(
                                            shaderCallback: (bounds) =>
                                                const LinearGradient(
                                              colors: [
                                                Color(0xFF7D2DFF),
                                                Color(0xFF41DDFF)
                                              ],
                                            ).createShader(bounds),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Text(
                                                selectedIndex3 != -1
                                                    ? " = ${product.bloc![selectedIndex3].price} ₽"
                                                    : '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors
                                                      .white, // Неважно — будет заменён градиентом
                                                ),
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
                                            fontSize: 13,
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
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("В корзину",
                                style: AppTextStyles.size16Weight600
                                    .copyWith(color: AppColors.kWhite)),
                            Text("Уточните срок и цену доставки у продавца",
                                style: AppTextStyles.size12Weight400
                                    .copyWith(color: AppColors.kWhite)),
                          ],
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
