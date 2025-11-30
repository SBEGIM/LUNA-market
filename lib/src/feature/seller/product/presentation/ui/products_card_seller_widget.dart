import 'package:flutter/material.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/models/product_seller_model.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:intl/intl.dart';
import '../widgets/show_alert_statictics_seller_widget.dart';

class ProductCardSellerPage extends StatefulWidget {
  final ProductSellerModel product;

  ProductSellerCubit cubit;
  BuildContext context;

  ProductCardSellerPage({
    required this.product,
    required this.context,
    required this.cubit,
    super.key,
  });

  @override
  State<ProductCardSellerPage> createState() => _ProductCardSellerPageState();
}

class _ProductCardSellerPageState extends State<ProductCardSellerPage> {
  int count = 0;
  bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;
  int optomCount = 0;

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  void initState() {
    // count += widget.product.basketCount ?? 0;
    // if (count > 0) {
    //   isvisible = true;
    // }
    // inFavorite = widget.product.inFavorite ?? false;
    compoundPrice =
        widget.product.price! -
        ((widget.product.price! / 100) * (widget.product.compound ?? 1)).toInt();

    widget.product.bloc?.forEach((element) {
      optomCount += element.count ?? 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      margin: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      decoration: BoxDecoration(color: Color(0xffF7F7F7), borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 16),
            child: Stack(
              children: [
                Container(
                  height: 114,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12), // Slightly smaller than container
                      child: Image.network(
                        widget.product.path != null
                            ? "https://lunamarket.ru/storage/${widget.product.path!.path}"
                            : "https://lunamarket.ru/storage/banners/2.png",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[100],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.kYellowDark,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.product.fulfillment ?? 'Доставка',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.statisticsTextStyle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      widget.product.point != 0
                          ? Container(
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
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${widget.product.point ?? 0}% Б',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.statisticsTextStyle.copyWith(
                                  color: AppColors.kWhite,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(height: widget.product.point != 0 ? 22 : 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.product.catName}',
                        style: AppTextStyles.size13Weight400.copyWith(color: Color(0xff8E8E93)),
                      ),
                      InkWell(
                        onTap: () {
                          showProductOptions(widget.context, widget.product, widget.cubit);
                        },
                        child: Icon(Icons.more_vert, color: Color(0xff8E8E93), size: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: 280,
                  height: 40,
                  padding: EdgeInsets.only(right: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.product.name.toString(),
                    style: AppTextStyles.size14Weight600,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 26,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainPurpleColor.withOpacity(0.20),
                      ),
                      child: Text(
                        'Осталось: ${widget.product.count} шт',
                        style: AppTextStyles.size13Weight400.copyWith(
                          color: AppColors.mainPurpleColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 26,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainPurpleColor.withOpacity(0.20),
                      ),
                      child: Text(
                        'Вознаграждение блогера: ${widget.product.pointBlogger} %',
                        style: AppTextStyles.size13Weight400.copyWith(
                          color: AppColors.mainPurpleColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                compoundPrice != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${formatPrice(compoundPrice)} ₽ ',
                            style: AppTextStyles.size16Weight600,
                          ),
                          Text(
                            '${formatPrice(widget.product.price!)} ₽ ',
                            style: AppTextStyles.size13Weight500.copyWith(
                              color: Color(0xff8E8E93),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Color(0xff8E8E93),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '${formatPrice(widget.product.price!)} ₽ ',
                        style: AppTextStyles.size16Weight600,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
