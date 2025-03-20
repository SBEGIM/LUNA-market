import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              const BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              )
            ]),
        child: Center(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 80,
                // width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://lunamarket.ru/storage/${layout.image}"),
                      fit: BoxFit.cover,
                    )),
              ),
              // const SizedBox(
              //   height: 13,
              // ),
              Container(
                  height: 44,
                  //  margin: const EdgeInsets.only(top: 69),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
                  // width: 128,
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    // border: Border.all(
                    //   width: 0.1,
                    // ),
                    color: Colors.white,
                  ),
                  alignment: Alignment.topCenter,
                  child: Text(layout.title!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextStyles.categoryTextStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
