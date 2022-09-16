import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/widgets/detail_card_product_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/filter_page.dart';

import 'package:haji_market/features/drawer/presentation/widgets/products_card_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset('assets/icons/share.svg'))
          ],
          leadingWidth: 11,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.kGray300,
                ),
                hintText: 'Поиск',
                hintStyle: TextStyle(
                  color: AppColors.kGray300,
                  fontSize: 18,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )),
      body: ListView(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.kBackgroundColor,
            padding: const EdgeInsets.all(9),
            child: const Text(
              'Компьютеры',
              style: TextStyle(
                  color: AppColors.kGray900,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 6,
                        children: [
                          chipCat('Гаджеты', AppColors.kPrimaryColor),
                          chipCat('Аксессуары', AppColors.kPrimaryColor),
                          chipCat('Смартфоны', AppColors.kPrimaryColor),
                          chipCat('Радиотелефоны', AppColors.kPrimaryColor),
                        ],
                      ),
                    )),
                const Divider(
                  color: AppColors.kGray400,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Stack(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          chipWithDropDown('Цена'),
                          chipWithDropDown('Бренд'),
                          chipWithDropDown('Продавцы'),
                          chipWithDropDown('Высокий рейтинг'),
                          chipWithDropDown('Бренд'),
                          chipWithDropDown('Продавцы'),
                          chipWithDropDown('Высокий рейтинг'),
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    child: IconButton(
                      icon: SvgPicture.asset('assets/icons/filter.svg'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FilterPage()),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 12),
            child: Text(
              'Найдено 19245 товаров',
              style: AppTextStyles.kGray400Text,
            ),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailCardProductPage()),
                      );
                    },
                    child: const ProductCardWidget());
              }),

          // ProductCardWidget()
        ],
      ),
    );
    // chip('sdfasdf', Colors.red),
  }
}

Widget chip(
  String label,
  Color color,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 1.0,

    // shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}

Widget chipCat(
  String label,
  Color color,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 1.0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10))),
    // shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}

Widget chipDate(
  String label,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: AppColors.kGray900,
      ),
    ),
    backgroundColor: const Color(0xFFEBEDF0),
    // elevation: 1.0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4))),
    // shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}

Widget chipWithDropDown(
  String label,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppColors.kGray400,
          size: 16,
        )
      ],
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.kGray2), //the outline color
        borderRadius: BorderRadius.all(Radius.circular(10))),
    padding: const EdgeInsets.all(6.0),
  );
}
