import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';

class BonusDetailPage extends StatefulWidget {
  const BonusDetailPage({Key? key}) : super(key: key);

  @override
  State<BonusDetailPage> createState() => _BonusDetailPageState();
}

class _BonusDetailPageState extends State<BonusDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: SvgPicture.asset('assets/icons/share.svg'),
          ),
        ],
        title: const Text(
          'Дарим 5% бонусов',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F1F1F)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 16),
                  child: Text(
                    'Дарим 5% бонусов в магазинах Вашего города',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Stack(
                  children: [
                    Center(
                        child: Image.asset('assets/images/card_product.png')),
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0, top: 60),
                      child: Text(
                        'Продукты',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, top: 22),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, right: 8, top: 4, bottom: 4),
                          child: Text(
                            '5% Б',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0, top: 160),
                      child: Text(
                        'с 15 по 17 июля',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            child: const ListTile(
              title: Text(
                'Magnum',
                style: TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                'Магазинов: 8',
                style: TextStyle(
                    color: AppColors.kGray300,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: const ListTile(
              title: Text(
                'Small',
                style: TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                'Магазинов: 8',
                style: TextStyle(
                    color: AppColors.kGray300,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
