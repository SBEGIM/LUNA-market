import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        leading:  GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
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
          color: const Color.fromRGBO(230,231,232,1),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Подписки",
                      style: TextStyle(color: Colors.black),
                    ),
                    SvgPicture.asset('assets/icons/lenta1.svg'),
                  ],
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Избранное"),
                    SvgPicture.asset('assets/icons/lenta2.svg'),
                  ],
                ),
                value: 1,
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.only(left: 100),
            child:Row(
              children: [
                Text(
                  'Лента',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 5),
                Image.asset('assets/icons/down.png' , height: 16.5, width: 9.5,)
              ],
            )
          
          ), // Icon(Icons.done,color: AppColors.kPrimaryColor,size: 16,)
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


