import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/utils/url_util.dart';
import 'package:haji_market/src/feature/app/widgets/shimmer_box.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/advert_bottom_sheet.dart';
import 'package:haji_market/src/feature/home/bloc/banners_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/banners_state.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  final CarouselSliderController carouselController = CarouselSliderController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        if (state is BannersStateError) {
          return Center(
            child: Text(state.message, style: const TextStyle(fontSize: 20.0, color: Colors.grey)),
          );
        }
        if (state is BannersStateLoaded) {
          return Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: CarouselSlider.builder(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  itemCount: state.banners.length,
                  itemBuilder: (context, index, realIndex) => Builder(
                    builder: (BuildContext context) {
                      return BannerImage(
                        index: index,
                        title: state.banners[index].title.toString(),
                        bonus: state.banners[index].bonus as int,
                        date: state.banners[index].date.toString(),
                        image: state.banners[index].path.toString(),
                        url: state.banners[index].url.toString(),
                        urlAdmin: state.banners[index].urlAdmin.toString(),
                        description: state.banners[index].description.toString(),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                //  width: 12,
                //  alignment: Alignment.r,
                //     margin: const EdgeInsets.only(
                // left: 154.0, right: 20, top: 260, bottom: 4),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.banners.length,
                      (item) => GestureDetector(
                        onTap: () {
                          _current = item;
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 16),
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: _current == item ? AppColors.kGray400 : AppColors.kGray2,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerBox(height: 120, width: double.infinity, radius: 16),
          );

          // Shimmer(
          //   duration: const Duration(seconds: 3), //Default value
          //   interval: const Duration(microseconds: 1), //Default Рекvalue: Duration(seconds: 0)
          //   color: Colors.white, //Default value
          //   colorOpacity: 0, //Default value
          //   enabled: true, //Default value
          //   direction: const ShimmerDirection.fromLTRB(), //Default Value
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       color: Colors.grey.withOpacity(0.6),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 16,
          //       ),
          //       child: SizedBox(
          //         height: 273,
          //         width: MediaQuery.of(context).size.width - 32,
          //       ),
          //     ),
          //   ),
          // );
        }
      },
    );
  }
}

class BannerImage extends StatelessWidget {
  final int index;
  final String title;
  final int bonus;
  final String date;
  final String image;
  final String url;
  final String urlAdmin;
  final String description;
  const BannerImage({
    Key? key,
    required this.index,
    required this.title,
    required this.bonus,
    required this.date,
    required this.image,
    required this.url,
    required this.urlAdmin,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        UrlUtil.launch(context, url: url);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: "https://lunamarket.ru/storage/$image",
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) {
                        return Container(
                          color: Colors.grey[100],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress, // 0..1 или null
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        isDismissible: true,
                        builder: (context) {
                          return AdvertBottomSheet(
                            url: url,
                            description: description,
                            urlAdmin: urlAdmin,
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 26,
                      width: 85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'РЕКЛАМА',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.size13Weight600.copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
