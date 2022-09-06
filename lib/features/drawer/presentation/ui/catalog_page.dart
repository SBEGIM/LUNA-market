import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/widgets/under_catalog_page.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: SvgPicture.asset('assets/icons/share.svg'))
          ],

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
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UnderCatalogPage()),
              );
            },
            child: const CatalogListTile(
              title: 'Cмартфоны',
              url: 'assets/icons/cat1.svg',
            ),
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          const CatalogListTile(
            title: 'Компьютеры',
            url: 'assets/icons/cat2.svg',
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          const CatalogListTile(
            title: 'ТВ',
            url: 'assets/icons/cat3.svg',
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          const CatalogListTile(
            title: 'Аксессуары',
            url: 'assets/icons/cat4.svg',
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          const CatalogListTile(
            title: 'Игрушки',
            url: 'assets/icons/cat1.svg',
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          const CatalogListTile(
            title: 'Кухня',
            url: 'assets/icons/cat1.svg',
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          const CatalogListTile(
            title: 'Кухня',
            url: 'assets/icons/cat1.svg',
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          const CatalogListTile(
            title: 'Cмартфоны',
            url: 'assets/icons/cat1.svg',
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
        ],
      ),
    );
  }
}

class CatalogListTile extends StatelessWidget {
  final String title;
  final String url;
  const CatalogListTile({
    required this.url,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        url,
        // 'assets/icons/phone.svg',
        height: 30,
      ),
      title: Text(
        title,
        style: AppTextStyles.catalogTextStyle,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.kPrimaryColor,
      ),
    );
  }
}
