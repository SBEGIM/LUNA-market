import 'dart:ui'; // ок для ImageFilter (BackdropFilter)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/main/cubit/news_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/main/data/model/news_seeler_model.dart';

import '../../../../../core/constant/generated/assets.gen.dart';

class NewsScreen extends StatefulWidget {
  NewsSeelerModel news;

  NewsScreen({required this.news, super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsSeelerModel _news;

  @override
  void initState() {
    super.initState();

    // локальная копия состояния для UI
    _news = widget.news.copyWith(
      views: (widget.news.views ?? 0) + 1,
    );

    // отправляем событие на бек
    context.read<NewsSellerCubit>().view(_news.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        title: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              width: 358,
              height: 178,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://lunamarket.ru/storage/${_news.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _news.title ?? '',
              style: AppTextStyles.size22Weight600,
            ),
            const SizedBox(height: 10),
            Text(
              _news.description ?? '',
              style: AppTextStyles.size16Weight400
                  .copyWith(color: AppColors.kGray300),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Stack(
          children: [
            // мягкая тень под баром
            Positioned.fill(
              top: 22,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kAlpha12.withOpacity(0.1),
                        blurRadius: 0,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                      BoxShadow(
                        color: AppColors.kGray200.withOpacity(0.1),
                        blurRadius: 0,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
            ),

            // стеклянный бар
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x80FFFFFF), // ~50%
                        Color(0x4DFFFFFF), // ~30%
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0x33FFFFFF),
                      width: 1,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<NewsSellerCubit>().like(_news.id!);

                          setState(() {
                            // ✅ обновляем локальное состояние _news, а не widget.news
                            _news = _news.copyWith(
                              isLiked: !(_news.isLiked ?? false),
                              like: (_news.isLiked ?? false)
                                  ? (_news.like ?? 0) - 1
                                  : (_news.like ?? 0) + 1,
                            );
                          });
                        },
                        child: Image.asset(
                          Assets.icons.likeFullIcon.path,
                          // ✅ isLiked — bool, без "?? false"
                          color: (_news.isLiked ?? false)
                              ? AppColors.mainPurpleColor
                              : AppColors.kGray200,
                          scale: 1.9,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${_news.like ?? 0}',
                          style: AppTextStyles.size14Weight500),
                      const SizedBox(width: 20),
                      Image.asset(
                        Assets.icons.viewTapeIcon.path,
                        color: AppColors.kLightBlackColor,
                        scale: 1.5,
                      ),
                      const SizedBox(width: 8),
                      Text('${_news.views ?? 0}',
                          style: AppTextStyles.size14Weight500),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
