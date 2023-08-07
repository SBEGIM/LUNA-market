import 'package:auto_route/auto_route.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import 'package:haji_market/features/drawer/data/bloc/profit_cubit.dart'
    as profitCubit;
import 'package:haji_market/features/drawer/data/bloc/profit_state.dart'
    as profitState;
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/basket_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/review_cubit.dart'
    as reviewProductCubit;
import 'package:haji_market/features/drawer/data/bloc/review_state.dart'
    as reviewProductState;
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/drawer/presentation/widgets/product_imags_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/specifications_page.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:share_plus/share_plus.dart';
import '../../../home/presentation/widgets/product_mb_interesting_card.dart';
import '../../../home/presentation/widgets/product_watching_card.dart';
import '../../data/bloc/favorite_cubit.dart';
import '../../data/bloc/product_cubit.dart';
import '../../data/bloc/product_state.dart';

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
  int optom = 0;
  bool isvisible = false;

  int? selectedIndex = -1;
  int? selectedIndex2 = 0;
  int? selectedIndexMonth = 3;

  int? selectedIndex3 = -1;
  int? selectedIndex4 = -1;

  double procentPrice = 0;
  int compoundPrice = 0;

  //bool isvisible = false;
  bool inFavorite = false;
  List textDescrp = [];
  List textInst = [
    '3 мес',
    '6 мес',
    '9 мес',
    '12 мес',
  ];

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

  TextEditingController _commentController = TextEditingController();
  VideoPlayerController? _controller;
  PageController controller = PageController();

  @override
  void initState() {
    textDescrp = [
      'Все товары ${widget.product.shop!.name}',
      'Все товары из брэнда  ${widget.product.brandName}',
      'Все товары из категории  ${widget.product.catName}',
    ];
    isvisible = widget.product.inBasket ?? false;
    inFavorite = widget.product.inFavorite ?? false;

    productNames =
        "http://lunamarket.ru/?product_id\u003d${widget.product!.id}";
    super.initState();

    compoundPrice =
        (widget.product.price!.toInt() - widget.product.compound!.toInt());

    BlocProvider.of<reviewProductCubit.ReviewCubit>(context)
        .reviews(widget.product.id.toString());
    BlocProvider.of<profitCubit.ProfitCubit>(context).profit();

    if (widget.product.video != null) {
      _controller = VideoPlayerController.network(
          // 'http://185.116.193.73/storage/${widget.product.path?.first ?? ''}'
          'http://185.116.193.73/storage/${widget.product.video}')
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
            color: AppColors.kPrimaryColor,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: GestureDetector(
                  onTap: () async {
                    await Share.share('${productNames}');
                  },
                  child: SvgPicture.asset('assets/icons/share.svg')))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
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
                      // inFavorite = state.tapeModel[index].inFavorite;
                      // inBasket = state.tapeModel[index].inBasket;
                      return imageIndex + 1 ==
                              ((widget.product.path?.length ?? 0) + 1)
                          ? GestureDetector(
                              onTap: () {
                                _controller!.value.isPlaying
                                    ? _controller!.pause()
                                    : _controller!.play();
                              },
                              child: Stack(children: [
                                Center(
                                  child: AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
                                    child: VideoPlayer(_controller!),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  child: VideoProgressIndicator(_controller!,
                                      allowScrubbing: true),
                                ),
                                icon
                                    ? Center(
                                        child: SvgPicture.asset(
                                        'assets/icons/play_tape.svg',
                                        color: const Color.fromRGBO(
                                            29, 196, 207, 1),
                                      ))
                                    : const SizedBox(),
                              ]),
                            )
                          : Container(
                              margin: const EdgeInsets.only(
                                  top: 24, left: 8, right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              //color: Colors.red,
                              child: Image.network(
                                height: 375,
                                width: 400,
                                "http://185.116.193.73/storage/${widget.product.path![imageIndex]}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const ErrorImageWidget(
                                  height: 375,
                                  width: 400,
                                ),
                              ),
                            );
                    }),
              ),

              // Container(
              //   height: 300,
              //   color: Colors.white,
              //   margin: const EdgeInsets.only(right: 8, left: 8),
              //   child: imageIndex + 1 ==
              //           ((widget.product.path?.length ?? 0) + 1)
              //       ? GestureDetector(
              //           onTap: () {
              //             _controller!.value.isPlaying
              //                 ? _controller!.pause()
              //                 : _controller!.play();
              //           },
              //           child: Stack(children: [
              //             Container(
              //               width: 600,
              //               height: 300,
              //               child: AspectRatio(
              //                 aspectRatio: _controller!.value.aspectRatio,
              //                 child: ClipRRect(
              //                     borderRadius: BorderRadius.circular(12),
              //                     child: VideoPlayer(_controller!)),
              //               ),
              //             ),
              //             Container(
              //               alignment: Alignment.bottomCenter,
              //               padding: EdgeInsets.only(
              //                   bottom:
              //                       MediaQuery.of(context).size.height * 0.01),
              //               child: VideoProgressIndicator(_controller!,
              //                   allowScrubbing: true),
              //             ),
              //             icon
              //                 ? Center(
              //                     child: SvgPicture.asset(
              //                     'assets/icons/play_tape.svg',
              //                     color: const Color.fromRGBO(29, 196, 207, 1),
              //                   ))
              //                 : Container(),
              //           ]),
              //         )
              //       : Container(
              //           margin:
              //               const EdgeInsets.only(top: 24, left: 8, right: 8),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //           //color: Colors.red,
              //           child: Image.network(
              //             height: 375,
              //             width: 400,
              //             "http://185.116.193.73/storage/${widget.product.path![imageIndex]}",
              //             fit: BoxFit.cover,
              //             errorBuilder: (context, error, stackTrace) =>
              //                 const ErrorImageWidget(
              //               height: 375,
              //               width: 400,
              //             ),
              //           ),
              //         ),
              // ),

              // Container(
              //   height: 300,
              //   color: Colors.white,
              //   child: Image.network(
              //     widget.product.path!.isNotEmpty
              //         ? "http://80.87.202.73:8001/storage/${widget.product.path!.first}"
              //         : '',
              //     height: 375,
              //     width: 400,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(
                    left: 16.0, right: 4, top: 16, bottom: 4),
                decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(4)),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, right: 8, top: 4, bottom: 4),
                  child: Text(
                    '0·0·12',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              // Container(
              //     margin: const EdgeInsets.only(
              //         left: 323.0, right: 4, top: 16, bottom: 4),
              //     decoration:
              //         BoxDecoration(borderRadius: BorderRadius.circular(4)),
              //     child: Image.asset(
              //       'assets/icons/bs2.png',
              //       height: 36,
              //       width: 36,
              //     )),
              Container(
                margin: const EdgeInsets.only(
                    left: 16.0, right: 4, top: 48, bottom: 4),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4)),
                child: widget.product.point != 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4, top: 4, bottom: 4),
                        child: Text(
                          '${widget.product.point ?? 0}% Б',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : const SizedBox(),
              ),

              widget.product.compound != 0
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 16.0, right: 4, top: 260, bottom: 4),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4, top: 4, bottom: 4),
                        child: Text(
                          '-${widget.product.compound ?? 0}%',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: SizedBox(
                  height: 12,
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
                          //  height: 1,
                          width: 12,
                          decoration: BoxDecoration(
                              color: imageIndex == index
                                  ? AppColors.kPrimaryColor
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                    ),
                  )

                      // ListView.builder(
                      //   itemCount: (widget.product.path?.length ?? 0) +
                      //       (widget.product.video != null ? 1 : 0),
                      //   scrollDirection: Axis.horizontal,

                      //   itemBuilder: ((context, index) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         imageIndex = index;
                      //         setState(() {});
                      //       },
                      //       child: Container(
                      //         margin: const EdgeInsets.only(left: 16),
                      //         //  height: 1,
                      //         width: 12,
                      //         decoration: BoxDecoration(
                      //             color: imageIndex == index
                      //                 ? AppColors.kPrimaryColor
                      //                 : Colors.grey,
                      //             borderRadius: BorderRadius.circular(100)),
                      //       ),
                      //     );
                      //   }),
                      // ),
                      ),
                ),
              ),
              GestureDetector(
                onTap: (() {
                  Get.to(() => ProductImages(images: widget.product.path));
                }),
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 335.0, right: 4, top: 260, bottom: 4),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: SvgPicture.asset(
                      'assets/icons/fullscreen 1.svg',
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.product.name}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.kGray900,
                          fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        onPressed: () async {
                          final favorite =
                              BlocProvider.of<FavoriteCubit>(context);
                          await favorite.favorite(widget.product.id.toString());
                          setState(() {
                            inFavorite = !inFavorite;
                          });
                          BlocProvider.of<ProductCubit>(context).products();
                        },
                        icon: SvgPicture.asset(
                          inFavorite == true
                              ? 'assets/icons/favorite_product_show.svg'
                              : 'assets/icons/heart_fill.svg',
                          color: Colors.red,
                        ))
                  ],
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                Text(
                  'Артикул: ${widget.product.id}',
                  style: const TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
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
                    Text(
                      '(${widget.product.count} отзывов)',
                      style: const TextStyle(
                          color: AppColors.kGray300,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18.5,
                ),
                (widget.product.compound != 0 &&
                        widget.product.compound != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${(widget.product.price!.toInt() - (widget.product.price! / 100) * (widget.product.compound ?? 0)).toInt()} ₽',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.product.price!} ₽',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.kGray900,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'в рассрочку',
                                style: TextStyle(
                                    color: AppColors.kGray200,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD54F),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${((widget.product.price! - (widget.product.price! / 100) * (widget.product.compound ?? 0)) / 3).roundToDouble()}',
                                  style: const TextStyle(
                                      color: AppColors.kGray900,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                'x3',
                                style: TextStyle(
                                    color: AppColors.kGray200,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ],
                      )
                    : Text(
                        '${widget.product.price} ₽',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF19191A),
                            fontWeight: FontWeight.w700),
                      ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Row(
                //   children: [
                //     const Text(
                //       'в рассрочку',
                //       style: TextStyle(
                //           color: AppColors.kGray200,
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     Container(
                //       padding: const EdgeInsets.all(8),
                //       decoration: BoxDecoration(
                //         color: Color(0xFFFFD54F),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Text(
                //         '${(widget.product.price!.toInt() / 3).roundToDouble()}',
                //         style: const TextStyle(
                //             color: AppColors.kGray900,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     const Text(
                //       'x3',
                //       style: TextStyle(
                //           color: AppColors.kGray200,
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400),
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 8,
                ),

                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding: const EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //       color: Colors.red.shade50,
                //       borderRadius: BorderRadius.circular(8)),
                //   child: const Text(
                //     '-10% скидка за наличный расчет',
                //     style: TextStyle(color: Color(0xFFFF3347)),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Stack(children: [
                  Container(
                    transform: Matrix4.translationValues(-16.0, 0.0, 00.0),
                    height: 8,
                    color: const Color(0xFFf1f1f1),
                  ),
                  Container(
                    transform: Matrix4.translationValues(16.0, 0.0, 00.0),
                    height: 8,
                    color: const Color(0xFFf1f1f1),
                  ),
                ]),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  //padding: const EdgeInsets.all(16),
                  // color: Colors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'В рассрочку',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.585, // 229,
                            height: 32,
                            child: ListView.builder(
                              itemCount: textInst.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      width: 54,
                                      decoration: BoxDecoration(
                                        color: selectedIndex2 == index
                                            ? const Color(0xFFFFD54F)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                      ),
                                      child: Text(
                                        textInst[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: AppColors.kGray900,
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
                      Row(
                        children: [
                          Container(
                            // width: 90,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD54F),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${(widget.product.price! - (widget.product.price! / 100) * widget.product.compound!) ~/ selectedIndexMonth!.toInt()}',
                              style: const TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            ' x$selectedIndexMonth',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Stack(children: [
                  Container(
                    transform: Matrix4.translationValues(-16.0, 0.0, 00.0),
                    height: 8,
                    color: const Color(0xFFf1f1f1),
                  ),
                  Container(
                    transform: Matrix4.translationValues(16.0, 0.0, 00.0),
                    height: 8,
                    color: const Color(0xFFf1f1f1),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),

                BlocBuilder<profitCubit.ProfitCubit, profitState.ProfitState>(
                    builder: (context, state) {
                  if (state is profitState.ErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style:
                            const TextStyle(fontSize: 20.0, color: Colors.grey),
                      ),
                    );
                  }
                  if (state is profitState.LoadedState) {
                    return Container(
                        height: 150,
                        width: double.infinity,
                        padding: EdgeInsets.zero,
                        child: Image.network(
                          'http://185.116.193.73/storage/${state.path}',
                          fit: BoxFit.cover,
                        ));
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent));
                  }
                }),

                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Оптом',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 28,
                      child: ListView.builder(
                        itemCount: widget.product.bloc?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (selectedIndex3 == index) {
                                selectedIndex3 = -1;
                              } else {
                                selectedIndex3 = index;
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Container(
                                width: 54,
                                decoration: BoxDecoration(
                                  color: selectedIndex3 == index
                                      ? AppColors.kPrimaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: selectedIndex3 != index
                                        ? AppColors.kPrimaryColor
                                        : Colors.white,
                                  ),
                                ),
                                // padding: const EdgeInsets.only(
                                //   top: 8,
                                //   bottom: 8,
                                // ),
                                alignment: Alignment.center,
                                child: Text(
                                  'x${widget.product.bloc?[index].count ?? 0}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: selectedIndex3 == index
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
                const SizedBox(height: 14),
                SizedBox(
                  height: 14,
                  child: Row(children: [
                    Text(
                      '${selectedIndex3 != -1 ? "${widget.product.bloc![selectedIndex3!].price} руб " : ''} ',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${selectedIndex3 != -1 ? "(цена за ${widget.product.bloc![selectedIndex3!].count}шт )" : 0}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    Text(
                      ' x${count != -1 ? count : 0}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    Text(
                        ' = ${(selectedIndex3 != -1 ? widget.product.bloc![selectedIndex3!].price as int : 1) * count}',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey)),
                  ]),
                ),

                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          // BlocProvider.of<BasketCubit>(context)
                          //     .basketMinus(
                          //         widget.product.id.toString(), '1');
                          if (count != 0) {
                            if (selectedIndex3 != -1) {
                              count -= 1;
                              BlocProvider.of<BasketCubit>(context).basketMinus(
                                  widget.product.id.toString(),
                                  (widget.product.bloc![selectedIndex3!]
                                          .count! *
                                      count),
                                  (widget.product.bloc![selectedIndex3!]
                                          .price! *
                                      count));
                            }
                          } else {
                            isvisible = false;
                          }

                          setState(() {});
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
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 14,
                      // ),
                      Container(
                        width: 28,
                        alignment: Alignment.center,
                        child: Text('$count'),
                      ),
                      // const SizedBox(
                      //   width: 14,
                      // ),
                      InkWell(
                        onTap: () {
                          // BlocProvider.of<BasketCubit>(context)
                          //     .basketAdd(
                          //         widget.product.id.toString(), '1');

                          if (selectedIndex3 != -1) {
                            count += 1;
                            isvisible = true;

                            BlocProvider.of<BasketCubit>(context).basketAdd(
                                widget.product.id.toString(),
                                (widget.product.bloc![selectedIndex3!].count! *
                                    count),
                                (widget.product.bloc![selectedIndex3!].price! *
                                    count),
                                colorValue,
                                sizeValue,
                                isOptom: true);

                            setState(() {});
                          }
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
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          // child: SvgPicture.asset(
                          //     'assets/icons/add_1.svg'),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(
                      Icons.card_giftcard_outlined,
                      color: AppColors.kPrimaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Экономия ${selectedIndex3 != -1 ? ((((widget.product.price! - widget.product.price! / 100 * widget.product.compound!) * widget.product.bloc![selectedIndex3!].count!) - widget.product.bloc![selectedIndex3!].price!) * count) : 0}  руб',
                      style: const TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/bi_box-fill.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'В наличии: ${widget.product.product_count} шт',
                          style: const TextStyle(
                              // color: AppColors.kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icons/fluent_box-multiple-20-filled.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Оптом: $optom шт',
                          style: const TextStyle(
                              // color: AppColors.kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
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
                if (widget.product.size?.length != 0)
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
                if (widget.product.color?.length != 0)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Выберите цвет',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // for (var item in imgList)
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 1, bottom: 10),
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
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(AppColors.getColorFromHex(
                                          widget.product.color![index])),
                                      borderRadius: BorderRadius.circular(8),
                                      border: selectedIndex == index
                                          ? Border.all(color: Colors.black)
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
          Container(
            padding: const EdgeInsets.only(top: 16, left: 16),
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Продавцы',
              style: TextStyle(
                color: AppColors.kGray900,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '(${widget.product.shop!.id} отзывов)',
                                    style: const TextStyle(
                                        color: AppColors.kGray300,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  RatingBar(
                                    ignoreGestures: true,
                                    initialRating: 2,
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
                                ],
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
                                '${widget.product.price} ₽',
                                style: const TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 22,
                                    // width: 48,
                                    padding: const EdgeInsets.all(2),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD54F),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${(widget.product.price!.toInt() / 3).round()}',
                                      style: const TextStyle(
                                          color: AppColors.kGray900,
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
                                        color: AppColors.kGray200,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      text: "Доставка ",
                                      style: TextStyle(
                                          color: AppColors.kGray900,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'завтра, ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            // decoration: TextDecoration.underline,
                                            // decorationColor: Colors.red,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'бесплатно',
                                        ),
                                      ],
                                    ),
                                  ),
                                  //  const Text(
                                  //     'Доставка завтра, бесплатно \n',
                                  //     style: TextStyle(
                                  //         color: AppColors.kGray900,
                                  //         fontSize: 14,
                                  //         fontWeight: FontWeight.w400),
                                  //   ),
                                  const Text(
                                    'Самовывоз: завтра',
                                    style: TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
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
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF1DC4CF),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 16, right: 16),
                                  child: const Text(
                                    'Выбрать',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
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
                        ],
                      ),
                    ),
                  );
                },
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            // padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Характеристики',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Назначение: Обычные\nТип конструкции: Полноразмерные\nТип крепления: С оголовьем\nЧастотный диапазон, Гц-кГц: 20 - 20\nИмпеданс, Ом: 32\nТип подключения: Беспроводное',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  color: AppColors.kGray400,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SpecificationsPage()),
                      );
                      // SpecificationsPage
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              color: Colors.white,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Отзывы',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Читать все',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kPrimaryColor),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    //  height: 300,
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: TextSpan(
                              //  style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${widget.product.rating}",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const TextSpan(
                                  text: " из 5",
                                  style: TextStyle(
                                      color: AppColors.kGray300,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 65,
                          margin: const EdgeInsets.only(top: 0, left: 108),
                          child: ListView.builder(
                              itemCount: 5,
                              // scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              reverse: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: index.toDouble() + 1,
                                      minRating: 1,
                                      itemSize: 13,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                            height: 4,
                                            width: 186,
                                            color: const Color(0xffe5f1ff)),
                                        widget.product.review?[index] != 0
                                            ? Container(
                                                height: 4,
                                                width: 186.0 /
                                                    widget.product.count!,
                                                color: const Color(0xffFFC107))
                                            : const SizedBox()
                                      ],
                                    )
                                  ],
                                );
                              }),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 55),
                          child: Text(
                            '${widget.product.count} отзывов',
                            style: const TextStyle(
                                color: AppColors.kGray300,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
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
                                  : (100 * state.reviewModel.length.toDouble()),
                              padding: const EdgeInsets.all(16),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: state.reviewModel.length,
                                itemBuilder: (context, index) {
                                  return Expanded(
                                    child: Column(
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
                                                  fontWeight: FontWeight.w500),
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
                  // Container(
                  //   padding: const EdgeInsets.all(16),
                  //   child: ListView.builder(
                  //     itemCount: 2,
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     // separatorBuilder: (BuildContext context, int index) => const Divider(),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 const Text(
                  //                   'Ronald Richards',
                  //                   style: TextStyle(
                  //                       color: AppColors.kGray900,
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w500),
                  //                 ),
                  //                 RatingBar(
                  //                   ignoreGestures: true,
                  //                   initialRating: 2,
                  //                   unratedColor: const Color(0x30F11712),
                  //                   itemSize: 15,
                  //                   // itemPadding:
                  //                   // const EdgeInsets.symmetric(horizontal: 4.0),
                  //                   ratingWidget: RatingWidget(
                  //                     full: const Icon(
                  //                       Icons.star,
                  //                       color: Color(0xFFFFC107),
                  //                     ),
                  //                     half: const Icon(
                  //                       Icons.star,
                  //                       color: Color(0xFFFFC107),
                  //                     ),
                  //                     empty: const Icon(
                  //                       Icons.star,
                  //                       color: Color(0xFFFFC107),
                  //                     ),
                  //                   ),
                  //                   onRatingUpdate: (double value) {},
                  //                 ),
                  //               ],
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             const Text(
                  //               '14 мая 2021г.',
                  //               style: TextStyle(
                  //                   color: AppColors.kGray300,
                  //                   fontWeight: FontWeight.w500,
                  //                   fontSize: 12),
                  //             ),
                  //             const SizedBox(
                  //               height: 4,
                  //             ),
                  //             const Text(
                  //               'Here is some long text that I am expecting will go off of the screen.',
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w400,
                  //                   fontSize: 14.0,
                  //                   color: Colors.black),
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             //   Flexible(
                  //             //       child: Text(
                  //             //           'The Dropbox HQ in San Francisco is one of the best designed & most comfortable offices I have ever witnessed. Great stuff! If you happen to visit SanFran, dont miss the chance to witness it yourself. ',style: TextStyle(color: Colors.black),))
                  //             // ],
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          // widget.product.buyed == true
          //     ? Container(
          //         padding: const EdgeInsets.all(16),
          //         color: Colors.white,
          //         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Text(
          //                 'Оставьте отзыв',
          //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          //                 textAlign: TextAlign.start,
          //               ),
          //               RatingBar.builder(
          //                 initialRating: 0,
          //                 minRating: 1,
          //                 itemSize: 15,
          //                 direction: Axis.horizontal,
          //                 allowHalfRating: false,
          //                 itemCount: 5,
          //                 itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          //                 itemBuilder: (context, _) => const Icon(
          //                   Icons.star,
          //                   color: Colors.amber,
          //                 ),
          //                 onRatingUpdate: (value) {
          //                   rating = value.toInt();
          //                 },
          //               ),
          //             ],
          //           ),
          //           TextFormField(
          //             controller: _commentController,
          //             maxLines: 5,
          //             keyboardType: TextInputType.text,
          //             decoration: const InputDecoration(hintText: 'Напишите отзывь', border: InputBorder.none),
          //           ),
          //           GestureDetector(
          //             onTap: () async {
          //               await BlocProvider.of<reviewProductCubit.ReviewCubit>(context)
          //                   .reviewStore(_commentController.text, rating.toString(), widget.product.id.toString());
          //               _commentController.clear();
          //             },
          //             child: Container(
          //               alignment: Alignment.center,
          //               height: 39,
          //               width: 209,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(6),
          //                 border: Border.all(width: 0.2),
          //                 boxShadow: const [
          //                   BoxShadow(
          //                     color: Colors.black,
          //                     offset: Offset(
          //                       0.2,
          //                       0.2,
          //                     ), //Offset
          //                     blurRadius: 0.1,
          //                     spreadRadius: 0.1,
          //                   ), //BoxShadow
          //                   BoxShadow(
          //                     color: Colors.white,
          //                     offset: Offset(0.0, 0.0),
          //                     blurRadius: 0.0,
          //                     spreadRadius: 0.0,
          //                   ), //BoxShadow
          //                 ],
          //               ),
          //               child: const Text(
          //                 'Оставить свой отзыв',
          //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ),
          //         ]),
          //       )
          //     : Container(),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: 170,
              color: Colors.white,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: textDescrp.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 0),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        List<int> _selectedListSort = [];

                        _selectedListSort.add(widget.product.shop!.id as int);

                        GetStorage().write(
                            'shopFilterId', _selectedListSort.toString());

                        context.router.push(ProductsRoute(
                          cats: Cats(id: 0, name: ''),
                          shopId: widget.product.shop!.id.toString(),
                        ));

                        // Get.to(() => ProductsPage(
                        //       cats: Cats(id: 0, name: ''),
                        //     ));
                      } else if (index == 1) {
                        context.router.push(ProductsRoute(
                          cats: Cats(id: 0, name: ''),
                        ));
                        // Get.to(() => ProductsPage(
                        //       cats: Cats(id: 0, name: ''),
                        //     ));
                      } else if (index == 2) {
                        context.router.push(ProductsRoute(
                          cats: Cats(id: 1, name: widget.product.catName),
                        ));
                        // Get.to(() => ProductsPage(
                        //       cats: Cats(id: 1, name: widget.product.catName),
                        //     ));
                      }
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 14, top: 14, right: 14),
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textDescrp[index],
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.kGray400,
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
                                height: 608,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                Future.wait<void>([
                  BlocProvider.of<BasketCubit>(context).basketAdd(
                      widget.product.id.toString(),
                      '1',
                      0,
                      sizeValue,
                      colorValue),
                ]);

                if (BlocProvider.of<BasketCubit>(context).state
                    is! LoadedState) {
                  Future.wait<void>([
                    BlocProvider.of<BasketCubit>(context).basketShow(),
                  ]);
                }

                Future.wait<void>(
                    [BlocProvider.of<ProductCubit>(context).products()]);
                context.router.push(BasketOrderAddressRoute(
                  fulfillment: 'fbs',
                ));

                // Navigator.popUntil(context, (route) => route.isFirst);
                // BlocProvider.of<NavigationCubit>(context)
                //     .getNavBarItem(const NavigationState.basket());
                // setState(() {
                //   isvisible = true;
                // });

                //    Get.to(() => BasketOrderPage(fbs: false));
              },
              child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.kPrimaryColor,
                  ),
                  width: MediaQuery.of(context).size.width * 0.440,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 15),
                  child: const Text(
                    'Оформить сейчас',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            InkWell(
              onTap: () {
                // Navigator.pop(context);

                if (isvisible == false && widget.product.inBasket == false) {
                  BlocProvider.of<BasketCubit>(context).basketAdd(
                      widget.product.id.toString(),
                      '1',
                      0,
                      sizeValue,
                      colorValue);
                  setState(() {
                    isvisible = true;
                  });
                  BlocProvider.of<ProductCubit>(context).products();
                } else {
                  context.router.pushAndPopUntil(
                    const LauncherRoute(children: [BasketRoute()]),
                    predicate: (route) => false,
                  );
                }
              },
              child: Container(
                  height: 46,
                  width: 175,
                  // width: MediaQuery.of(context).size.width * 0.490,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child:
                      (isvisible == false && widget.product.inBasket == false)
                          ? const Text(
                              'Добавить в корзину',
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
            )
          ],
        ),
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
