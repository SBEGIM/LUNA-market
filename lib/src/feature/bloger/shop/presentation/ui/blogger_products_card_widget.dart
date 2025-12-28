import 'package:flutter/material.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/bloger/shop/data/models/blogger_shop_products_model.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:intl/intl.dart';

class BloggerProductCardWidget extends StatefulWidget {
  final BloggerShopProductModel product;
  final bool isSelected;
  final int index;
  final Function(bool, int) onSelectionChanged;

  const BloggerProductCardWidget({
    required this.product,
    this.isSelected = false,
    required this.index,
    required this.onSelectionChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<BloggerProductCardWidget> createState() => _BloggerProductCardWidget();
}

class _BloggerProductCardWidget extends State<BloggerProductCardWidget> {
  int count = 0;
  bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;
  double procentPrice = 0;

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  void initState() {
    compoundPrice = (widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.only(left: 16, top: 7, bottom: 8, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xFFF7F7F7),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 12),
                child: Stack(
                  children: [
                    Container(
                      height: 104,
                      width: 104,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.product.path != null
                              ? "https://lunamarket.ru/storage/${widget.product.path!.path}"
                              : "https://lunamarket.ru/storage/banners/2.png",
                          fit: BoxFit.cover,
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
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              '0·0·12',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.statisticsTextStyle,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 52,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-0.6, -1),
                                end: Alignment(1, 1),
                                colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                                stops: [0.2685, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              '${widget.product.bonus ?? 0}% Б',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.statisticsTextStyle.copyWith(
                                color: AppColors.kWhite,
                              ),
                            ),
                          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${widget.product.catName}',
                            style: AppTextStyles.size13Weight400.copyWith(color: Color(0xff8E8E93)),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            widget.onSelectionChanged(!widget.isSelected, widget.product.id!);
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            margin: const EdgeInsets.only(top: 8.0, right: 10.0),
                            child: Image.asset(
                              widget.index == widget.product.id
                                  ? Assets.icons.defaultCheckIcon.path
                                  : Assets.icons.defaultUncheckIcon.path,
                              scale: 1.9,
                              color: widget.index == widget.product.id
                                  ? AppColors.kLightBlackColor
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 20, // минимум
                        maxHeight: 40, // максимум
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        heightFactor: 1,
                        child: Text(
                          widget.product.name.toString(),
                          style: AppTextStyles.size14Weight600,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // не больше 2 строк
                        ),
                      ),
                    ),
                    SizedBox(height: 11),
                    compoundPrice != 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 22,
                                child: Text(
                                  '${formatPrice(compoundPrice)} ₽ ',
                                  style: AppTextStyles.size16Weight600,
                                ),
                              ),
                              Text(
                                '${formatPrice(widget.product.price!)} ₽ ',
                                style: AppTextStyles.size13Weight500.copyWith(
                                  color: Color(0xFF8E8E93),
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color(0xFF8E8E93),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            '${formatPrice(widget.product.price!)} ₽ ',
                            style: AppTextStyles.size16Weight600,
                          ),
                    const SizedBox(height: 11),
                    Container(
                      height: 26,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.mainPurpleColor.withOpacity(0.20),
                      ),
                      child: Text(
                        'Рекламное вознаграждение: ${widget.product.bloggerPoint} %',
                        style: AppTextStyles.size13Weight400.copyWith(
                          color: AppColors.mainPurpleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
