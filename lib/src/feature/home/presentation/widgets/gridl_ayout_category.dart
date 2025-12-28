import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GridLayoutCategory {
  String? title;
  String? icon;
  String? image;
  List<CatsModel>? catOptions;
  void Function()? onTap;

  GridLayoutCategory({this.title, this.icon, this.onTap, this.image, this.catOptions});
}

class GridOptionsCategory extends StatelessWidget {
  final GridLayoutCategory layout;
  const GridOptionsCategory({super.key, required this.layout});

  @override
  Widget build(BuildContext context) {
    const double imageSize = 80;

    final String imageUrl = layout.title != 'Все категории'
        ? 'https://lunamarket.ru/storage/${layout.image ?? ''}'
        : 'https://lunamarket.ru/img/all_cats.png';
    // Шиммер исчезнет, когда картинка окажется в кеше/загрузится
    final Future<void> precache = precacheImage(NetworkImage(imageUrl), context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: layout.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.mainBackgroundPurpleColor,
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: const BoxConstraints(minHeight: 120),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Заголовок
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8, // если нужно не перекрывать картинку: right: imageSize + 16,
                  child: Text(
                    layout.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.size13Weight500,
                  ),
                ),

                // Картинка
                Positioned(
                  right: 8,
                  bottom: 4,
                  child: SizedBox(
                    height: imageSize,
                    width: imageSize,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,

                        progressIndicatorBuilder: (context, url, downloadProgress) {
                          return Container(
                            color: Colors.grey.shade100,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress, // может быть null
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },

                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade100,
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),

                // ФУЛЛ-ШАР ШИММЕР: поверх всей карточки, пока картинка не готова
                Positioned.fill(
                  child: FutureBuilder<void>(
                    future: precache,
                    builder: (context, snapshot) {
                      final bool loading = snapshot.connectionState != ConnectionState.done;
                      // если была ошибка загрузки — убираем оверлей, пусть покажется errorBuilder
                      final bool show = loading && !snapshot.hasError;

                      return IgnorePointer(
                        ignoring: true, // тапы проходят сквозь оверлей
                        child: AnimatedOpacity(
                          opacity: show ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          child: Shimmer(
                            // shimmer_animation: Shimmer(child: ...)
                            child: Container(
                              // лёгкая подложка, чтобы блик был заметен
                              color: Colors.white.withValues(alpha: 0.06),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
