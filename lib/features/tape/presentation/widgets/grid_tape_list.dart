import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';

class GridTapeListCategory {
  String? title;
  String? icon;

  GridTapeListCategory({
    this.title,
    this.icon,
  });
}

List<GridTapeListCategory> optionsTape = [
  GridTapeListCategory(
    title: 'Скидки',
    icon: 'assets/images/tape.png',
  ),
  GridTapeListCategory(
    title: 'Cмартфоны',
    icon: 'assets/images/tape.png',
  ),
  GridTapeListCategory(
    title: 'Аптека',
    icon: 'assets/images/tape.png',
  ),
  GridTapeListCategory(
    title: 'Аксессуары',
    icon: 'assets/images/tape.png',
  ),
  GridTapeListCategory(
    title: 'Игрушки',
    icon: 'assets/images/tape.png',
  ),
  GridTapeListCategory(
    title: 'Cмартфоны',
    icon: 'assets/images/tape.png',
  ),
];

class GridTapeCategory extends StatelessWidget {
  final GridTapeListCategory? layout;
  const GridTapeCategory({Key? key, this.layout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width *0.9 ,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(layout!.icon!),
        fit: BoxFit.fill,
      )),
    );
    // Container(
    //   height: MediaQuery.of(context).size.height ,
    //   width: MediaQuery.of(context).size.width *0.9 ,
    //   // shape: RoundedRectangleBorder(
    //   //   borderRadius: BorderRadius.circular(15.0),
    //   // ),
    //   // elevation: 0,
    //   color: AppColors.kBackgroundColor,
    //   child: Image.asset(layout!.icon!),
    // );
  }
}
