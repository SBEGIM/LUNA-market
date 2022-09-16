import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';

class DetailTapeCardPage extends StatefulWidget {
  DetailTapeCardPage({Key? key}) : super(key: key);

  @override
  State<DetailTapeCardPage> createState() => _DetailTapeCardPageState();
}

class _DetailTapeCardPageState extends State<DetailTapeCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: const Color(0xFFD9D9D9),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: Icon(
              Icons.search,
            ),
          )
        ],
        title: PopupMenuButton(
          onSelected: (value) {
            // your logic
            // if (value == 0) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => CategoryAdminPage()),
            //   );
            // }
          },
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                child: Row(
                  children: [
                    Text(
                      "Добавить товар",
                      style: TextStyle(color: Colors.black),
                    ),
                    SvgPicture.asset('assets/icons/lenta1.svg'),
                  ],
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Text("Добавить видео"),
                    SvgPicture.asset('assets/icons/lenta2.svg'),
                  ],
                ),
                value: 1,
              ),
            ];
          },
          child: Text(
            'Лента',
            style: TextStyle(
                color: AppColors.kGray900,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          // Icon(Icons.done,color: AppColors.kPrimaryColor,size: 16,)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned(
                top: 50, child: Image.asset('assets/images/bag_tape.png')),
            Padding(
              padding: const EdgeInsets.only(bottom: 250),
              child: Center(
                child: SvgPicture.asset('assets/icons/play_tape.svg'),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFFF3347),
                  borderRadius: BorderRadius.circular(4)),
              padding:
                  const EdgeInsets.only(left: 4, right: 4, bottom: 2, top: 2),
              child: const Text(
                '-10%',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: 381,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 2, top: 2),
                    child: const Text(
                      '0.0.12',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, bottom: 2, top: 2),
                    child: const Text(
                      '10% Б',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset('assets/images/sulpak.png')),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Sulpak',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/notification.svg',
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 4, bottom: 4),
                            child: Text(
                              'Перейти в магазин',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Черный рюкзак BANGE 22...',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      SvgPicture.asset('assets/icons/shop_cart.svg'),
                      const SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset('assets/icons/heart_outline.svg'),
                      const SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(
                        'assets/icons/share.svg',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Артикул: 1920983974',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            '28 000 ₸ ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '30 000 ₸ ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                      Row(
                        children: [
                     const     Text(
                            'в рассрочку',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                   const       SizedBox(
                            width: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4,
                                ),
                                color: const Color(
                                  0x30FFFFFF,
                                )),
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 4,
                              bottom: 4,
                            ),
                            child: const Text(
                              '10 000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'х3',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
