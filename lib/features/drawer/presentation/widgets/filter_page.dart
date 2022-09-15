import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/widgets/categories_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/sorting_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/stores_sellers_page.dart';
class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues values = const RangeValues(1, 100);
  RangeLabels labels = const RangeLabels('1', "100");
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    bool selectedView = false;
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 8),
            child: Text(
              'Отмена',
              style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
            ),
          ),
        ),
        // ),
        title: const Text(
          'Фильтр',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0, top: 20),
            child: Text(
              'Сбросить',
              style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Вид страницы ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        InkWell(
                            onTap: () {
                              selectedView = true;
                              setState(() {});
                            },
                            child: SvgPicture.asset('assets/icons/all_cat.svg')),
                        InkWell(
                            onTap: () {
                              selectedView = false;
                              setState(() {});
                            },
                            child: SvgPicture.asset('assets/icons/all_cat2.svg')),
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.kGray200,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SortingPage()),
                      );
                    },
                    child: const ListTile(
                        title: Text(
                          'Сортировка ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          'Популярные',
                          style: TextStyle(
                              color: AppColors.kGray300,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        trailing:
                            InkWell(child: Icon(Icons.arrow_forward_ios))),
                  ),
                  const Divider(
                    color: AppColors.kGray200,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesPage()),
                      );
                    },
                    child: const ListTile(
                        title: Text(
                          'Категории ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          'Компьютеры',
                          style: TextStyle(
                              color: AppColors.kGray300,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        trailing:
                            InkWell(child: Icon(Icons.arrow_forward_ios))),
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            // height: 200,
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Цена',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.kGray200,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'от ${values.start.toString()}',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.kGray200,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'до ${values.end.toString()}',
                      ),
                    ),
                  ],
                ),
                RangeSlider(
                  
                    divisions: 5,
                    activeColor: AppColors.kPrimaryColor,
                    inactiveColor: AppColors.kGray300,
                    min: 1,
                    max: 100,
                    values: values,
                    labels: labels,
                    onChanged: (value) {
                      print("START: ${value.start}, End: ${value.end}");
                      setState(() {
                        values = value;
                        // labels = RangeLabels(
                        //     "${value.start.toInt().toString()}\$",
                        //     "${value.start.toInt().toString()}\$");
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 13, right: 8, bottom: 13, top: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Бренд',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                  ],
                ),
                const Divider(
                  color: AppColors.kGray200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Показать все',
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kGray300,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(13),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Высокий рейтинг',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      // print(isSwitched);
                    });
                  },
                  activeTrackColor: AppColors.kPrimaryColor,
                  activeColor: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 13, right: 8, bottom: 13, top: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Продавцы',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                    chipBrand('Apple'),
                    chipBrand('ASUS'),
                    chipBrand('CYBER MARKET'),
                  ],
                ),
                const Divider(
                  color: AppColors.kGray200,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoresSellersPage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Показать все',
                        style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kGray300,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.kPrimaryColor,
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Показать 922 товара',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  Widget chipBrand(
    String label,
  ) {
    return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label:Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
    backgroundColor: Colors.white,
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
}
