import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

import '../../../../../core/constant/generated/assets.gen.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Новости'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              width: 358,
              height: 178,
              child: Image.asset(Assets.images.newsImage.path),
            ),
            SizedBox(height: 10),
            Text(
              'Продажа со своего склада (realFBS)',
              style: AppTextStyles.defaultAppBarTextStyle,
            ),
            SizedBox(height: 10),
            Text(
                'Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно.  Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно.  Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно.  Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно.  Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно.  Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно. Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно.  Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно.  Как подключить доставку любым сторонним перевозчиком или возить заказы покупателям самостоятельно. ')
          ],
        ),
      ),
    );
  }
}
