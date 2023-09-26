import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/widgets/credit_info_detail_page.dart';

class CreditInfoPage extends StatefulWidget {
  const CreditInfoPage({Key? key}) : super(key: key);

  @override
  State<CreditInfoPage> createState() => _CreditInfoPageState();
}

class _CreditInfoPageState extends State<CreditInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Рассрочка',
          style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          shrinkWrap: true,

          children: [
            Container(
              height: 12,
              color: AppColors.kBackgroundColor,
            ),
            // InkWell(
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //       builder: (context) =>
            //     //           CreditInfoDetailPage(title: 'Плати Долями')),
            //     // );

            //     Get.snackbar('Нет доступа!', 'Временно не доступен..',
            //         backgroundColor: Colors.orangeAccent);
            //   },
            //   child: const DrawerListTile(
            //     text: 'Плати Долями',
            //   ),
            // ),
            // const Divider(
            //   color: AppColors.kGray200,
            // ),
            // InkWell(
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //       builder: (context) =>
            //     //           CreditInfoDetailPage(title: 'Рассрочка Тинькофф')),
            //     // );
            //     Get.snackbar('Нет доступа!', 'Временно не доступен..',
            //         backgroundColor: Colors.orangeAccent);
            //   },
            //   child: const DrawerListTile(
            //     text: 'Рассрочка Тинькофф',
            //   ),
            // ),
            const Divider(
              color: AppColors.kGray200,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreditInfoDetailPage(title: 'Рассрочка HALAL')),
                );
              },
              child: const DrawerListTile(
                text: 'Рассрочка HALAL',
              ),
            ),
            const Divider(
              color: AppColors.kGray200,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String text;
  const DrawerListTile({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppTextStyles.drawer2TextStyle,
          ),
          SvgPicture.asset('assets/icons/back_menu.svg')
        ],
      ),
    );
  }
}
