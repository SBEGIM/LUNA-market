import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/favorite/presentation/widgets/product_review_page.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: AppColors.kPrimaryColor,
        //   ),
        // ),
        centerTitle: true,
        title: const Text('Способ доставки', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/wireles.png', height: 64),
                    const Padding(
                      padding: EdgeInsets.only(left: 13, bottom: 43),
                      child: Text(
                        'Заказ 1 (Sulpak)',
                        style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          // устанавливаем индекс выделенного элемента
                          _selectedIndex = index;
                        });
                      },
                      child: const AddressShop(),
                    );
                  },
                ),
                const Divider(),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/check_circle_no_selected.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Доставка',
                            style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '1 июля, бесплатно',
                            style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'г. Алматы, Шевченко 90 (БЦ Каратал)',
                            style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Изменить адрес самовывоза',
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductReviewPage()),
            );
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
              'Перейти к оплате',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class AddressShop extends StatelessWidget {
  const AddressShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/check_circle.svg'),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Доставка',
                style: TextStyle(
                  color: AppColors.kGray900,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1 июля, бесплатно',
                style: TextStyle(
                  color: AppColors.kGray900,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'г. Алматы, Шевченко 90 (БЦ Каратал)',
                style: TextStyle(
                  color: AppColors.kGray900,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Изменить адрес самовывоза',
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
