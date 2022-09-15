import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class GridLayoutPopular {
  String? title;
  String? icon;

  GridLayoutPopular({
    this.title,
    this.icon,
  });
}

List<GridLayoutPopular> optionsPopular = [
  GridLayoutPopular(
    title: 'Cмартфоны',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopular(
    title: 'Cамокаты',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopular(
    title: 'Компьютер',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopular(
    title: 'Кухня',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopular(
    title: 'Электронные книги',
    icon: 'assets/images/reclama.png',
  ),
  GridLayoutPopular(
    title: 'Для фитнеса',
    icon: 'assets/images/reclama.png',
  ),
];

class GridOptionsPopular extends StatelessWidget {
  final GridLayoutPopular? layout;
  const GridOptionsPopular({Key? key, this.layout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            layout!.icon!,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Flexible(
            child:
                Text(layout!.title!, style: AppTextStyles.categoryTextStyle)),
      ],
    );
  }
}
