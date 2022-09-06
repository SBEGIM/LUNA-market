import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/home/presentation/widgets/bonus_page.dart';

import '../../../drawer/presentation/ui/drawer_home.dart';

class StocksPage extends StatefulWidget {
  StocksPage({Key? key}) : super(key: key);

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerHome(),
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: const Icon(
        //   Icons.menu,
        //   color: AppColors.kPrimaryColor,
        // ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 22.0),
        //     child: Icon(
        //       Icons.search,
        //     ),
        //   )
        // ],
        title: const Text(
          'Акции',
          style: AppTextStyles.appBarTextStylea,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return const StocksCardWidget();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StocksCardWidget extends StatelessWidget {
  const StocksCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BonusPage()),
        );
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/stocks.png',
                  ),
                  const Padding(
                    padding:  EdgeInsets.only(left: 12.0, top: 12),
                    child: Text(
                      'Продукты',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(left: 12.0, top: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Padding(
                        padding:   EdgeInsets.only(
                            left: 8.0, right: 8, top: 4, bottom: 4),
                        child:  Text(
                          '5% Б',
                          style:  TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, bottom: 16, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '13 июня - 30 июня',
                      style: TextStyle(
                          color: AppColors.kGray300,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Продукты с доставкой!',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
