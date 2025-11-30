import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/mont_selector_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_basket_bottom_sheet_widget.dart';
import 'package:haji_market/src/feature/home/bloc/cats_cubit.dart';
import 'package:haji_market/src/feature/home/presentation/widgets/product_buy_with_card.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/profit_cubit.dart' as profitCubit;
import 'package:haji_market/src/feature/drawer/bloc/profit_state.dart' as profitState;
import 'package:haji_market/src/feature/drawer/presentation/widgets/pre_order_dialog.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/review_cubit.dart' as reviewProductCubit;
import 'package:haji_market/src/feature/drawer/bloc/review_state.dart' as reviewProductState;
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/product_imags_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/specifications_page.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:share_plus/share_plus.dart';
import '../../../home/presentation/widgets/product_watching_card.dart';
import '../../../favorite/bloc/favorite_cubit.dart';
import '../../../product/cubit/product_state.dart';

@RoutePage()
class DetailCardProductPage extends StatefulWidget {
  final ProductModel product;
  const DetailCardProductPage({required this.product, Key? key}) : super(key: key);

  @override
  State<DetailCardProductPage> createState() => _DetailCardProductPageState();
}

class _DetailCardProductPageState extends State<DetailCardProductPage> {
  int count = 0;
  int optom = 2;

  bool isvisible = false;

  int? selectedIndex = 0;
  int? selectedIndex2 = 0;
  int? selectedIndexMonth = 3;

  int? selectedIndex3 = -1;
  int? selectedIndex4 = 0;

  double procentPrice = 0;
  int compoundPrice = 0;

  bool showText = false;

  //bool isvisible = false;
  bool inFavorite = false;
  List textDescrp = [];
  List textInst = ['3 мес', '6 мес', '12 мес', '24 мес'];

  List texts = ['Описание', 'Характеристики', 'Отзыв'];

  String textBloc = 'Описание';

  List bloc = [10, 20, 30, 40];
  String? sizeValue;
  String? colorValue;
  List size = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  int? rating = 0;
  int imageIndex = 0;

  bool icon = true;

  String? productNames;

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  // final TextEditingController _commentController = TextEditingController();
  VideoPlayerController? _controller;
  PageController controller = PageController();

  // если из бэка приходит список недоступных размеров — заполни сюда
  // можно в виде ['XS', '6XL'] или полных значений ['XS-42'].
  final Set<String> outOfStock = {
    // пример: 'L', '5XL-58'
  };

  String labelOf(String raw) {
    final i = raw.indexOf('-');
    return i == -1 ? raw : raw.substring(0, i);
  }

  String numberOf(String raw) {
    final i = raw.indexOf('-');
    return i == -1 ? '' : raw.substring(i + 1);
  }

  @override
  void initState() {
    textDescrp = [
      'Все товары “${widget.product.shop!.name}”',
      'Все товары этого бренда',
      'Все товары из категории ${widget.product.catName}',
    ];
    isvisible = widget.product.inBasket ?? false;
    inFavorite = widget.product.inFavorite ?? false;

    productNames = "$kDeepLinkUrl/?product_id\u003d${widget.product.id}";
    super.initState();

    compoundPrice = (widget.product.price!.toInt() - widget.product.compound!.toInt());

    BlocProvider.of<reviewProductCubit.ReviewCubit>(context).reviews(widget.product.id.toString());
    // BlocProvider.of<profitCubit.ProfitCubit>(context)
    //     .profit(widget.product.id.toString());

    if (widget.product.video != null) {
      _controller =
          VideoPlayerController.network(
              // 'https://lunamarket.ru/storage/${widget.product.path?.first ?? ''}'
              'https://lunamarket.ru/storage/${widget.product.video}',
            )
            ..initialize().then((_) {
              _controller!.pause();
              // setState(() {});
            });

      _controller!.addListener(() {
        _controller!.value.isPlaying == true ? icon = false : icon = true;

        setState(() {});
      });
    }
    widget.product.bloc?.forEach((element) {
      optom += element.count!.toInt();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizesRaw = widget.product.size ?? [];

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: AppColors.kLightBlackColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: GestureDetector(
              onTap: () async {
                await Share.share('$productNames');
              },
              child: Image.asset(
                Assets.icons.shareNewIcon.path,
                height: 20,
                width: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        cacheExtent: 10000,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 377,
            child: Stack(
              children: [
                Container(
                  height: 377,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    itemCount:
                        (widget.product.path?.length ?? 0) + (widget.product.video != null ? 1 : 0),
                    onPageChanged: (value) {
                      imageIndex = value;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      final isVideo =
                          widget.product.video != null &&
                          index == (widget.product.path?.length ?? 0);

                      if (isVideo) {
                        return GestureDetector(
                          onTap: () {
                            _controller!.value.isPlaying
                                ? _controller!.pause()
                                : _controller!.play();
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                ),
                              ),
                              // Container(
                              //   height: 358,
                              //   alignment: Alignment.bottomCenter,
                              //   padding: EdgeInsets.only(
                              //     bottom:
                              //         MediaQuery.of(context).size.height * 0.01,
                              //   ),
                              //   child: VideoProgressIndicator(
                              //     _controller!,
                              //     allowScrubbing: true,
                              //   ),
                              // ),
                              if (icon)
                                Center(
                                  child: Image.asset(
                                    Assets.icons.tapePlayIcon.path,
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }

                      // Фото
                      return Container(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://lunamarket.ru/storage/${widget.product.path![index]}",
                                fit: BoxFit.cover,
                                height: 377,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    const ErrorImageWidget(height: 283, width: double.infinity),
                              ),
                            ),
                            Positioned(
                              bottom: 6,
                              right: 20,
                              child: GestureDetector(
                                onTap: (() {
                                  Get.to(
                                    () => ProductImages(
                                      images: widget.product.path,
                                      video: widget.product.video,
                                    ),
                                  );
                                }),
                                child: Image.asset(
                                  Assets.icons.fullscreen.path,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 28,
                  child: Container(
                    width: 57,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.kYellowDark,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTextStyles.size12Weight400, // базовый стиль для цифр
                        children: [
                          const TextSpan(text: '0', style: AppTextStyles.size12Weight400),
                          TextSpan(
                            text: '·',
                            style: AppTextStyles.size14Weight500.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: '0', style: AppTextStyles.size12Weight400),
                          TextSpan(
                            text: '·',
                            style: AppTextStyles.size14Weight500.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: '12', style: AppTextStyles.size12Weight400),
                        ],
                      ),
                    ),
                  ),
                ),
                widget.product.point != 0
                    ? Positioned(
                        top: 40,
                        left: 28,
                        child: Container(
                          width: 52,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.6, -1), // приблизительное направление 128.49°
                              end: Alignment(1, 1),
                              colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                              stops: [0.2685, 1.0], // соответствуют 26.85% и 100%
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            '${widget.product.point ?? 0}% Б',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.statisticsTextStyle.copyWith(
                              color: AppColors.kWhite,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                widget.product.bloggerPoint != 0
                    ? Positioned(
                        bottom: 16,
                        left: 28,
                        child: Container(
                          width: 205,
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.6, -1), // приблизительное направление 128.49°
                              end: Alignment(1, 1),
                              colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                              stops: [0.2685, 1.0], // соответствуют 26.85% и 100%
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            'Вознаграждение блогера: ${widget.product.bloggerPoint ?? 0}%',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.size13Weight400.copyWith(color: AppColors.kWhite),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            //  width: 12,
            //  alignment: Alignment.r,
            //     margin: const EdgeInsets.only(
            // left: 154.0, right: 20, top: 260, bottom: 4),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  (widget.product.path?.length ?? 0) + (widget.product.video != null ? 1 : 0),
                  (index) => GestureDetector(
                    onTap: () {
                      imageIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: imageIndex == index ? AppColors.kGray400 : AppColors.kGray2,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                compoundPrice != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: 75,
                            child: Text(
                              '${formatPrice(compoundPrice)} ₽ ',
                              style: AppTextStyles.size18Weight700,
                            ),
                          ),
                          Text(
                            '${formatPrice(widget.product.price!)} ₽ ',
                            style: AppTextStyles.size13Weight400.copyWith(
                              color: Color(0xff8E8E93),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Color(0xff8E8E93),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '${formatPrice(widget.product.price!)} ₽ ',
                        style: AppTextStyles.size18Weight700,
                      ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "${widget.product.name}",
                        maxLines: 2,
                        style: AppTextStyles.size18Weight500,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final favorite = BlocProvider.of<FavoriteCubit>(context);
                        await favorite.favorite(widget.product.id.toString());
                        setState(() {
                          inFavorite = !inFavorite;
                        });

                        final filters = context.read<FilterProvider>();

                        BlocProvider.of<ProductCubit>(context).products(filters);
                      },
                      child: SizedBox(
                        width: 21,
                        height: 21,
                        child: Image.asset(
                          Assets.icons.favoriteDetailProductIcon.path,
                          fit: BoxFit.contain,
                          color: inFavorite == true
                              ? AppColors.mainRedColor
                              : const Color(0xffAEAEB2),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar(
                      ignoreGestures: true,
                      initialRating: double.parse(widget.product.rating.toString()),
                      unratedColor: const Color(0x30F11712),
                      itemSize: 16,
                      itemPadding: EdgeInsets.only(right: 3.2),
                      ratingWidget: RatingWidget(
                        full: SizedBox(
                          height: 12.8,
                          width: 12.8,
                          child: Image.asset(
                            Assets.icons.defaultStarIcon.path,
                            fit: BoxFit.contain,
                            color: Color(0xFFFFD54F),
                          ),
                        ),
                        half: SizedBox(
                          height: 12.8,
                          width: 12.8,
                          child: Image.asset(
                            Assets.icons.defaultStarIcon.path,
                            fit: BoxFit.contain,
                            color: Color(0xffAEAEB2),
                          ),
                        ),
                        empty: SizedBox(
                          height: 12.8,
                          width: 12.8,
                          child: Image.asset(
                            Assets.icons.defaultStarIcon.path,
                            fit: BoxFit.contain,
                            color: Color(0xffAEAEB2),
                          ),
                        ),
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    Row(
                      children: [
                        Text(
                          'Код товара: ',
                          style: AppTextStyles.size13Weight400.copyWith(color: Color(0xffAEAEB2)),
                        ),
                        Text(
                          widget.product.id.toString().padLeft(10, '0'),
                          style: AppTextStyles.size13Weight400,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(height: 1, thickness: 1, color: Color(0xffEAECED)),

                if ((widget.product.color ?? []).isNotEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        'Цвет:${selectedIndex != -1 ? (widget.product.color?[selectedIndex!].name) : 'Не выбран'}',
                        style: AppTextStyles.size14Weight400,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 54,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product.color!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                if (selectedIndex != index) {
                                  colorValue = widget.product.color![index].value;
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                } else {
                                  colorValue = '';
                                  setState(() {
                                    selectedIndex = -1;
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: 54,
                                  width: 54,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(
                                      AppColors.getColorFromHex(
                                        widget.product.color![index].value!,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: selectedIndex == index
                                        ? Border.all(color: AppColors.mainPurpleColor, width: 2)
                                        : Border.all(color: Color(0xffEAECED), width: 2),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                if ((widget.product.size ?? []).isNotEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        'Размер:${selectedIndex4 != -1 ? (widget.product.size?[selectedIndex4!]) : 'Не выбран'}',
                        style: AppTextStyles.size14Weight400,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 54,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: sizesRaw.length,
                          itemBuilder: (_, i) => sizeTile(i),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 24),
                // Stack(children: [
                //   Container(
                //     transform: Matrix4.translationValues(-16.0, 0.0, 00.0),
                //     height: 8,
                //     color: const Color(0xFFf1f1f1),
                //   ),
                //   Container(
                //     transform: Matrix4.translationValues(16.0, 0.0, 00.0),
                //     height: 8,
                //     color: const Color(0xFFf1f1f1),
                //   ),
                // ]),
                // BlocBuilder<profitCubit.ProfitCubit, profitState.ProfitState>(
                //     builder: (context, state) {
                //   if (state is profitState.ErrorState) {
                //     return Center(
                //       child: Text(
                //         state.message,
                //         style:
                //             const TextStyle(fontSize: 20.0, color: Colors.grey),
                //       ),
                //     );
                //   }
                //   if (state is profitState.LoadedState) {
                //     return Container(
                //         height: 150,
                //         width: double.infinity,
                //         padding: EdgeInsets.zero,
                //         child: Image.network(
                //           'https://lunamarket.ru/storage/${state.path}',
                //           fit: BoxFit.cover,
                //         ));
                //   } else {
                //     return const Center(
                //         child: CircularProgressIndicator(
                //             color: Colors.indigoAccent));
                //   }
                // }),

                // Row(
                //   children: [
                // count < 1
                //     ? SizedBox()
                //:
                // count >= 1
                //     ? const SizedBox()
                //     : GestureDetector(
                //         onTap: () {
                //           // BlocProvider.of<BasketCubit>(context)
                //           //     .basketAdd(widget.product.id.toString(), '1');
                //           setState(() {
                //             count += 1;
                //             if (count == 0) {
                //               isvisible = false;
                //             } else {
                //               isvisible = true;
                //             }
                //           });
                //         },
                //         child: Container(
                //           width: 99,
                //           height: 32,
                //           decoration: BoxDecoration(
                //             color: const Color(0xFF1DC4CF),
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           alignment: Alignment.center,
                //           child: const Text(
                //             'В корзину',
                //             // textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 fontSize: 14,
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.w600),
                //           ),
                //         ),
                //       ),
                //   ],
                // ),
                // Container(
                //   //padding: const EdgeInsets.all(16),
                //   // color: Colors.grey,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const Text(
                //             'В рассрочку',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w600, fontSize: 14),
                //           ),
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width *
                //                 0.585, // 229,
                //             height: 32,
                //             child: ListView.builder(
                //               itemCount: textInst.length,
                //               shrinkWrap: true,
                //               physics: const NeverScrollableScrollPhysics(),
                //               scrollDirection: Axis.horizontal,
                //               itemBuilder: (context, index) {
                //                 return InkWell(
                //                   onTap: () {
                //                     if (index == 0) {
                //                       selectedIndexMonth = 3;
                //                     } else if (index == 1) {
                //                       selectedIndexMonth = 6;
                //                     } else if (index == 2) {
                //                       selectedIndexMonth = 12;
                //                     } else if (index == 3) {
                //                       selectedIndexMonth = 24;
                //                     } else {
                //                       selectedIndexMonth = 3;
                //                     }

                //                     setState(() {
                //                       selectedIndex2 = index;
                //                     });
                //                   },
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(right: 4.0),
                //                     child: Container(
                //                       width: 54,
                //                       decoration: BoxDecoration(
                //                         color: selectedIndex2 == index
                //                             ? const Color(0xFFFFD54F)
                //                             : Colors.white,
                //                         borderRadius: BorderRadius.circular(8),
                //                       ),
                //                       padding: const EdgeInsets.only(
                //                         top: 8,
                //                         bottom: 8,
                //                       ),
                //                       child: Text(
                //                         textInst[index],
                //                         textAlign: TextAlign.center,
                //                         style: const TextStyle(
                //                             color: AppColors.kGray900,
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.w400),
                //                       ),
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Container(
                //             width: 55,
                //             padding: const EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //               color: const Color(0xFFFFD54F),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: Alignment.center,
                //             child: Text(
                //               '${widget.product.price!.toInt() ~/ selectedIndexMonth!.toInt()}',
                //               style: const TextStyle(
                //                   color: AppColors.kGray900,
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //           ),
                //           Text(
                //             ' x$selectedIndexMonth',
                //             style: const TextStyle(
                //                 fontSize: 14, fontWeight: FontWeight.w400),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 8),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),

          // const SizedBox(height: 8),
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   color: Colors.white,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text(
          //             'В рассрочку',
          //             style:
          //                 TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          //           ),
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width * 0.585, // 229,
          //             height: 32,
          //             child: ListView.builder(
          //               itemCount: textInst.length,
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               scrollDirection: Axis.horizontal,
          //               itemBuilder: (context, index) {
          //                 return InkWell(
          //                   onTap: () {
          //                     if (index == 0) {
          //                       selectedIndexMonth = 3;
          //                     } else if (index == 1) {
          //                       selectedIndexMonth = 6;
          //                     } else if (index == 2) {
          //                       selectedIndexMonth = 12;
          //                     } else if (index == 3) {
          //                       selectedIndexMonth = 24;
          //                     } else {
          //                       selectedIndexMonth = 3;
          //                     }

          //                     setState(() {
          //                       selectedIndex2 = index;
          //                     });
          //                   },
          //                   child: Padding(
          //                     padding: const EdgeInsets.only(right: 4.0),
          //                     child: Container(
          //                       width: 54,
          //                       decoration: BoxDecoration(
          //                         color: selectedIndex2 == index
          //                             ? Color(0xFFFFD54F)
          //                             : Colors.white,
          //                         borderRadius: BorderRadius.circular(8),
          //                       ),
          //                       padding: const EdgeInsets.only(
          //                         top: 8,
          //                         bottom: 8,
          //                       ),
          //                       child: Text(
          //                         textInst[index],
          //                         textAlign: TextAlign.center,
          //                         style: const TextStyle(
          //                             color: AppColors.kGray900,
          //                             fontSize: 14,
          //                             fontWeight: FontWeight.w400),
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Container(
          //             width: 55,
          //             padding: const EdgeInsets.all(8),
          //             decoration: BoxDecoration(
          //               color: Color(0xFFFFD54F),
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             alignment: Alignment.center,
          //             child: Text(
          //               '${(widget.product.price!.toInt() / selectedIndexMonth!.toInt()).toInt()}',
          //               style: const TextStyle(
          //                   color: AppColors.kGray900,
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           Text(
          //             ' x$selectedIndexMonth',
          //             style: const TextStyle(
          //                 fontSize: 14, fontWeight: FontWeight.w400),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          //const SizedBox(height: 8),
          // Container(
          //   padding: const EdgeInsets.only(top: 16, left: 16),
          //   color: Colors.white,
          //   alignment: Alignment.centerLeft,
          //   child: const Text(
          //     'Продавцы',
          //     style: TextStyle(
          //       color: AppColors.kGray900,
          //       fontWeight: FontWeight.w700,
          //       fontSize: 16,
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'В рассрочку',
                  style: AppTextStyles.size14Weight400.copyWith(color: Color(0xff636366)),
                ),
                SizedBox(width: 23),
                Flexible(child: SizedBox(width: 300, height: 28, child: MonthSelector())),
                //   height: 28,
                //   child: ListView.builder(
                //     itemCount: textInst.length,
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       BorderRadius radius = BorderRadius.zero;
                //       if (index == 0) {
                //         radius = const BorderRadius.only(
                //           topLeft: Radius.circular(10),
                //           bottomLeft: Radius.circular(10),
                //         );
                //       } else if (index == textInst.length - 1) {
                //         radius = const BorderRadius.only(
                //           topRight: Radius.circular(10),
                //           bottomRight: Radius.circular(10),
                //         );
                //       }
                //       return InkWell(
                //         onTap: () {
                //           if (index == 0) {
                //             selectedIndexMonth = 3;
                //           } else if (index == 1) {
                //             selectedIndexMonth = 6;
                //           } else if (index == 2) {
                //             selectedIndexMonth = 9;
                //           } else if (index == 3) {
                //             selectedIndexMonth = 12;
                //           } else {
                //             selectedIndexMonth = 3;
                //           }

                //           setState(() {
                //             selectedIndex2 = index;
                //           });
                //         },
                //         child: Container(
                //           width: 61,
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             color: selectedIndex2 == index
                //                 ? AppColors.kYellowDark
                //                 : Colors.white,
                //             borderRadius: radius,
                //             border: Border(
                //               top: BorderSide(color: AppColors.kYellowDark),
                //               bottom: BorderSide(color: AppColors.kYellowDark),
                //               left: index == 0
                //                   ? BorderSide(color: AppColors.kYellowDark)
                //                   : BorderSide.none,
                //               right: BorderSide(color: AppColors.kYellowDark),
                //             ),
                //           ),
                //           child: Text(
                //             textInst[index],
                //             style: AppTextStyles.size14w,
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 4),

            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(12),
            ),

            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.product.shops!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    context.router.push(DetailStoreRoute(product: widget.product));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.product.shops![index].shop!.name}',
                                  style: AppTextStyles.size18Weight600,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.icons.sellerIcon.path,
                                      color: Color(0xff34C759),
                                      height: 12,
                                      width: 12,
                                    ),
                                    SizedBox(width: 4.5),
                                    Text(
                                      'Официальный партнер',
                                      style: AppTextStyles.size11Weight500.copyWith(
                                        color: Color(0xff34C759),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.product.shops![index].inBasket == false) {
                                  showBasketBottomSheetOptions(
                                    context,
                                    '${widget.product.shops![index].shop?.name ?? ''}',
                                    optom,
                                    widget.product,
                                    (int callBackCount, int callBackPrice, bool callBackOptom) {
                                      if (widget.product.shops![index].product_count == 0 &&
                                          widget.product.shops![index].pre_order == 1) {
                                        if (isvisible == false &&
                                            widget.product.shops![index].inBasket == false) {
                                          showCupertinoModalPopup<void>(
                                            context: context,
                                            builder: (context) => PreOrderDialog(
                                              onYesTap: () {
                                                final filters = context.read<FilterProvider>();

                                                Navigator.pop(context);
                                                if (isvisible == false &&
                                                    widget.product.shops![index].inBasket ==
                                                        false) {
                                                  BlocProvider.of<BasketCubit>(context).basketAdd(
                                                    widget.product.shops![index].productId,
                                                    callBackCount,
                                                    callBackPrice,
                                                    sizeValue,
                                                    colorValue,
                                                    isOptom: callBackOptom,
                                                  );
                                                  setState(() {
                                                    isvisible = true;
                                                  });
                                                  BlocProvider.of<ProductCubit>(
                                                    context,
                                                  ).products(filters);
                                                } else {
                                                  context.router.replaceAll([
                                                    const LauncherRoute(children: [BasketRoute()]),
                                                  ]);
                                                }
                                              },
                                            ),
                                          );
                                        } else {
                                          context.router.pushAndPopUntil(
                                            const LauncherRoute(children: [BasketRoute()]),
                                            predicate: (route) => false,
                                          );
                                        }

                                        return;
                                      }

                                      BlocProvider.of<BasketCubit>(context).basketAdd(
                                        widget.product.shops![index].productId,
                                        callBackCount,
                                        callBackPrice,
                                        sizeValue,
                                        colorValue,
                                        isOptom: callBackOptom,
                                      );
                                      setState(() {
                                        isvisible = true;
                                      });
                                      final filters = context.read<FilterProvider>();

                                      BlocProvider.of<ProductCubit>(context).products(filters);
                                    },
                                  );
                                } else {
                                  log('pushReplaceAll', name: 'Detail Card Product Page');
                                  context.router.replaceAll([
                                    const LauncherRoute(children: [BasketRoute()]),
                                  ]);
                                }

                                // BlocProvider.of<BasketCubit>(context)
                                //     .basketAdd(
                                //         widget
                                //             .product.shops![index].productId,
                                //         '1',
                                //         0,
                                //         sizeValue,
                                //         colorValue);
                                // setState(() {
                                //   isvisible = true;
                                // });
                              },
                              child: Container(
                                height: 40,
                                width: 129,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.mainBackgroundPurpleColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'Выбрать',
                                  style: AppTextStyles.size16Weight600.copyWith(
                                    color: AppColors.mainPurpleColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 4.5),
                        Row(
                          children: [
                            Text('3.0 ', style: AppTextStyles.size13Weight400),
                            RatingBar(
                              ignoreGestures: true,
                              initialRating: 3,
                              unratedColor: const Color(0x30F11712),
                              itemSize: 14,
                              itemPadding: const EdgeInsets.only(left: 3.2),
                              ratingWidget: RatingWidget(
                                full: SizedBox(
                                  width: 12.8,
                                  height: 12.8,
                                  child: Image.asset(
                                    Assets.icons.defaultStarIcon.path,
                                    fit: BoxFit.contain,
                                    color: Color(0xffFFC107),
                                  ),
                                ),
                                half: SizedBox(
                                  width: 12.8,
                                  height: 12.8,
                                  child: Image.asset(
                                    Assets.icons.defaultStarIcon.path,
                                    fit: BoxFit.contain,
                                    color: Color(0xffAEAEB2),
                                  ),
                                ),
                                empty: SizedBox(
                                  width: 12.8,
                                  height: 12.8,
                                  child: Image.asset(
                                    Assets.icons.defaultStarIcon.path,
                                    fit: BoxFit.contain,
                                    color: Color(0xffAEAEB2),
                                  ),
                                ),
                              ),
                              onRatingUpdate: (double value) {},
                            ),
                            SizedBox(width: 2.4),
                            Text(
                              ' ${widget.product.shop!.id} отзыва',
                              style: AppTextStyles.size13Weight400.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${formatPrice((widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100).toString()} ₽',
                              style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 17,
                                letterSpacing: -1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 22,
                                  // width: 48,
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.kYellowDark,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${((widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100.toInt() / 3).round()} ₽',
                                    style: const TextStyle(
                                      color: AppColors.kLightBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text('х3 мес', style: AppTextStyles.size13Weight400),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        (widget.product.shops?[index].shop?.code != null ||
                                widget.product.fulfillment == 'realFBS')
                            ? SizedBox(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: Image.asset(
                                            Assets.icons.busIcon.path,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Доставка:',
                                          style: AppTextStyles.size14Weight400.copyWith(
                                            color: Color(0xff8E8E93),
                                          ),
                                        ),
                                      ],
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '${widget.product.shops![index].deliveryDay ?? 'Неизвестно'} дня ,',
                                        style: AppTextStyles.size14Weight400,
                                        children: <TextSpan>[
                                          TextSpan(
                                            style: AppTextStyles.size14Weight400,
                                            text:
                                                '${widget.product.shops![index].deliveryPrice ?? 'Неизвестно'} руб',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: Image.asset(
                                            Assets.icons.busIcon.path,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Доставка:',
                                          style: AppTextStyles.size14Weight400.copyWith(
                                            color: Color(0xff8E8E93),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Неивестно',
                                      style: TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                        // Container(
                        //   padding: const EdgeInsets.only(top: 12),
                        //   width: 130,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Text(
                        //         'Безрпасная сделка',
                        //         style: TextStyle(
                        //             fontSize: 12,
                        //             color: AppColors.kPrimaryColor,
                        //             fontWeight: FontWeight.w400),
                        //       ),
                        //       SvgPicture.asset(
                        //         'assets/icons/carbon_security.svg',
                        //       )
                        //     ],
                        //   ),
                        // )
                        SizedBox(height: 5),
                        SizedBox(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: Image.asset(
                                      Assets.icons.optomIcon.path,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Оптовая продажа:',
                                    style: AppTextStyles.size14Weight400.copyWith(
                                      color: Color(0xff8E8E93),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.product.bloc?.length != 0 ? 'Доступна' : 'Не доступна',
                                style: AppTextStyles.size14Weight400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),

          // Вверху файла, если используешь рейтинг
          // import 'package:flutter_rating_bar/flutter_rating_bar.dart';

          /// ... где-то внутри build:

          // Хедер с вкладками
          Container(
            height: 62,
            margin: const EdgeInsets.only(top: 8, left: 0, right: 0),
            padding: EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: List.generate(texts.length, (index) {
                final selected = textBloc == texts[index];
                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            textBloc = selected ? '' : texts[index];
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOut,
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected ? AppColors.mainPurpleColor : const Color(0xffEAECED),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            texts[index],
                            maxLines: 1, // одна строка
                            softWrap: false, // без переноса
                            style: AppTextStyles.size13Weight400.copyWith(
                              color: selected ? AppColors.kWhite : const Color(0xff636366),
                              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // ===== ХАРАКТЕРИСТИКИ =====
          if (widget.product.characteristics != null && textBloc == 'Характеристики')
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Builder(
                      builder: (_) {
                        final items = widget.product.characteristics ?? [];
                        final preview = items.take(5).toList();
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: preview.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (_, i) {
                            final it = preview[i];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${it.name}:',
                                  style: AppTextStyles.size14Weight400.copyWith(
                                    color: Color(0xff8E8E93),
                                  ),
                                ),
                                Text(' ${it.value}', style: AppTextStyles.size14Weight400),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if ((widget.product.characteristics?.length ?? 0) > 5)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SpecificationsPage(product: widget.product),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios, size: 14),
                        label: const Text(
                          'Подробнее',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: AppColors.kPrimaryColor,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                ],
              ),
            )
          else
            const SizedBox.shrink(),

          // ===== ОПИСАНИЕ =====
          if (widget.product.description != null && textBloc == 'Описание')
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Text(
                      '${widget.product.description}',
                      softWrap: true,
                      maxLines: showText ? null : 4,
                      overflow: showText ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.kLightBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, thickness: 0.33, color: Color(0xffEAECED)),
                  TextButton(
                    onPressed: () => setState(() => showText = !showText),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      foregroundColor: AppColors.mainPurpleColor,
                    ),
                    child: Text(
                      showText ? 'Скрыть' : 'Читать полностью',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox.shrink(),

          // ===== ОТЗЫВЫ =====
          if (textBloc == 'Отзыв')
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
              child: Column(
                children: [
                  Container(
                    height: 73,
                    alignment: Alignment.topCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // НЕ spaceBetween, сами контролируем отступ
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(widget.product.rating ?? 0).toDouble()}',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${widget.product.count ?? 0} отзывов',
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: Color(0xffAEAEB2),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 254,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (row) {
                              final stars = 5 - row;
                              final total = (widget.product.count ?? 0).clamp(0, 999999);
                              final value = (widget.product.review?[(stars - 1)] ?? 0);
                              final double barWidth = total > 0 ? 160.0 * (value / total) : 0.0;

                              return Container(
                                height: 12,
                                margin: EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: stars.toDouble(),
                                      itemCount: 5,
                                      itemSize: 10,
                                      unratedColor: const Color(0xffD1D1D6),
                                      itemPadding: EdgeInsets.only(left: 2.5),
                                      itemBuilder: (context, _) => SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: Image.asset(
                                          Assets.icons.defaultStarIcon.path,
                                          color: const Color(0xffFFBE00),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 4,
                                          width: 160,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffD1D1D6),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                        ),
                                        if (barWidth > 0)
                                          Container(
                                            height: 4,
                                            width: barWidth,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffFFBE00),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      '${value}',
                                      style: AppTextStyles.size11Weight500.copyWith(
                                        color: Color(0xff8E8E93),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // список отзывов из блока
                  BlocConsumer<reviewProductCubit.ReviewCubit, reviewProductState.ReviewState>(
                    listener: (_, __) {},
                    builder: (context, state) {
                      if (state is reviewProductState.ErrorState) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
                          ),
                        );
                      }
                      if (state is reviewProductState.LoadingState) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.indigoAccent),
                          ),
                        );
                      }
                      if (state is reviewProductState.LoadedState) {
                        final reviews = state.reviewModel;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviews.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 16, thickness: 0.35, color: Color(0xffC7C7CC)),
                          itemBuilder: (_, index) {
                            final r = reviews[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16),
                                Text(
                                  '${r.user?.first_name ?? 'Пользователь'} ${r.user?.last_name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.size14Weight600,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: (r.rating ?? 0).toDouble(),
                                      minRating: 1,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      unratedColor: Color(0xffD1D1D6),
                                      itemPadding: const EdgeInsets.only(right: 3.4),
                                      itemBuilder: (context, _) => SizedBox(
                                        height: 12,
                                        width: 12,
                                        child: Image.asset(
                                          Assets.icons.defaultStarIcon.path,
                                          color: Color(0xffFFBE00),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      onRatingUpdate: (_) {},
                                    ),
                                    Text(
                                      '${r.date ?? ''}',
                                      style: AppTextStyles.size14Weight400.copyWith(
                                        color: Color(0xffAEAEB2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  '${r.text ?? ''}',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                (r.images ?? []).isNotEmpty
                                    ? Container(
                                        height: 64,
                                        margin: EdgeInsets.only(top: 8),
                                        child: ListView.builder(
                                          itemCount: r.images?.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final image = r.images?[index];
                                            return Container(
                                              height: 64,
                                              width: 64,
                                              margin: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffF7F7F7),
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  width: 1,
                                                  color: const Color(0xffD9D9D9),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  "https://lunamarket.ru/storage/${image}",
                                                  fit: BoxFit.cover,
                                                  height: 64,
                                                  width: 64,
                                                  errorBuilder: (context, error, stackTrace) =>
                                                      const ErrorImageWidget(height: 64, width: 64),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(height: 16),
                              ],
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            )
          else
            const SizedBox.shrink(),

          SizedBox(height: 16),

          // textBloc == '111'
          // ?
          Container(
            height: 190,
            padding: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: textDescrp.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    final filters = context.read<FilterProvider>();

                    final CatsModel catsModel = await BlocProvider.of<CatsCubit>(
                      context,
                    ).catById(widget.product.catId.toString());

                    if (index == 0) {
                      context.router.push(
                        ProductsRoute(cats: catsModel, shopId: widget.product.shop!.id.toString()),
                      );
                      filters.setShops([widget.product.shop!.id ?? 0]);

                      await BlocProvider.of<ProductCubit>(context).products(filters);
                    } else if (index == 1) {
                      if (widget.product.brandId != null) {
                        context.router.push(
                          ProductsRoute(cats: catsModel, brandId: widget.product.brandId),
                        );

                        filters.setBrands([widget.product.brandId!]);

                        await BlocProvider.of<ProductCubit>(context).products(filters);
                      } else {
                        AppSnackBar.show(
                          context,
                          'У товара не указан бренд',
                          type: AppSnackType.error,
                        );
                      }
                    } else if (index == 2) {
                      context.router.push(ProductsRoute(cats: catsModel));

                      filters.setCategory(widget.product.catId ?? 0);
                      await BlocProvider.of<ProductCubit>(context).products(filters);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.kMainPurpleMuted10b,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            textDescrp[index],
                            maxLines: 2,
                            style: AppTextStyles.size16Weight500,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                          width: 20,
                          child: Image.asset(
                            Assets.icons.defaultArrowForwardIcon.path,
                            color: AppColors.mainPurpleColor,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Container(
            margin: const EdgeInsets.all(16),
            color: AppColors.kBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('С этим товаром покупают', style: AppTextStyles.size18Weight700),
                const SizedBox(height: 8),
                BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ErrorState) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                        ),
                      );
                    }
                    if (state is LoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.indigoAccent),
                      );
                    }

                    if (state is LoadedState) {
                      return state.productModel.isEmpty
                          ? const Center(child: Text('Товары не найдены'))
                          : Container(
                              height: 275,
                              decoration: BoxDecoration(color: AppColors.kBackgroundColor),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.productModel.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => context.router.push(
                                      DetailCardProductRoute(product: state.productModel[index]),
                                    ),
                                    child: ProductBuyWithCard(product: state.productModel[index]),
                                  );
                                },
                              ),
                            );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.indigoAccent),
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
            color: AppColors.kBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Похожие товары', style: AppTextStyles.size18Weight700),
                const SizedBox(height: 8),
                BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ErrorState) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                        ),
                      );
                    }
                    if (state is LoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.indigoAccent),
                      );
                    }

                    if (state is LoadedState) {
                      return state.productModel.isEmpty
                          ? const Center(child: Text('Товары не найдены'))
                          : SizedBox(
                              width: 358,
                              // height: 558,
                              height: state.productModel.length >= 4 ? 558 : 291,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: state.productModel.length >= 4 ? 2 : 1,
                                  childAspectRatio: 1.50,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 2,
                                ),
                                itemCount: state.productModel.length <= 10
                                    ? state.productModel.length
                                    : 10,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () => context.router.push(
                                      DetailCardProductRoute(product: state.productModel[index]),
                                    ),
                                    child: ProductWatchingCard(product: state.productModel[index]),
                                  );
                                },
                              ),
                            );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.indigoAccent),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 36),
          child: InkWell(
            onTap: () {
              if (isvisible == false && widget.product.inBasket == false) {
                showBasketBottomSheetOptions(
                  context,
                  '${widget.product.shop?.name}',
                  optom,
                  widget.product,
                  (int callBackCount, int callBackPrice, bool callBackOptom) {
                    if (widget.product.product_count == 0 && widget.product.pre_order == 1) {
                      if (isvisible == false && widget.product.inBasket == false) {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (context) => PreOrderDialog(
                            onYesTap: () {
                              final filters = context.read<FilterProvider>();

                              Navigator.pop(context);
                              if (isvisible == false && widget.product.inBasket == false) {
                                BlocProvider.of<BasketCubit>(context).basketAdd(
                                  widget.product.id.toString(),
                                  callBackCount,
                                  callBackPrice,
                                  sizeValue,
                                  colorValue,
                                  isOptom: callBackOptom,
                                );
                                setState(() {
                                  isvisible = true;
                                });
                                BlocProvider.of<ProductCubit>(context).products(filters);
                              } else {
                                context.router.replaceAll([
                                  const LauncherRoute(children: [BasketRoute()]),
                                ]);
                              }
                            },
                          ),
                        );
                      } else {
                        context.router.pushAndPopUntil(
                          const LauncherRoute(children: [BasketRoute()]),
                          predicate: (route) => false,
                        );
                      }

                      return;
                    }

                    BlocProvider.of<BasketCubit>(context).basketAdd(
                      widget.product.id.toString(),
                      callBackCount,
                      callBackPrice,
                      sizeValue,
                      colorValue,
                      isOptom: callBackOptom,
                    );
                    setState(() {
                      isvisible = true;
                    });
                    final filters = context.read<FilterProvider>();

                    BlocProvider.of<ProductCubit>(context).products(filters);
                  },
                );
              } else {
                log('pushReplaceAll', name: 'Detail Card Product Page');
                context.router.replaceAll([
                  const LauncherRoute(children: [BasketRoute()]),
                ]);
              }
            },
            child: Container(
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.mainPurpleColor,
              ),
              alignment: Alignment.center,
              child: (isvisible == false && widget.product.inBasket == false)
                  ? const Text(
                      'В корзину',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Перейти в корзину',
                          style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
                        ),
                        Text(
                          'Товар в корзине',
                          style: AppTextStyles.size13Weight400.copyWith(color: AppColors.kWhite),
                        ),
                      ],
                    ),
            ),
          ),

          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          // InkWell(
          //   onTap: () async {
          //     if (widget.product.product_count == 0 &&
          //         widget.product.pre_order == 1) {
          //       showCupertinoModalPopup<void>(
          //         context: context,
          //         builder: (context) => PreOrderDialog(
          //           onYesTap: () {
          //             Navigator.pop(context);
          //             Future.wait<void>([
          //               BlocProvider.of<BasketCubit>(context).basketAdd(
          //                   widget.product.id.toString(),
          //                   '1',
          //                   0,
          //                   sizeValue,
          //                   colorValue),
          //             ]);

          //             if (BlocProvider.of<BasketCubit>(context).state
          //                 is! LoadedState) {
          //               Future.wait<void>([
          //                 BlocProvider.of<BasketCubit>(context)
          //                     .basketShow('fbs'),
          //               ]);
          //             }

          //             Future.wait<void>([
          //               BlocProvider.of<ProductCubit>(context).products()
          //             ]);
          //             this.context.router.push(BasketOrderAddressRoute(
          //                   fulfillment: 'fbs',
          //                 ));
          //           },
          //         ),
          //       );
          //       return;
          //     }
          //     if (count == 0) {
          //       Future.wait<void>([
          //         BlocProvider.of<BasketCubit>(context).basketAdd(
          //             widget.product.id.toString(),
          //             '1',
          //             0,
          //             sizeValue,
          //             colorValue),
          //       ]);
          //     }

          //     if (BlocProvider.of<BasketCubit>(context).state
          //         is! LoadedState) {
          //       Future.wait<void>([
          //         BlocProvider.of<BasketCubit>(context).basketShow('fbs'),
          //       ]);
          //     }

          //     context.router.push(BasketOrderAddressRoute(
          //       fulfillment: 'fbs',
          //     ));

          //     await Future.wait<void>(
          //         [BlocProvider.of<ProductCubit>(context).products()]);

          //     // Navigator.popUntil(context, (route) => route.isFirst);
          //     // BlocProvider.of<NavigationCubit>(context)
          //     //     .getNavBarItem(const NavigationState.basket());
          //     // setState(() {
          //     //   isvisible = true;
          //     // });

          //     //    Get.to(() => BasketOrderPage(fbs: false));
          //   },
          //   child: Container(
          //       height: 46,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         color: AppColors.mainPurpleColor,
          //       ),
          //       width: MediaQuery.of(context).size.width * 0.440,
          //       padding: const EdgeInsets.only(
          //           left: 15, right: 15, top: 15, bottom: 15),
          //       child: const Text(
          //         'Оформить сейчас',
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.w400,
          //             fontSize: 14),
          //         textAlign: TextAlign.center,
          //       )),
          // ),
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget sizeTile(int index) {
    final raw = widget.product.size![index];
    final label = labelOf(raw);
    final number = numberOf(raw);

    final disabled = outOfStock.contains(label) || outOfStock.contains(raw);
    final selected = !disabled && selectedIndex4 == index;

    return InkWell(
      onTap: disabled
          ? null
          : () {
              if (selectedIndex4 != index) {
                sizeValue = raw;
                setState(() => selectedIndex4 = index);
              } else {
                sizeValue = '';
                setState(() => selectedIndex4 = -1);
              }
            },
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          height: 54,
          width: 54,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: selected
                  ? AppColors.mainPurpleColor
                  : (disabled ? const Color(0xffECECEC) : const Color(0xffEAECED)),
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // контент
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.size14Weight400.copyWith(
                      color: disabled ? const Color(0xffBDBDBD) : null,
                    ),
                  ),
                  if (number.isNotEmpty)
                    Text(
                      number,
                      maxLines: 1,
                      style: AppTextStyles.size14Weight400.copyWith(
                        color: disabled ? const Color(0xffC2C2C2) : const Color(0xff636366),
                      ),
                    ),
                ],
              ),
              // диагональная линия для "нет в наличии"
              if (disabled) CustomPaint(painter: _DiagonalSlashPainter()),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiagonalSlashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xffE0E0E0)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.82),
      Offset(size.width * 0.82, size.height * 0.18),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SelectColor extends StatefulWidget {
  // final Function ontileSelected;
  const SelectColor({
    // required this.ontileSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  late Color color;
  @override
  void initState() {
    super.initState();

    color = Colors.transparent;
  }

  bool _isSelected = false;
  set isSelected(bool value) {
    _isSelected = value;
    print("set is selected to $_isSelected");
  }

  void changeSelection() {
    setState(() {
      // _myKey = widget.key;
      _isSelected = !_isSelected;
      if (_isSelected) {
        color = Colors.lightBlueAccent;
      } else {
        color = Colors.transparent;
      }
    });
  }

  void deselect() {
    setState(() {
      isSelected = false;
      color = Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        changeSelection();
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: Image.asset('assets/images/black_wireles.png', height: 80),
        ),
      ),
    );
  }
}
