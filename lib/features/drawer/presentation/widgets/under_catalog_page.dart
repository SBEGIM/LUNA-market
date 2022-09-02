import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';

class UnderCatalogPage extends StatefulWidget {
  UnderCatalogPage({Key? key}) : super(key: key);

  @override
  State<UnderCatalogPage> createState() => _UnderCatalogPageState();
}

class _UnderCatalogPageState extends State<UnderCatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.kBackgroundColor,
            padding: const EdgeInsets.all(9),
            child: const Text(
              'Смартфоны',
              style: AppTextStyles.appBarTextStylea,
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: (){
 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  const ProductsPage()),
  );
                },
                child: const UnderCatalogListTile(title: 'Все товары',)),
               const Divider(
                color: Colors.black,
              ),
               const UnderCatalogListTile(title: 'Кабели для моб телефонов',),
               const Divider(
                color: Colors.black,
              ),
               const UnderCatalogListTile(title: 'Держатели для телефонов',),
               const Divider(
                color: Colors.black,
              ),
               const UnderCatalogListTile(title: 'Пауэрбенк',),
               const Divider(
                color: Colors.black,
              ),
               const UnderCatalogListTile(title: 'Ремешки',),
               const Divider(
                color: Colors.black,
              ),
               const UnderCatalogListTile(title: 'Батареи',),
               const Divider(
                color: Colors.black,
              ),
                 const UnderCatalogListTile(title: 'Чехлы',),
               const Divider(
                color: Colors.black,
              ),
                 const UnderCatalogListTile(title: 'Стикеры',),
               const Divider(
                color: Colors.black,
              ),
                 const UnderCatalogListTile(title: 'Беспроводные зарядки',),
               const Divider(
                color: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UnderCatalogListTile extends StatelessWidget {
  final String title;
  const UnderCatalogListTile({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(title,style: AppTextStyles.chanheLangTextStyle,),
           const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
