import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/tape_admin/presentation/ui/widgets/show_alert_tape_widget.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/home/presentation/widgets/gridlayout_categor.dart';

// import '../widgets/grid_tape_list.dart';

class TapeAdminPage extends StatefulWidget {
  TapeAdminPage({Key? key}) : super(key: key);

  @override
  State<TapeAdminPage> createState() => _TapeAdminPageState();
}

class _TapeAdminPageState extends State<TapeAdminPage> {
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
        title: const Text(
          "Лента",
          style: AppTextStyles.appBarTextStylea,
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
                    style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, top: 5),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(3),
                        child: InkWell(
                          onTap: () {
                            showAlertTapeWidget(context);
                            // showAlertStaticticsWidget(context);
                          },
                          child: const Icon(
                            Icons.more_vert_outlined,
                            color: AppColors.kPrimaryColor,
                          ),
                        ))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
