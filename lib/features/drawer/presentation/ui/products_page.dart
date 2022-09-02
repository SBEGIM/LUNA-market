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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                Icons.download_rounded,
              ),
            )
          ],
          title: const TextField(
            decoration: InputDecoration(
              hintText: 'Поиск',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.black,
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
              style: AppTextStyles.appBarTextStylea,
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
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          chip('Гаджеты',AppColors.kPrimaryColor),
                          chip('Аксессуары',AppColors.kPrimaryColor),
                          chip('Смартфоны',AppColors.kPrimaryColor),
                          chip('Радиотелефоны',AppColors.kPrimaryColor),
                        ],
                      ),
                    )),
                const Divider(
                  color: Colors.black,
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
            padding: EdgeInsets.all(8.0),
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
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}
Widget chipDate(
  String label,

) {
  return Chip(
    labelPadding: const EdgeInsets.all(1.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.grey.shade50,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}

Widget chipWithDropDown(
  String label,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}
