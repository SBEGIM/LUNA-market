import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class GridLayoutPopularShop {
  String? title;
  String? icon;

  GridLayoutPopularShop({
    this.title,
    this.icon,
  });
}

List<GridLayoutPopularShop> optionsPopularshop = [
  GridLayoutPopularShop(
    title: 'Technodom',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopularShop(
    title: 'Magnum',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopularShop(
    title: 'Alser',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopularShop(
    title: 'Sulpak',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopularShop(
    title: 'Мечта',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopularShop(
    title: 'Small',
    icon: 'assets/images/reclama.png',
  ),
];

class GridOptionsPopularShop extends StatelessWidget {
  final GridLayoutPopularShop? layout;
  const GridOptionsPopularShop({Key? key, this.layout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            layout!.icon!,
          ),
        ),
        Text(layout!.title!, style: AppTextStyles.categoryTextStyle),
      ],
    );
  }
}
