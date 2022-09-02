import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/home/presentation/widgets/gridlayout_categor.dart';

import '../widgets/grid_tape_list.dart';

class TapePage extends StatefulWidget {
  TapePage({Key? key}) : super(key: key);

  @override
  State<TapePage> createState() => _TapePageState();
}

class _TapePageState extends State<TapePage> {
  final List<Map> myProducts =
      List.generate(6, (index) => {"id": index, "name": "Product "}).toList();

  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.kPrimaryColor,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: Icon(
              Icons.search,
            ),
          )
        ],
        title: DropdownButton(
            elevation: 0,
            icon: const Icon(
              Icons.keyboard_arrow_down_sharp,
              color: AppColors.kPrimaryColor,
              size: 40,
            ),
            items: [
              DropdownMenuItem(
                value: 1,
                child: Row(
                  children: [
                    const Text("Подписки"),
                    SvgPicture.asset('assets/icons/lenta1.svg'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Text("Избранное"),
                    SvgPicture.asset('assets/icons/lenta2.svg'),
                  ],
                ),
              )
            ],
            onChanged: (int? value) {
              setState(() {
                _value = value!;
              });
            },
            hint: const Text(
              "Лента",
              style: AppTextStyles.appBarTextStylea,
            )),
      ),
      body: GridView(
        padding: const EdgeInsets.all(1),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 1 / 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
        ),
        children: [
          Stack(
            children: [
              Image.asset('assets/images/tape.png'),
               Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent.withOpacity(0.4),
                  child: const Text(
                    'ZARA',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8.0, top: 12),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.rocket_launch_rounded)),
              ),
             
            ],
          ),
          
       
        ],
      ),
    );
  }
}
