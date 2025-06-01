import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/main/data/model/news_seeler_model.dart';

import '../../../../../core/constant/generated/assets.gen.dart';

class NewsScreen extends StatefulWidget {
  final NewsSeelerModel news;

  const NewsScreen({required this.news, super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
              child: Image.network(
                  'https://lunamarket.ru/storage/${widget.news.image}'),
            ),
            SizedBox(height: 10),
            Text(
              widget.news.title!,
              style: AppTextStyles.defaultAppBarTextStyle,
            ),
            SizedBox(height: 10),
            Text(widget.news.description!)
          ],
        ),
      ),
    );
  }
}
