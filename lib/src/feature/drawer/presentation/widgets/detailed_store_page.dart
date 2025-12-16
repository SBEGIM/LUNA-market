import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/review_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/review_state.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/punkts_widget.dart';
import 'package:haji_market/src/feature/home/bloc/cats_cubit.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/common/constants.dart';
import '../../../chat/presentation/message.dart';
import '../../../product/data/model/product_model.dart';

@RoutePage()
class DetailStorePage extends StatefulWidget {
  final ProductModel product;
  const DetailStorePage({required this.product, Key? key}) : super(key: key);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState();
}

class _DetailStorePageState extends State<DetailStorePage> {
  int segmentValue = 0;
  // List<bool>? isSelected;

  List<String> textDescrp = [];
  int index = 0;
  bool isSelected = false;

  // @override
  // void initState() {
  //   isSelected = [true, false];
  //   super.initState();
  // }

  @override
  void initState() {
    textDescrp = ['Чат с поддержкой', 'Все товары “${widget.product.shop!.name}”'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        elevation: 0,
        leadingWidth: 18,
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Продавец', style: AppTextStyles.size18Weight600),
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: SvgPicture.asset('assets/icons/share.svg'))
        // ],
      ),
      // appBar: ,
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.product.shop?.name ?? ''}', style: AppTextStyles.size18Weight600),
                Text(
                  'Дата регистрации: ${widget.product.shop!.createdAt}',
                  style: AppTextStyles.size14Weight400.copyWith(color: Color(0xffAEAEB2)),
                ),
                SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.sellerIcon.path,
                      color: Color(0xff34C759),
                      height: 12,
                      width: 12,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'Более 1 000 успешных продаж',
                      style: AppTextStyles.size13Weight400.copyWith(
                        color: AppColors.mainGreenColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                InkWell(
                  onTap: () {
                    Get.to(
                      MessagePage(
                        userId: widget.product.shop?.id,
                        name: widget.product.shop?.name,
                        avatar: widget.product.shop?.image,
                        chatId: widget.product.shop?.chat_id ?? 0,
                        role: 'shop',
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.mainBackgroundPurpleColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Чат с магазином',
                      style: AppTextStyles.size16Weight600.copyWith(
                        color: AppColors.mainPurpleColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
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
                    ).catById(widget.product.shop!.chat_id.toString());

                    if (index == 0) {
                      launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false);
                    }

                    if (index == 1) {
                      context.router.push(
                        ProductsRoute(cats: catsModel, shopId: widget.product.shop!.id.toString()),
                      );
                      filters.setShops([widget.product.shop!.id ?? 0]);

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

          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          segmentValue = 0;
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 36,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: segmentValue == 0
                                ? AppColors.mainPurpleColor
                                : Color(0xffEAECED),
                          ),
                          child: Text(
                            'Отзывы ',
                            style: AppTextStyles.size14Weight500.copyWith(
                              color: segmentValue == 0 ? AppColors.kWhite : Color(0xff636366),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          segmentValue = 1;

                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 36,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: segmentValue == 1
                                ? AppColors.mainPurpleColor
                                : Color(0xffEAECED),
                          ),
                          child: Text(
                            'Пункты самовывоза ',
                            style: AppTextStyles.size14Weight500.copyWith(
                              color: segmentValue == 1 ? AppColors.kWhite : Color(0xff636366),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                IndexedStack(
                  index: segmentValue,
                  children: [
                    ReviewsWidget(product: widget.product),
                    PunktsWidget(),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ReviewsWidget(),

          // IndexedStack(
          //   index: index,
          //   children: [],
          // ),
        ],
      ),
    );
  }
}

class ReviewsWidget extends StatefulWidget {
  final ProductModel product;
  ReviewsWidget({required this.product, Key? key}) : super(key: key);

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  int rating = 0;
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<ReviewCubit>(context).reviews(widget.product.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                // левая колонка (оценка и кол-во отзывов)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(widget.product.rating ?? 0).toDouble()}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.product.count ?? 0} отзывов',
                      style: const TextStyle(
                        color: AppColors.kGray300,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 254,
                  height: 73,
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
                                Container(height: 4, width: 160, color: const Color(0xffD1D1D6)),
                                if (barWidth > 0)
                                  Container(
                                    height: 4,
                                    width: barWidth,
                                    color: const Color(0xffFFBE00),
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
          BlocConsumer<ReviewCubit, ReviewState>(
            listener: (_, __) {},
            builder: (context, state) {
              if (state is ErrorState) {
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
              if (state is LoadingState) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
                );
              }
              if (state is LoadedState) {
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
                              style: const TextStyle(
                                color: AppColors.kGray300,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
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
    );
  }
}
