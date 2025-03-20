import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';

import '../../data/models/blogger_shop_products_model.dart';

class BannerWatcehRecentlyAdminPage extends StatelessWidget {
  final BloggerShopProductModel product;
  const BannerWatcehRecentlyAdminPage({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  product.path!.path != null
                      ? "https://lunamarket.ru/storage/${product.path!.path}"
                      : '',
                  fit: BoxFit.cover,
                  height: 160,
                  width: 160,
                  errorBuilder: (context, error, stackTrace) =>
                      const ErrorImageWidget(
                    height: 160,
                    width: 160,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 0, bottom: 8, top: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8, top: 4, bottom: 4),
                            child: Text(
                              '0.0.12',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 4.0, right: 4, top: 4, bottom: 4),
                        child: Text(
                          '10% Б',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.kGray900,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Подкатегория',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.kGray300,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.price} ₸ ',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${product.price}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'х3',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// fontSize: 12
