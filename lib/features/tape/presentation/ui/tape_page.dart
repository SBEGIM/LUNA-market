import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/tape/presentation/widgets/tape_card_widget.dart';

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
        title: PopupMenuButton(
          onSelected: (value) {
            // your logic
            // if (value == 0) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => CategoryAdminPage()),
            //   );
            // }
          },
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                child: Row(
                  children: [
                    Text(
                      "Добавить товар",
                      style: TextStyle(color: Colors.black),
                    ),
                    SvgPicture.asset('assets/icons/lenta1.svg'),
                  ],
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Text("Добавить видео"),
                    SvgPicture.asset('assets/icons/lenta2.svg'),
                  ],
                ),
                value: 1,
              ),
            ];
          },
          child: Text(
            'Лента',
            style: TextStyle(
                color: AppColors.kGray900,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          // Icon(Icons.done,color: AppColors.kPrimaryColor,size: 16,)
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(1),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 1 / 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
        ),
        children:const [
          TapeCardWidget(),
        ],
      ),
    );
  }
}


