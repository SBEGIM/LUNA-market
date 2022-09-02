import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';

import '../../../home/presentation/widgets/banner_watceh_recently_widget.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: Icon(
                Icons.ios_share_rounded,
              ),
            )
          ],
          title: const Text(
            'Корзина',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return const BasketProductCardWidget();
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Вас могут заинтересовать',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    BannerWatcehRecently(),
                    BannerWatcehRecently(),
                  ],
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () {
            
            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Продолжить',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}

class BasketProductCardWidget extends StatelessWidget {
  const BasketProductCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 4, right: 16, top: 8, bottom: 8),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        // blurRadius: 4,
                        color: Colors.white,
                      ),
                    ]),
                // height: MediaQuery.of(context).size.height * 0.86,
                // color: Colors.red,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/wireles.png',
                          height: 104,
                          width: 104,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                '556 900 ₸ ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Text(
                                '556 900 ₸ ',
                                style: TextStyle(
                                  color: AppColors.kGray900,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '556 900 ₸/1 шт',
                            style: TextStyle(
                              color: AppColors.kGray300,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Silver MacBook M1 13.1in.\nApple 256GB',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.kGray900,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Продавец: Sulpak',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.kGray900,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Доставка: сегодня',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.kGray900,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.kPrimaryColor,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      const Text('1'),
                      const SizedBox(
                        width: 14,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.kPrimaryColor,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Удалить',
                    style: const TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text('Выберите карту, чтобы поделиться')
      ],
    );
  }
}
