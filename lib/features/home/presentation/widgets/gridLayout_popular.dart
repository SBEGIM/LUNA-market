import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class GridLayoutPopular {
  String? title;
  String? image;
  String? icon;
  int? credit;
  int? bonus;

  GridLayoutPopular({
    this.title,
    this.icon,
    this.image,
    this.credit,
    this.bonus,
  });
}

class GridOptionsPopular extends StatelessWidget {
  final GridLayoutPopular? layout;
  const GridOptionsPopular({Key? key, this.layout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(15, 227, 9, 9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          Container(
            // margin: const EdgeInsets.only(left: 12, right: 12),
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image: DecorationImage(
                    image: NetworkImage(
                      "https://lunamarket.ru/storage/${layout!.icon ?? ''}",
                    ),
                    fit: BoxFit.cover),
                color: const Color(0xFFF0F5F5)),
            // child: Image.network(
            //   "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
            //   width: 70,
            // ),
          ),
          const SizedBox(height: 8),
          Text(
            layout?.title ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppTextStyles.categoryTextStyle,
            textAlign: TextAlign.center,
          ),

          // if (layout!.credit == 1)
          //   Container(
          //     width: 46,
          //     height: 22,
          //     decoration: BoxDecoration(
          //       color: const Color.fromRGBO(31, 196, 207, 1),
          //       borderRadius: BorderRadius.circular(6),
          //     ),
          //     margin: const EdgeInsets.only(top: 80, left: 4),
          //     alignment: Alignment.center,
          //     child: const Text(
          //       "0·0·12",
          //       style: AppTextStyles.bannerTextStyle,
          //       textAlign: TextAlign.center,
          //     ),
          //   ),

          // Center(
          //   child: Image.asset(
          //
          //   ),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // Flexible(
          //     child:
        ],
      ),
    );
  }
}
