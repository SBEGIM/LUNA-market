import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;

  // void toggleSwitch(int value) {
  //   value == 1 ? !isSwitched1 : !isSwitched1;
  //   value == 2 ? !isSwitched2 : !isSwitched2;
  //   value == 3 ? !isSwitched3 : !isSwitched3;

  //   setState(() {});
  // }

  @override
  void initState() {
    isSwitched1 = GetStorage().read('isSwitched1') ?? false;
    isSwitched2 = GetStorage().read('isSwitched2') ?? false;
    isSwitched3 = GetStorage().read('isSwitched3') ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Уведомления',
          style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        // actions: const [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: Icon(
        //       Icons.notifications_active,
        //       color: AppColors.kPrimaryColor,
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 47,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Транзакции',
                        style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (bool) {
                            isSwitched1 = !isSwitched1;
                            GetStorage().write('isSwitched1', isSwitched1);

                            setState(() {});
                          },
                          value: isSwitched1,
                          activeColor: const Color.fromRGBO(245, 245, 245, 1),
                          activeTrackColor: AppColors.kPrimaryColor,
                          inactiveThumbColor: const Color.fromRGBO(245, 245, 245, 1),
                          inactiveTrackColor: const Color.fromRGBO(237, 237, 237, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0, color: AppColors.kGray400),
                Container(
                  height: 47,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Бонусы',
                        style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (bool) {
                            isSwitched2 = !isSwitched2;
                            GetStorage().write('isSwitched2', isSwitched2);
                            setState(() {});
                          },
                          value: isSwitched2,
                          activeColor: const Color.fromRGBO(245, 245, 245, 1),
                          activeTrackColor: AppColors.kPrimaryColor,
                          inactiveThumbColor: const Color.fromRGBO(245, 245, 245, 1),
                          inactiveTrackColor: const Color.fromRGBO(237, 237, 237, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0, color: AppColors.kGray400),
                Container(
                  height: 47,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Акции',
                        style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        child: Switch(
                          onChanged: (bool) {
                            isSwitched3 = !isSwitched3;
                            GetStorage().write('isSwitched3', isSwitched3);
                            setState(() {});
                          },
                          value: isSwitched3,
                          activeColor: const Color.fromRGBO(245, 245, 245, 1),
                          activeTrackColor: AppColors.kPrimaryColor,
                          inactiveThumbColor: const Color.fromRGBO(245, 245, 245, 1),
                          inactiveTrackColor: const Color.fromRGBO(237, 237, 237, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
