import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/app/widgets/custom_switch_button.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import 'package:haji_market/features/drawer/data/bloc/review_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/review_state.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/punkts_widget.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/constants.dart';
import '../../../chat/presentation/chat_page.dart';
import '../../../chat/presentation/message.dart';
import '../../../tape/presentation/data/bloc/subs_cubit.dart';
import '../../data/models/product_model.dart';

@RoutePage()
class DetailStorePage extends StatefulWidget {
  final Shops shop;
  const DetailStorePage({required this.shop, Key? key}) : super(key: key);

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
            // Navigator.pop(context);
            context.router.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        title: Text(
          '${widget.shop.shop!.name}',
          style: const TextStyle(color: AppColors.kGray900, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: SvgPicture.asset('assets/icons/share.svg'))
        // ],
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
                      errorBuilder: (context, error, stackTrace) => const ErrorImageWidget(
                        height: 50,
                        width: 50,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Дата регистрации: ${widget.shop.shop!.createdAt}',
                          //  maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w500),
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
                              style:
                                  TextStyle(color: AppColors.kPrimaryColor, fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          //  Get.to(() => const ChatPage());

                          Get.to(Message(
                              userId: widget.shop.shop?.id,
                              name: widget.shop.shop?.name,
                              avatar: widget.shop.shop?.image,
                              chatId: null));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Container(
                            width: 168,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.kPrimaryColor),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0x331DC4CF),
                              // : const Color.fromRGBO(29, 196, 207, 0.2),
                            ),
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                            child: const Text(
                              ' Написать',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.kPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            BlocProvider.of<SubsCubit>(context).sub(widget.shop.shop!.id.toString());
                            isSelected = !isSelected;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 168,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.kPrimaryColor),
                              borderRadius: BorderRadius.circular(10),
                              color: isSelected == true ? Colors.white : const Color(0x331DC4CF),
                              // : const Color.fromRGBO(29, 196, 207, 0.2),
                            ),
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                            child: Text(
                              isSelected == true ? 'Подписаться' : 'Вы подписаны',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.kPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
          const Divider(
            height: 1,
            color: AppColors.kGray300,
          ),
          GestureDetector(
            onTap: () => launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false),
            child: Container(
              height: 56,
              padding: EdgeInsets.only(left: 16),
              color: Colors.white,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.forum,
                    color: AppColors.kPrimaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Чат с поддержкой',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
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
                GestureDetector(
                  onTap: () {
                    final List<int> _selectedListSort = [];

                    _selectedListSort.add(widget.shop.shop!.id as int);

                    GetStorage().write('shopFilterId', _selectedListSort.toString());

                    context.router.push(ProductsRoute(
                      cats: Cats(id: 0, name: ''),
                      shopId: widget.shop.shop!.id.toString(),
                    ));
                    // Get.to(ProductsPage(
                    //   cats: Cats(id: 0, name: ''),
                    //   shopId: widget.shop.shop!.id.toString(),
                    // ));
                  },
                  child: ListTile(
                      leading: Text(
                        'Все товары ${widget.shop.shop!.name}',
                        style:
                            const TextStyle(color: AppColors.kPrimaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kPrimaryColor,
                        size: 16,
                      )),
                ),
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
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Пункты самовывоза',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black
                              // : const Color(0xff9B9B9B),
                              ),
                        ),
                      ),
                      1: Container(
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
                    },
                    onValueChanged: (int? value) async {
                      if (value != null && value != 1) {
                        segmentValue = value;
                      } else {
                        Get.snackbar('Нет доступа', 'временно не доступен', backgroundColor: Colors.orangeAccent);
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
            children: const [
              PunktsWidget(),
              SizedBox()
              // ReviewsWidget(),
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

class ReviewsWidget extends StatefulWidget {
  final String product_id;
  ReviewsWidget({
    required this.product_id,
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  int rating = 0;
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<ReviewCubit>(context).reviews(widget.product_id);
    super.initState();
  }

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
          Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8, left: 16),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Отзывы',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    //  height: 300,
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: const TextSpan(
                              //  style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "4.8",
                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black),
                                ),
                                TextSpan(
                                  text: " из 5",
                                  style:
                                      TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 65,
                          margin: const EdgeInsets.only(top: 0, left: 98),
                          child: ListView.builder(
                              itemCount: 5,
                              // scrollDirection: Axis.vertical,
                              reverse: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: index.toDouble(),
                                      ignoreGestures: true,
                                      itemSize: 13,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    Stack(
                                      children: [
                                        Container(height: 4, width: 186, color: Color(0xffe5f1ff)),
                                        Container(height: 4, width: index.toDouble() * 10, color: Color(0xffFFC107))
                                      ],
                                    )
                                  ],
                                );
                              }),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 55),
                          child: const Text(
                            '98 отзывов',
                            style: TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 1,
            color: AppColors.kGray300,
          ),
          BlocConsumer<ReviewCubit, ReviewState>(
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
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }

                if (state is LoadedState) {
                  return Container(
                      height: state.reviewModel.length != 0 ? (80 * state.reviewModel.length.toDouble()) : 20,
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.reviewModel.length,
                        itemBuilder: (context, index) {
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${state.reviewModel[index].user!.name}',
                                      style: const TextStyle(
                                          color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    RatingBar.builder(
                                      initialRating: state.reviewModel[index].rating!.toDouble(),
                                      minRating: 1,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (value) {
                                        rating = value.toInt();
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${state.reviewModel[index].date}',
                                  style: const TextStyle(
                                      color: AppColors.kGray300, fontWeight: FontWeight.w500, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${state.reviewModel[index].text}',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                          ;
                        },
                      ));
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }
              }),
          const Divider(
            height: 1,
            color: AppColors.kGray300,
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
            color: Colors.white,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Оставьте отзыв',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    itemSize: 15,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      rating = value.toInt();
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _commentController,
                maxLines: 5,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Напишите отзывь', border: InputBorder.none),
              ),
              GestureDetector(
                onTap: () async {
                  await BlocProvider.of<ReviewCubit>(context)
                      .reviewStore(_commentController.text, rating.toString(), '28');
                  _commentController.clear();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 39,
                  width: 209,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(
                          0.2,
                          0.2,
                        ), //Offset
                        blurRadius: 0.1,
                        spreadRadius: 0.1,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: const Text(
                    'Оставить свой отзыв',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
