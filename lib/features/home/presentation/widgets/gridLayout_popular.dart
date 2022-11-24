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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 80,
              width: 115,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://80.87.202.73:8001/storage/${layout!.image!}"),
                    fit: BoxFit.cover,
                  )),
            ),
            if (layout!.credit == 1)
              Container(
                width: 46,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(31, 196, 207, 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                margin: const EdgeInsets.only(top: 8, left: 4),
                alignment: Alignment.center,
                child: const Text(
                  "0·0·12",
                  style: AppTextStyles.bannerTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            Container(
              width: 46,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: layout!.credit == 1
                  ? const EdgeInsets.only(top: 34, left: 4)
                  : const EdgeInsets.only(top: 8, left: 4),
              alignment: Alignment.center,
              child: Text(
                "${layout!.bonus.toString()}% Б",
                style: AppTextStyles.bannerTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        // Center(
        //   child: Image.asset(
        //
        //   ),
        // ),
        const SizedBox(
          height: 8,
        ),
        Text(layout!.title!, style: AppTextStyles.categoryTextStyle),
        // Flexible(
        //     child:
      ],
    );
  }
}
