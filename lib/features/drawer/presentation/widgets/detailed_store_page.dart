import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/features/app/widgets/custom_switch_button.dart';
import 'package:haji_market/features/drawer/presentation/widgets/punkts_widget.dart';

import '../../../../core/common/constants.dart';
import '../../../tape/presentation/data/bloc/subs_cubit.dart';
import '../../data/models/product_model.dart';

class DetailStorePage extends StatefulWidget {
  final Shops shop;
  DetailStorePage({required this.shop, Key? key}) : super(key: key);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState();
}

class _DetailStorePageState extends State<DetailStorePage> {
  int segmentValue = 0;
  // List<bool>? isSelected;
  int index = 0;
  bool isSelected = false;
  // @override
  // void initState() {
  //   isSelected = [true, false];
  //   super.initState();
  // }

  @override
  void initState() {
    isSelected = widget.shop.inSubs!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        title: Text(
          '${widget.shop.shop!.name}',
          style: const TextStyle(
              color: AppColors.kGray900,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset('assets/icons/share.svg'))
        ],
      ),
      // appBar: ,
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
              // padding: const EdgeInsets.only(
              //   left: 16,
              //   // right: 16,
              // ),
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    minVerticalPadding: 14,
                    leading: Image.network(
                      'http://80.87.202.73:8001/storage/${widget.shop.shop!.image}',
                      width: 50,
                      height: 50,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Дата регистрации: ${widget.shop.shop!.createdAt}',
                          //  maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppColors.kGray300,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBar(
                          ignoreGestures: true,
                          initialRating: 2,
                          unratedColor: const Color(0x30F11712),
                          itemSize: 15,
                          // itemPadding:
                          // const EdgeInsets.symmetric(horizontal: 4.0),
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                            half: const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                            empty: const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/icons/check_circle.svg'),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Более 1 000 успешных продаж',
                              style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        BlocProvider.of<SubsCubit>(context)
                            .sub(widget.shop.shop!.id.toString());
                        isSelected = !isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.kPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected == true
                              ? Colors.white
                              : const Color(0x331DC4CF),
                          // : const Color.fromRGBO(29, 196, 207, 0.2),
                        ),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: Text(
                          isSelected == true ? 'Подписаться' : 'Вы подписаны',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // const Divider(
                //   color: AppColors.kGray300,
                // ),
                // ListTile(
                //   minLeadingWidth: 10,
                //   leading: SvgPicture.asset('assets/icons/message.svg'),
                //   title: const Text(
                //     'Чат с поддержкой',
                //     style: TextStyle(
                //         color: AppColors.kGray900,
                //         fontSize: 16,
                //         fontWeight: FontWeight.w400),
                //   ),
                // ),
                const Divider(
                  height: 1,
                  color: AppColors.kGray300,
                ),
                ListTile(
                    leading: Text(
                      'Все товары ${widget.shop.shop!.name}',
                      style: const TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kPrimaryColor,
                      size: 16,
                    )),
                const Divider(
                  height: 1,
                  color: AppColors.kGray300,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomSwitchButton<int>(
                    groupValue: segmentValue,
                    children: {
                      0: Container(
                        alignment: Alignment.center,
                        height: 39,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Отзывы ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color:
                                  // segmentValue == 0
                                  Colors.black
                              // : const Color(0xff9B9B9B),
                              ),
                        ),
                      ),
                      1: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Пункты самовывоза',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black
                              // : const Color(0xff9B9B9B),
                              ),
                        ),
                      ),
                    },
                    onValueChanged: (int? value) async {
                      if (value != null) {
                        segmentValue = value;
                      }
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          IndexedStack(
            index: segmentValue,
            children: [
              ReviewsWidget(),
              PunktsWidget(),
            ],
          )

          // ReviewsWidget(),

          // IndexedStack(
          //   index: index,
          //   children: [],
          // ),
        ],
      ),
    );
  }
}

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Отзывы',
            style: TextStyle(
                color: AppColors.kGray900,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: "4.8",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: " из 5",
                  style: TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const Text(
            '98 отзывов',
            style: TextStyle(
                color: AppColors.kGray300,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ronald Richards',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        RatingBar(
                          ignoreGestures: true,
                          initialRating: 2,
                          unratedColor: const Color(0x30F11712),
                          itemSize: 15,
                          // itemPadding:
                          // const EdgeInsets.symmetric(horizontal: 4.0),
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                            half: const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                            empty: const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '14 мая 2021г.',
                      style: TextStyle(
                          color: AppColors.kGray300,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Here is some long text that I am expecting will go off of the screen.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //   Flexible(
                    //       child: Text(
                    //           'The Dropbox HQ in San Francisco is one of the best designed & most comfortable offices I have ever witnessed. Great stuff! If you happen to visit SanFran, dont miss the chance to witness it yourself. ',style: TextStyle(color: Colors.black),))
                    // ],
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
