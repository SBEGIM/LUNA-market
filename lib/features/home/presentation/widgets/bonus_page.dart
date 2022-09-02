import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class BonusPage extends StatefulWidget {
  BonusPage({Key? key}) : super(key: key);

  @override
  State<BonusPage> createState() => _BonusPageState();
}

class _BonusPageState extends State<BonusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: const Icon(
        //   Icons.menu,
        //   color: AppColors.kPrimaryColor,
        // ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: Icon(
              Icons.ios_share_outlined,
            ),
          )
        ],
        title: const Text(
          'Дарим 5% бонусов',
          style: AppTextStyles.appBarTextStylea,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Image.asset('assets/images/card_product.png'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            child: const ListTile(
              title: Text('Магазины на Haji market'),
              subtitle: Text('Выбирайте товары в магазинах города'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: const ListTile(
              title: Text('Магазины на Haji market'),
              subtitle: Text('Выбирайте товары в магазинах города'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
