import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_basket_bottom_sheet_widget.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/profit_cubit.dart'
    as profitCubit;
import 'package:haji_market/src/feature/drawer/bloc/profit_state.dart'
    as profitState;
import 'package:haji_market/src/feature/drawer/presentation/widgets/pre_order_dialog.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/review_cubit.dart'
    as reviewProductCubit;
import 'package:haji_market/src/feature/drawer/bloc/review_state.dart'
    as reviewProductState;
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/product_imags_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/specifications_page.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:share_plus/share_plus.dart';
import '../../../home/presentation/widgets/product_mb_interesting_card.dart';
import '../../../home/presentation/widgets/product_watching_card.dart';
import '../../../favorite/bloc/favorite_cubit.dart';
import '../../../product/cubit/product_state.dart';

@RoutePage()
class DetailCardProductPage extends StatefulWidget {
  final ProductModel product;
  const DetailCardProductPage({required this.product, Key? key})
      : super(key: key);

  @override
  State<DetailCardProductPage> createState() => _DetailCardProductPageState();
}

class _DetailCardProductPageState extends State<DetailCardProductPage> {
  int count = 0;
  int optom = 2;

  bool isvisible = false;

  int? selectedIndex = -1;
  int? selectedIndex2 = 0;
  int? selectedIndexMonth = 3;

  int? selectedIndex3 = -1;
  int? selectedIndex4 = -1;

  double procentPrice = 0;
  int compoundPrice = 0;

  bool showText = false;

  //bool isvisible = false;
  bool inFavorite = false;
  List textDescrp = [];
  List textInst = [
    '3 мес',
    '6 мес',
    '9 мес',
    '12 мес',
  ];

  List texts = [
    'Описание',
    'Характеристики',
    'Отзыв',
  ];

  String textBloc = '';

  List bloc = [
    10,
    20,
    30,
    40,
  ];
  String? sizeValue;
  String? colorValue;
  List size = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

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

  @override
  void initState() {
    textDescrp = [
      'Все товары ${widget.product.shop!.name}',
      'Все товары из брэнда  ${widget.product.brandName ?? ''}',
      'Все товары из категории  ${widget.product.catName}',
    ];
    isvisible = widget.product.inBasket ?? false;
    inFavorite = widget.product.inFavorite ?? false;

    productNames = "$kDeepLinkUrl/?product_id\u003d${widget.product.id}";
    super.initState();

    compoundPrice =
        (widget.product.price!.toInt() - widget.product.compound!.toInt());

    BlocProvider.of<reviewProductCubit.ReviewCubit>(context)
        .reviews(widget.product.id.toString());
    BlocProvider.of<profitCubit.ProfitCubit>(context)
        .profit(widget.product.id.toString());

    if (widget.product.video != null) {
      _controller = VideoPlayerController.network(
          // 'https://lunamarket.ru/storage/${widget.product.path?.first ?? ''}'
          'https://lunamarket.ru/storage/${widget.product.video}')
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
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kLightBlackColor,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: GestureDetector(
                  onTap: () async {
                    await Share.share('$productNames');
                  },
                  child: SvgPicture.asset(
                    Assets.icons.share.path,
                    color: Colors.black,
                  )))
        ],
      ),
      body: ListView(
        cacheExtent: 10000,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 405,
            child: Stack(
              children: [
                Container(
                  height: 405,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    itemCount: (widget.product.path?.length ?? 0) +
                        (widget.product.video != null ? 1 : 0),
                    onPageChanged: (value) {
                      imageIndex = value;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      final isVideo = widget.product.video != null &&
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
                              Container(
                                height: 358,
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: VideoProgressIndicator(
                                  _controller!,
                                  allowScrubbing: true,
                                ),
                              ),
                              if (icon)
                                Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/play_tape.svg',
                                    color: Color.fromRGBO(29, 196, 207, 1),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }

                      // Фото
                      return Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "https://lunamarket.ru/storage/${widget.product.path![index]}",
                            fit: BoxFit.cover,
                            height: 283,
                            width: 345,
                            errorBuilder: (context, error, stackTrace) =>
                                const ErrorImageWidget(
                              height: 283,
                              width: 345,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 20,
                  child: Container(
                    width: 52,
                    height: 22,
                    decoration: BoxDecoration(
                        color: AppColors.kYellowDark,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text('0·0·12',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.statisticsTextStyle),
                  ),
                ),
                widget.product.point != 0
                    ? Positioned(
                        top: 40,
                        left: 20,
                        child: Container(
                          width: 52,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-0.6,
                                    -1), // приблизительное направление 128.49°
                                end: Alignment(1, 1),
                                colors: [
                                  Color(0xFF7D2DFF),
                                  Color(0xFF41DDFF),
                                ],
                                stops: [
                                  0.2685,
                                  1.0
                                ], // соответствуют 26.85% и 100%
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            '${widget.product.point ?? 0}% Б',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.statisticsTextStyle
                                .copyWith(color: AppColors.kWhite),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: GestureDetector(
                    onTap: (() {
                      Get.to(() => ProductImages(
                            images: widget.product.path,
                            video: widget.product.video,
                          ));
                    }),
                    child: Image.asset(
                      Assets.icons.fullscreenPng.path,
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(16)),
            //  width: 12,
            //  alignment: Alignment.r,
            //     margin: const EdgeInsets.only(
            // left: 154.0, right: 20, top: 260, bottom: 4),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                (widget.product.path?.length ?? 0) +
                    (widget.product.video != null ? 1 : 0),
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
                        color: imageIndex == index
                            ? AppColors.kGray400
                            : AppColors.kGray2,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
            )),
          ),

          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 14),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
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
                              style: const TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ),
                          Text(
                            '${formatPrice(widget.product.price!)} ₽ ',
                            style: const TextStyle(
                              color: AppColors.kGray300,
                              letterSpacing: -1,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.kGray300,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '${formatPrice(widget.product.price!)} ₽ ',
                        style: const TextStyle(
                          color: AppColors.kGray900,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
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
                        style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 0,
                            color: AppColors.kGray900,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          final favorite =
                              BlocProvider.of<FavoriteCubit>(context);
                          await favorite.favorite(widget.product.id.toString());
                          setState(() {
                            inFavorite = !inFavorite;
                          });
                          BlocProvider.of<ProductCubit>(context).products();
                        },
                        child: SvgPicture.asset(
                          inFavorite != true
                              ? Assets.icons.favoriteProductShow.path
                              : Assets.icons.heartFill.path,
                          color: Colors.red,
                        ))
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
                      initialRating:
                          double.parse(widget.product.rating.toString()),
                      unratedColor: const Color(0x30F11712),
                      itemSize: 12,
                      // itemPadding:
                      // const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Color(0xFFFFD54F),
                        ),
                        half: const Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                        empty: const Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    Row(
                      children: [
                        Text(
                          'Код товара: ',
                          style: const TextStyle(
                            color: AppColors.kGray300,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.product.id.toString().padLeft(10, '0'),
                          style: const TextStyle(
                            color: AppColors.kLightBlackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold, // жирный текст
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(),
                if ((widget.product.size ?? []).isNotEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Выберите Размер',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        // width:
                        //     MediaQuery.of(context).size.width, // 229,
                        height: 28,
                        child: ListView.builder(
                          itemCount: widget.product.size?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex4 = index;
                                  sizeValue = widget.product.size![index];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Container(
                                  width: 54,
                                  decoration: BoxDecoration(
                                    color: selectedIndex4 == index
                                        ? Colors.black
                                        : const Color.fromRGBO(
                                            235, 237, 240, 1),
                                    borderRadius: BorderRadius.circular(8),
                                    // border: Border.all(
                                    //   width: 1,
                                    //   color: selectedIndex3 != index
                                    //       ? AppColors.kPrimaryColor
                                    //       : Colors.white,
                                    // ),
                                  ),
                                  // padding: const EdgeInsets.only(
                                  //   top: 8,
                                  //   bottom: 8,
                                  // ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.product.size![index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: selectedIndex4 == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                if ((widget.product.color ?? []).isNotEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Цвет: ${widget.product.color!.first}',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product.color!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                if (selectedIndex != index) {
                                  colorValue = widget.product.color![index];
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
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 54,
                                  width: 54,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(AppColors.getColorFromHex(
                                          widget.product.color![index])),
                                      borderRadius: BorderRadius.circular(8),
                                      border: selectedIndex == index
                                          ? Border.all(
                                              color: AppColors.mainPurpleColor,
                                              width: 2)
                                          : Border.all(color: Colors.white)),

                                  // child: Image.asset(
                                  //   'assets/images/black_wireles.png',
                                  //   height: 80,
                                  // ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
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
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'В рассрочку',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.kGray300),
                ),
                SizedBox(
                  height: 28,
                  child: ListView.builder(
                    itemCount: textInst.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      BorderRadius radius = BorderRadius.zero;
                      if (index == 0) {
                        radius = const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        );
                      } else if (index == textInst.length - 1) {
                        radius = const BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            selectedIndexMonth = 3;
                          } else if (index == 1) {
                            selectedIndexMonth = 6;
                          } else if (index == 2) {
                            selectedIndexMonth = 9;
                          } else if (index == 3) {
                            selectedIndexMonth = 12;
                          } else {
                            selectedIndexMonth = 3;
                          }

                          setState(() {
                            selectedIndex2 = index;
                          });
                        },
                        child: Container(
                          width: 54,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selectedIndex2 == index
                                ? AppColors.kYellowDark
                                : Colors.white,
                            borderRadius: radius,
                            border: Border(
                              top: BorderSide(color: AppColors.kYellowDark),
                              bottom: BorderSide(color: AppColors.kYellowDark),
                              left: index == 0
                                  ? BorderSide(color: AppColors.kYellowDark)
                                  : BorderSide.none,
                              right: BorderSide(color: AppColors.kYellowDark),
                            ),
                          ),
                          child: Text(
                            textInst[index],
                            style: AppTextStyles.categoryTextStyle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
              color: Colors.white,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.product.shops!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      context.router.push(
                          DetailStoreRoute(shop: widget.product.shops![index]));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => DetailStorePage(shop: widget.product.shops![index])),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.product.shops![index].shop!.name}',
                                style: const TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<BasketCubit>(context)
                                      .basketAdd(
                                          widget
                                              .product.shops![index].productId,
                                          '1',
                                          0,
                                          sizeValue,
                                          colorValue);
                                  setState(() {
                                    isvisible = true;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 129,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.mainBackgroundPurpleColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 16, right: 16),
                                  child: Text(
                                    'Выбрать',
                                    style: AppTextStyles.defButtonTextStyle
                                        .copyWith(
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.mainPurpleColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '3.0 ',
                                style: const TextStyle(
                                    color: AppColors.kLightBlackColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                              RatingBar(
                                ignoreGestures: true,
                                initialRating: 3,
                                unratedColor: const Color(0x30F11712),
                                itemSize: 14,
                                // itemPadding:
                                // const EdgeInsets.symmetric(horizontal: 4.0),
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFD54F),
                                  ),
                                  half: const Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                  empty: const Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                ),
                                onRatingUpdate: (double value) {},
                              ),
                              Text(
                                ' ${widget.product.shop!.id} отзыва',
                                style: const TextStyle(
                                    color: AppColors.kGray300,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${formatPrice((widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100).toString()} ₽',
                                style: const TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 17,
                                    letterSpacing: -1,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 22,
                                    // width: 48,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.kYellowDark,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${((widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100.toInt() / 3).round()} ₽',
                                      style: const TextStyle(
                                          color: AppColors.kLightBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    'х3 мес',
                                    style: TextStyle(
                                        color: AppColors.kLightBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          (widget.product.shops?[index].shop?.code != null ||
                                  widget.product.fulfillment == 'realFBS')
                              ? SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            Assets.icons.bus.path,
                                          ),
                                          SizedBox(width: 5),
                                          Text('Доставка:',
                                              style: TextStyle(
                                                  color: AppColors.kGray300,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              '${widget.product.shops![index].deliveryDay ?? 'Неизвестно'} дня ,',
                                          style: const TextStyle(
                                              color: AppColors.kGray900,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  '${widget.product.shops![index].deliveryPrice ?? 'Неизвестно'} руб',
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            Assets.icons.bus.path,
                                          ),
                                          SizedBox(width: 5),
                                          Text('Доставка:',
                                              style: TextStyle(
                                                  color: AppColors.kGray300,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      Text('Неивестно',
                                          style: TextStyle(
                                              color: AppColors.kGray900,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/bi_box-fill.svg',
                                      color: AppColors.kGray300,
                                      height: 14,
                                      width: 13,
                                    ),
                                    SizedBox(width: 5),
                                    Text('Оптовая продажа:',
                                        style: TextStyle(
                                            color: AppColors.kGray300,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                Text(
                                    widget.product.bloc?.length != 0
                                        ? 'Доступна'
                                        : 'Не доступна',
                                    style: TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
          // const SizedBox(
          //   height: 5,
          // ),

          Container(
            height: 56,
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (textBloc == texts[index]) {
                        textBloc = '';
                        setState(() {});
                        return;
                      }
                      textBloc = texts[index];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 26),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: textBloc == texts[index]
                              ? AppColors.mainPurpleColor
                              : AppColors.kGray200,
                          borderRadius: BorderRadius.circular(12)),
                      // width: MediaQuery.of(context).size.width / 3.2,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(
                        texts[index],
                        style: AppTextStyles.catalogTextStyle.copyWith(
                          color: textBloc == texts[index]
                              ? AppColors.kWhite
                              : AppColors.kGray1,
                        ),
                      ),
                    ),
                  );
                }),
          ),

          widget.product.characteristics != null && textBloc == 'Характеристики'
              ? Container(
                  // padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: (widget.product.characteristics?.length ??
                                      0) *
                                  20,
                              child: ListView.builder(
                                  itemCount:
                                      widget.product.characteristics?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      '${widget.product.characteristics![index].name}: ${widget.product.characteristics![index].value}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      // const Divider(
                      //   height: 0,
                      //   color: AppColors.kGray400,
                      // ),
                      (widget.product.characteristics?.length ?? 0) >= 5
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SpecificationsPage(
                                                product: widget.product)),
                                  );
                                  // SpecificationsPage
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Подробнее',
                                      style: TextStyle(
                                          color: AppColors.kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.kPrimaryColor,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                )
              : const SizedBox.shrink(),

          widget.product.description != null && textBloc == 'Описание'
              ? Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.product.description}',
                        softWrap: showText == false ? true : false,
                        maxLines: showText == false ? 4 : 40,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.kLightBlackColor,
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          showText = !showText;
                          setState(() {});
                        },
                        child: Text(
                          showText == false ? 'Читать полностью' : 'Скрыть',
                          style: TextStyle(
                              color: AppColors.mainPurpleColor, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),

          textBloc == 'Отзыв'
              ? Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${widget.product.rating?.toDouble()}",
                                  style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  '${widget.product.count} отзывы',
                                  style: const TextStyle(
                                      color: AppColors.kGray300,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Container(
                              width: 240,
                              height: 70,
                              margin: EdgeInsets.only(right: 20),
                              child: ListView.builder(
                                  itemCount: 5,
                                  // scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  reverse: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: index.toDouble() + 1,
                                          minRating: 1,
                                          itemSize: 13,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        SizedBox(width: 8),
                                        Stack(
                                          children: [
                                            Container(
                                                height: 4,
                                                width: 160,
                                                color: const Color(0xffe5f1ff)),
                                            widget.product.review?[index] != 0
                                                ? Container(
                                                    height: 4,
                                                    width: 186.0 /
                                                        widget.product.count!,
                                                    color:
                                                        const Color(0xffFFC107))
                                                : const SizedBox.shrink()
                                          ],
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      BlocConsumer<reviewProductCubit.ReviewCubit,
                              reviewProductState.ReviewState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is reviewProductState.ErrorState) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: const TextStyle(
                                      fontSize: 20.0, color: Colors.grey),
                                ),
                              );
                            }
                            if (state is reviewProductState.LoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.indigoAccent));
                            }

                            if (state is reviewProductState.LoadedState) {
                              return Container(
                                  height: state.reviewModel.isEmpty
                                      ? 20
                                      : (100 *
                                          state.reviewModel.length.toDouble()),
                                  padding: const EdgeInsets.all(16),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: state.reviewModel.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${state.reviewModel[index].user!.name}',
                                                style: const TextStyle(
                                                    color: AppColors.kGray900,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              RatingBar.builder(
                                                initialRating: state
                                                    .reviewModel[index].rating!
                                                    .toDouble(),
                                                minRating: 1,
                                                itemSize: 15,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                ignoreGestures: true,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (value) {
                                                  rating = value.toInt();
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${state.reviewModel[index].date}',
                                            style: const TextStyle(
                                                color: AppColors.kGray300,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '${state.reviewModel[index].text}',
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //   Flexible(
                                          //       child: Text(
                                          //           'The Dropbox HQ in San Francisco is one of the best designed & most comfortable offices I have ever witnessed. Great stuff! If you happen to visit SanFran, dont miss the chance to witness it yourself. ',style: TextStyle(color: Colors.black),))
                                          // ],
                                        ],
                                      );
                                    },
                                  ));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.indigoAccent));
                            }
                          }),
                    ],
                  ))
              : SizedBox.shrink(),

          SizedBox(height: 8),
          // textBloc == '111'
          // ?

          Container(
              height: 190,
              padding: EdgeInsets.only(top: 8),
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: textDescrp.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        List<int> selectedListSort = [];

                        selectedListSort.add(widget.product.shop!.id as int);

                        GetStorage()
                            .write('shopFilterId', selectedListSort.toString());
                        await BlocProvider.of<ProductCubit>(context).products();

                        context.router.push(ProductsRoute(
                          cats: CatsModel(id: 0, name: ''),
                          shopId: widget.product.shop!.id.toString(),
                        ));
                      } else if (index == 1) {
                        GetStorage().remove('brandFilterId');
                        List<int> selectedListSort = [];

                        selectedListSort.add(widget.product.brandId ?? 0);
                        GetStorage().write(
                            'brandFilterId', selectedListSort.toString());

                        await BlocProvider.of<ProductCubit>(context).products();

                        context.router.push(ProductsRoute(
                            cats: CatsModel(id: 0, name: ''),
                            brandId: widget.product.brandId));
                        // Get.to(() => ProductsPage(
                        //       cats: Cats(id: 0, name: ''),
                        //     ));
                      } else if (index == 2) {
                        GetStorage().write('CatId', widget.product.catId ?? 0);
                        GetStorage().write('catId', widget.product.catId ?? 0);

                        GetStorage().write(
                            'subCatFilterId',
                            [
                              widget.product.catId,
                            ].toString());
                        GetStorage().remove('shopFilterId');
                        await BlocProvider.of<ProductCubit>(context).products();

                        context.router.push(ProductsRoute(
                          cats: CatsModel(
                              id: widget.product.catId,
                              name: widget.product.catName),
                        ));
                        // Get.to(() => ProductsPage(
                        //       cats: Cats(id: 1, name: widget.product.catName),
                        //     ));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.mainBackgroundPurpleColor,
                          borderRadius: BorderRadius.circular(12)),
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
                              style: const TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.mainPurpleColor,
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Похожие товары',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<ProductCubit, ProductState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ErrorState) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.grey),
                          ),
                        );
                      }
                      if (state is LoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: Colors.indigoAccent));
                      }

                      if (state is LoadedState) {
                        return state.productModel.isEmpty
                            ? const Center(child: Text('Товары не найдены'))
                            : SizedBox(
                                height: 286,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.productModel.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => context.router.push(
                                          DetailCardProductRoute(
                                              product:
                                                  state.productModel[index])),
                                      child: ProductMbInterestingCard(
                                        product: state.productModel[index],
                                      ),
                                    );
                                  },
                                ));
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: Colors.indigoAccent));
                      }
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'С этим товаром покупают',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<ProductCubit, ProductState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ErrorState) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.grey),
                          ),
                        );
                      }
                      if (state is LoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: Colors.indigoAccent));
                      }

                      if (state is LoadedState) {
                        return state.productModel.isEmpty
                            ? const Center(child: Text('Товары не найдены'))
                            : SizedBox(
                                height:
                                    state.productModel.length >= 4 ? 608 : 302,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              state.productModel.length >= 4
                                                  ? 2
                                                  : 1,
                                          childAspectRatio: 1.6,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 2),
                                  itemCount: state.productModel.length <= 10
                                      ? state.productModel.length
                                      : 10,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () => context.router.push(
                                          DetailCardProductRoute(
                                              product:
                                                  state.productModel[index])),
                                      child: ProductWatchingCard(
                                        product: state.productModel[index],
                                      ),
                                    );
                                  },
                                ));
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: Colors.indigoAccent));
                      }
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 36),
        child: InkWell(
          onTap: () {
            // Navigator.pop(context);

            showBasketBottomSheetOptions(
                context, '${widget.product.shop?.name}', optom, widget.product,
                (int callBackCount, int callBackPrice, bool callBackOptom) {
              if (widget.product.product_count == 0 &&
                  widget.product.pre_order == 1) {
                if (isvisible == false && widget.product.inBasket == false) {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (context) => PreOrderDialog(
                      onYesTap: () {
                        Navigator.pop(context);
                        if (isvisible == false &&
                            widget.product.inBasket == false) {
                          BlocProvider.of<BasketCubit>(context).basketAdd(
                              widget.product.id.toString(),
                              callBackCount,
                              callBackPrice,
                              sizeValue,
                              colorValue,
                              isOptom: callBackOptom);
                          setState(() {
                            isvisible = true;
                          });
                          BlocProvider.of<ProductCubit>(context).products();
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

              if (isvisible == false && widget.product.inBasket == false) {
                BlocProvider.of<BasketCubit>(context).basketAdd(
                    widget.product.id.toString(),
                    callBackCount,
                    callBackPrice,
                    sizeValue,
                    colorValue,
                    isOptom: callBackOptom);
                setState(() {
                  isvisible = true;
                });
                BlocProvider.of<ProductCubit>(context).products();
              } else {
                log('pushReplaceAll', name: 'Detail Card Product Page');
                context.router.replaceAll([
                  const LauncherRoute(children: [BasketRoute()]),
                ]);
              }
            });
          },
          child: Container(
              height: 46,
              width: double.infinity,
              // width: MediaQuery.of(context).size.width * 0.490,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainPurpleColor,
              ),
              alignment: Alignment.center,
              child: (isvisible == false && widget.product.inBasket == false)
                  ? const Text(
                      'В корзину',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    )
                  : const Text(
                      'Товар в корзине',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    )),
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
    );
  }
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
              border: Border.all(color: Colors.blueAccent)),
          child: Image.asset(
            'assets/images/black_wireles.png',
            height: 80,
          ),
        ),
      ),
    );
  }
}
