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
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.kBackgroundColor,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: const Text(
              'Смартфоны',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kGray900),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductsPage()),
                    );
                  },
                  child: const UnderCatalogListTile(
                    title: 'Все товары',
                  )),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Кабели для моб телефонов',
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Держатели для телефонов',
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Пауэрбенк',
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Ремешки',
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Батареи',
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Чехлы',
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Стикеры',
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              const UnderCatalogListTile(
                title: 'Беспроводные зарядки',
              ),
              const Divider(
                color: AppColors.kGray300,
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
          Text(
            title,
            style: AppTextStyles.chanheLangTextStyle,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.kPrimaryColor,
            size: 16,
          ),
        ],
      ),
    );
  }
}
