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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // margin: const EdgeInsets.only(left: 12, right: 12),
                alignment: Alignment.center,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                        image: NetworkImage(
                          "http://185.116.193.73/storage/${layout!.icon ?? ''}",
                        ),
                        fit: BoxFit.contain),
                    color: const Color(0xFFF0F5F5)),
                // child: Image.network(
                //   "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
                //   width: 70,
                // ),
              ),
              // Container(
              //   height: 154,
              //   width: 108,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       image: DecorationImage(
              //         image: NetworkImage(
              //             "http://80.87.202.73:8001/storage/${layout!.image!}"),
              //         fit: BoxFit.cover,
              //       )),

              //   // child: CircleAvatar(),
              // ),
              if (layout!.credit == 1)
                Container(
                  width: 46,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(31, 196, 207, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.only(top: 80, left: 4),
                  alignment: Alignment.center,
                  child: const Text(
                    "0·0·12",
                    style: AppTextStyles.bannerTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              // Container(
              //   width: 46,
              //   height: 22,
              //   decoration: BoxDecoration(
              //     color: Colors.black,
              //     borderRadius: BorderRadius.circular(6),
              //   ),
              //   margin: const EdgeInsets.only(top: 105, left: 4),
              //   alignment: Alignment.center,
              //   child: Text(
              //     "${layout!.bonus.toString()}% Б",
              //     style: AppTextStyles.bannerTextStyle,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17, left: 4),
                alignment: Alignment.center,
                child: Text(
                  layout?.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyles.categoryTextStyle,
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
