import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/utils/url_util.dart';
import 'package:haji_market/src/feature/app/widgets/shimmer_box.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/advert_bottom_sheet.dart';
import 'package:haji_market/src/feature/home/bloc/banners_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/banners_state.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannersCubit, BannersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is LoadedState) {
            //  return Container(
            //    height: 100,
            // width: 100,
            // child: Row(children:  <Widget>[
            return Container(
              color: Colors.white,
              height: 273,
              child: CarouselSlider.builder(
                carouselController: carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  height: 273, // (context.screenSize.width - 32) * 9 / 16,
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
            );
          } else {
            return Container(
              color: Colors.white,
              height: 273,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ShimmerBox(
                  height: 218,
                  width: MediaQuery.of(context).size.width - 32,
                  radius: 8,
                ),
              ),
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
        });
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => BonusPage(
        //             name: title,
        //             bonus: bonus,
        //             date: date,
        //             image: image,
        //             url: url,
        //             description: description,
        //           )),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 218,
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage("https://lunamarket.ru/storage/$image"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.only(top: 40, left: 12),
                //   child: Text(
                //     title,
                //     style: AppTextStyles.bannerTextStyle,
                //   ),
                // ),
                // Container(
                //   width: 46,
                //   height: 22,
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   margin: const EdgeInsets.only(top: 12, left: 12),
                //   alignment: Alignment.center,
                //   child: Text(
                //     "${bonus.toString()}% Б",
                //     style: AppTextStyles.bannerTextStyle,
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                Positioned(
                  right: 20,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
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
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 4.0, right: 4, top: 4, bottom: 4),
                        child: Text(
                          'РЕКЛАМА',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                )
                //   Positioned(
                //     right: 20,
                //     bottom: 20,
                //     child: GestureDetector(
                //       onTap: () async {
                //         await showModalBottomSheet(
                //           context: context,
                //           backgroundColor: Colors.transparent,
                //           isScrollControlled: true,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10.0),
                //           ),
                //           // isDismissible: true,
                //           builder: (context) {
                //             return DraggableScrollableSheet(
                //               initialChildSize: 0.30, //set this as you want
                //               maxChildSize: 0.30, //set this as you want
                //               minChildSize: 0.30, //set this as you want
                //               builder: (context, scrollController) {
                //                 return Container(
                //                   padding: const EdgeInsets.all(16),
                //                   color: Colors.white,
                //                   child: ListView(
                //                     controller: scrollController,
                //                     children: [
                //                       const SizedBox(height: 16),
                //                       const Text(
                //                         'Рекламный баннер',
                //                         style: TextStyle(
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.w500),
                //                         textAlign: TextAlign.center,
                //                       ),
                //                       const SizedBox(height: 16),
                //                       // GestureDetector(
                //                       //   onTap: () {
                //                       //     // Get.to(const ContractOfSale());
                //                       //   },
                //                       //   child: Container(
                //                       //     padding: const EdgeInsets.only(
                //                       //         top: 8, left: 16),
                //                       //     alignment: Alignment.centerLeft,
                //                       //     child: Text(
                //                       //       '${widget.description}',
                //                       //       style: const TextStyle(
                //                       //           fontSize: 14,
                //                       //           color:
                //                       //               AppColors.kPrimaryColor),
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                       // const Text(
                //                       //   'Мы помогаем нашим продавцам рассказать об их товарах на LUNA market.Для этого у нас есть разные способы продвижения. Узнать больше о рекламе на LUNA market',
                //                       //   style: TextStyle(
                //                       //       fontSize: 12,
                //                       //       fontWeight: FontWeight.w400),
                //                       //   textAlign: TextAlign.center,
                //                       // ),
                //                       // const SizedBox(height: 16),

                //                       Container(
                //                         alignment: Alignment.bottomLeft,
                //                         child: Row(
                //                           children: [
                //                             const Text(
                //                               'Описание:',
                //                               style: TextStyle(
                //                                 fontSize: 14,
                //                               ),
                //                             ),
                //                             const SizedBox(width: 4),
                //                             Text(
                //                               description,
                //                               style: const TextStyle(
                //                                   fontSize: 14,
                //                                   color: AppColors.kPrimaryColor),
                //                             ),
                //                           ],
                //                         ),
                //                       ),

                //                       const SizedBox(height: 50),

                //                       Container(
                //                         alignment: Alignment.bottomLeft,
                //                         child: Row(
                //                           children: [
                //                             const Icon(Icons.link),
                //                             const SizedBox(width: 10),
                //                             const Text(
                //                               'Ссылка:',
                //                               style: TextStyle(
                //                                 fontSize: 14,
                //                               ),
                //                             ),
                //                             const SizedBox(width: 4),
                //                             InkWell(
                //                               onTap: () {
                //                                 UrlUtil.launch(context, url: url);
                //                               },
                //                               child: Text(
                //                                 url,
                //                                 style: const TextStyle(
                //                                     fontSize: 14,
                //                                     color:
                //                                         AppColors.kPrimaryColor),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 );
                //               },
                //             );
                //           },
                //         );
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: Colors.grey.withOpacity(0.2),
                //             borderRadius: BorderRadius.circular(6)),
                //         child: const Padding(
                //           padding: EdgeInsets.only(
                //               left: 4.0, right: 4, top: 4, bottom: 4),
                //           child: Text(
                //             'РЕКЛАМА',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: Colors.grey,
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w400),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
            // const SizedBox(
            //   height: 7,
            // ),
            // //8
            // Text(date,
            //     style: const TextStyle(
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //       color: Color.fromRGBO(173, 176, 181, 1),
            //     )),
          ],
        ),
      ),
    );
  }
}
