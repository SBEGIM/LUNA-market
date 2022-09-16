import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/create_product_page.dart';
import 'package:haji_market/core/common/constants.dart';

import '../../../../features/app/widgets/custom_back_button.dart';

class CategoryAdminPage extends StatefulWidget {
  CategoryAdminPage({Key? key}) : super(key: key);

  @override
  State<CategoryAdminPage> createState() => _CategoryAdminPageState();
}

class _CategoryAdminPageState extends State<CategoryAdminPage> {
  int _selectedIndex = -1;
  int _selectedIndex2 = -1;

  List<String> text = [
    'Все категории',
    'Компьютеры',
  ];
  List<String> allText = [
    'Периферия',
    'Настольные компьютеры',
    'Периферия',
    'Периферия'
  ];

  bool visibile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Категории',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Divider(
                  color: Colors.grey.shade400,
                ),
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.grey.shade400,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: text.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          setState(() {
                            // устанавливаем индекс выделенного элемента
                            _selectedIndex = index;
                            visibile = !visibile;
                          });
                        },
                        child: ListTile(
                          selected: index == _selectedIndex,
                          // leading: SvgPicture.asset('assets/temp/kaz.svg'),
                          title: Text(
                            text[index],
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing: _selectedIndex == index
                              ? SvgPicture.asset(
                                  'assets/icons/check_circle.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/circle.svg',
                                ),
                        ));
                  },
                ),
                Visibility(
                  visible: visibile,
                  child: Divider(
                    color: Colors.grey.shade400,
                  ),
                ),
                Visibility(
                  visible: visibile,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.grey.shade400,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // padding: EdgeInsets.all(16),
                    itemCount: allText.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              // устанавливаем индекс выделенного элемента
                              _selectedIndex2 = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: ListTile(
                              selected: index == _selectedIndex2,
                              // leading: SvgPicture.asset('assets/temp/kaz.svg'),
                              title: Text(
                                allText[index],
                                style: const TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: _selectedIndex2 == index
                                  ? SvgPicture.asset(
                                      'assets/icons/check_circle.svg',
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/circle.svg',
                                    ),
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateProductPage()),
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
                'Готово',
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
