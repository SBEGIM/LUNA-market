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
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: Icon(
                Icons.search,
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
      body: Column(
        children:  [
          InkWell(
            onTap: (){
 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  UnderCatalogPage()),
  );
            },
            child: const CatalogListTile(
              title: 'Cмартфоны',
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          const CatalogListTile(
            title: 'Компьютеры',
          ),
          const Divider(
            color: Colors.black,
          ),
          const CatalogListTile(
            title: 'ТВ',
          ),
          const Divider(
            color: Colors.black,
          ),
          const CatalogListTile(
            title: 'Аксессуары',
          ),
          const Divider(
            color: Colors.black,
          ),
          const CatalogListTile(
            title: 'Игрушки',
          ),
          const Divider(
            color: Colors.black,
          ),
          const CatalogListTile(
            title: 'Кухня',
          ),
          const Divider(
            color: Colors.black,
          ),
          const CatalogListTile(
            title: 'Кухня',
          ),
          const Divider(
            color: Colors.black,
          ),
          const CatalogListTile(
            title: 'Cмартфоны',
          ),
          const Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class CatalogListTile extends StatelessWidget {
  final String title;
  const CatalogListTile({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/icons/phone.svg',
        height: 30,
      ),
      title: Text(
        title,
        style: AppTextStyles.catalogTextStyle,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.kPrimaryColor,
      ),
    );
  }
}
