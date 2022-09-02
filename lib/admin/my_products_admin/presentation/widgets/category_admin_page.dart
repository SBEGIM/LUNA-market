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
     

     List<String > text = [
      'Все категории','Компьютеры','Периферия','Настольные компьютеры'
     ];
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
      body: Container(
        color: Colors.white,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  setState(() {
                    // устанавливаем индекс выделенного элемента
                    _selectedIndex = index;

                  });
                },
                child: ListTile(
                  selected: index == _selectedIndex,
                  // leading: SvgPicture.asset('assets/temp/kaz.svg'),
                  title:  Text(
                  text[index],
                    style: AppTextStyles.appBarTextStyle,
                  ),
                  trailing: _selectedIndex == index
                      ? SvgPicture.asset(
                          'assets/icons/done.svg',
                        )
                      : const SizedBox(),
                ));
          },
        ),
      ),
       bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
             Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  CreateProductPage()),
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
