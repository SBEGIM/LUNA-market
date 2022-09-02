import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/favorite/presentation/widgets/delivery_page.dart';

import '../../../drawer/presentation/widgets/products_card_widget.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(
          //     Icons.arrow_back_ios,
          //     color: AppColors.kPrimaryColor,
          //   ),
          // ),
          centerTitle: true,
          title: const Text(
            'Избранное',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(onTap: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryPage()),
                      );
            }, child: const ProductCardWidget());
          }),
    );
  }
}
