import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/presentation/widgets/shimmer/shimmer_box.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/constant/generated/assets.gen.dart';

class GridLayoutCategory {
  String? title;
  String? icon;
  String? image;
  void Function()? onTap;

  GridLayoutCategory({this.title, this.icon, this.onTap, this.image});
}

class GridOptionsCategory extends StatelessWidget {
  final GridLayoutCategory layout;
  const GridOptionsCategory({
    Key? key,
    required this.layout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: layout.onTap,
      child: Container(
        // height: 80,
        // width: 90,
        decoration: BoxDecoration(
          color: AppColors.mainBackgroundPurpleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, left: 8),
              height: 36,
              child: Text(layout.title!,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyles.categoryTextStyle),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.network(
                "https://lunamarket.ru/storage/${layout.image}",
                height: 80,
                width: 80,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: 80,
                    width: 80,
                    child: Shimmer(
                      child: Image.asset(Assets.icons.loaderMain.path),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[100],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
