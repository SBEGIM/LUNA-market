import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/app/widgets/custom_switch_button.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/optom_price_seller_dto.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBasketBottomSheetOptions(BuildContext context, String title, int optom,
    ProductModel product, Function callback) {
  int selectedCategory = -1;
  int compoundPrice = (product.price!.toInt() - product.compound!.toInt());

  TextEditingController optomController = TextEditingController();

  int basketCount = 1;
  int basketPrice = product.price ?? 0;

  bool hasOptom = product.bloc?.isNotEmpty ?? false;

  int basketOptomCount = hasOptom ? product.bloc!.first.count! : 0;
  int basketOptomPrice = hasOptom ? product.bloc!.first.price! : 0;

  bool isOptom = hasOptom;

  int selectedIndex3 = hasOptom ? 0 : -1;

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
                minHeight: product.bloc?.length != 0 && segmentValue == 1
                    ? 400
                    : (product.bloc?.length != 0 ? 337 : 300),
                maxHeight: product.bloc?.length != 0 && segmentValue == 1
                    ? 500
                    : (product.bloc?.length != 0 ? 337 : 300),
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
                            vertical: 0,
                          ),
                          child: CustomSwitchButton<int>(
                            groupValue: segmentValue,
                            backgroundColor: Color(0xffEDEDED),
                            thumbColor: AppColors.kWhite,
                            children: {
                              0: Container(
                                alignment: Alignment.center,
                                height: 32,
                                width: MediaQuery.of(context).size.width,
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
                                height: 32,
                                child: Text('Оптом',
                                    style: AppTextStyles.size16Weight600
                                        .copyWith(
                                            color: segmentValue == 1
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
                          height:
                              product.bloc?.isEmpty != true && segmentValue == 1
                                  ? 210
                                  : 152,
                          margin: EdgeInsets.only(left: 16, right: 16, top: 12),
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
                                            '${product.name}',
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
                                        SizedBox(height: 12),
                                        Container(
                                          // margin: EdgeInsets.only(left: 154),
                                          height: 40,
                                          width: 111,
                                          decoration: BoxDecoration(
                                              color: Color(0xffF7F7F7),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                child: const Icon(
                                                  Icons.remove,
                                                  color:
                                                      AppColors.mainPurpleColor,
                                                ),
                                              ),
                                              // const SizedBox(
                                              //   width: 14,
                                              // ),
                                              Container(
                                                width: 28,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '$basketCount',
                                                  style: AppTextStyles
                                                      .size16Weight600,
                                                ),
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
                                                child: const Icon(
                                                  Icons.add,
                                                  color:
                                                      AppColors.mainPurpleColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ])
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 300,
                          decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(16)),
                          margin: EdgeInsets.only(left: 16, right: 16, top: 12),
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
                                          MainAxisAlignment.start,
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
                                                    style: AppTextStyles
                                                        .size14Weight400
                                                        .copyWith(
                                                      color: Color(0xff8E8E93),
                                                      letterSpacing: -1,
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
                                          height: 18,
                                          width: 212,
                                          child: Text(
                                            '${product.name}',
                                            maxLines: 1,
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
                              const SizedBox(height: 12),
                              const Divider(
                                thickness: 0.1, // толщина линии
                                height:
                                    1, // общая высота виджета (должна быть ≥ thickness)
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Укажите количество  (от ${product.bloc?.first.count ?? 0} шт.)',
                                style: AppTextStyles.size13Weight400
                                    .copyWith(color: Color(0xff636366)),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                behavior: HitTestBehavior
                                    .opaque, // ловит тап по всей области
                                onTap: () => _showOptomPickerBottomSheet(
                                  context,
                                  selectedIndex3 != -1 ? selectedIndex3 : 0,
                                  product.bloc!,
                                  (optomIndex) {
                                    if (selectedIndex3 == optomIndex) {
                                      selectedIndex3 = -1;
                                      setState(() {
                                        basketOptomCount = 0;
                                        basketOptomPrice = 0;
                                        isOptom = false;
                                      });
                                    } else {
                                      selectedIndex3 = optomIndex;
                                      setState(() {
                                        basketOptomCount =
                                            product.bloc?[optomIndex].count ??
                                                0;
                                        basketOptomPrice =
                                            product.bloc?[optomIndex].price ??
                                                0;
                                        isOptom = true;
                                      });
                                    }
                                  },
                                ),
                                child: Container(
                                  height: 52,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.kGray2,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: IgnorePointer(
                                    // чтобы тап ушел наружу
                                    child: TextField(
                                      controller: optomController,
                                      readOnly: true,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: '$basketOptomCount шт',
                                        hintStyle:
                                            AppTextStyles.size16Weight400,
                                        border: InputBorder.none,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onSubmitted: (_) =>
                                          FocusScope.of(context).unfocus(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Row(children: [
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
                                                    ? " ${product.bloc![selectedIndex3].price} ₽"
                                                    : '0 ₽',
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

                                      Text(
                                        selectedIndex3 != -1
                                            ? '  x ${product.bloc?[selectedIndex3].count ?? 0} шт'
                                            : '  x 0 шт',
                                        style: AppTextStyles.size16Weight400,
                                      ),
                                      // Text(
                                      //   ' x${count != -1 ? count : 0}',
                                      //   style: const TextStyle(
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.w400,
                                      //       color: Colors.grey),
                                      // ),
                                      Spacer(),
                                      Text(
                                          ' = ${(selectedIndex3 != -1 ? (product.bloc![selectedIndex3].price! * product.bloc![selectedIndex3].count!) : 0)}₽',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
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
                                      Image.asset(
                                        Assets.icons.savingMoneyIcon.path,
                                        height: 22,
                                        width: 22,
                                      ),
                                      SizedBox(width: 6),
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
                                        style: AppTextStyles.size13Weight500,
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
                          if (basketOptomCount <= 0 && basketCount <= 0) {
                            AppSnackBar.show(
                              context,
                              'Ой! Ноль — не вариант. Выберите хотя бы 1.',
                              type: AppSnackType.error,
                            );
                            return;
                          }

                          if (isOptom) {
                            callback.call(
                                basketOptomCount, basketOptomPrice, true);
                          } else {
                            callback.call(basketCount, basketPrice, false);
                          }

                          Navigator.pop(context, selectedCategory);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: basketCount == 0
                              ? AppColors.kGray200
                              : AppColors.mainPurpleColor,
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

void _showOptomPickerBottomSheet(
  BuildContext context,
  int initialSelected,
  List<Bloc> listOptom,
  void Function(int) onOptomSelected,
) {
  final List<Bloc> optoms = listOptom;

  final int initialIndex = optoms.indexOf(listOptom[initialSelected]);
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(
    initialItem:
        initialIndex == -1 ? 0 : initialIndex, // фолбэк, если года нет в списке
  );

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Color(0xffF7F7F7),
    builder: (context) {
      int selected =
          initialSelected; // Локальный selectedYear для обновления в билдере

      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: 402,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Укажите количество',
                        style: AppTextStyles.size16Weight500,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          Assets.icons.defaultCloseIcon.path,
                          scale: 1.9,
                          width: 24,
                          height: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 212,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(16)),
                  child: ListWheelScrollView.useDelegate(
                    controller: scrollController,
                    itemExtent: 50,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setModalState(() {
                        selected = index;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index < 0 || index >= optoms.length) return null;
                        final year = index;
                        final isSelected = year == selected;

                        return Container(
                          height: 36,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xffEAECED)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 24),
                          child: Text('${optoms[index].count} шт',
                              style: AppTextStyles.size20Weight500.copyWith(
                                color: isSelected
                                    ? AppColors.kGray900
                                    : Color(0xff8E8E93),
                              )),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, top: 16, bottom: 50),
                  child: DefaultButton(
                      text: 'Выбрать',
                      press: () {
                        onOptomSelected(selected);
                        Navigator.of(context).pop();
                      },
                      color: AppColors.kWhite,
                      backgroundColor: AppColors.mainPurpleColor,
                      width: double.infinity),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
