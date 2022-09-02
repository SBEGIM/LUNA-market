import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/profile/data/presentation/ui/my_bank_card_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Редактирование профиля',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        actions: const [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.notifications_active,
              color: AppColors.kPrimaryColor,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                    radius: 30,
                    child: Image.asset('assets/images/wireles.png')),
                title: const Text(
                  'Маржан Жумадилова',
                  style: TextStyle(
                      color: AppColors.kGray700,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Алматы',
                  style: TextStyle(
                      color: AppColors.kGray400,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Пуш уведомления',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            // print(isSwitched);
                          });
                        },
                        activeTrackColor: AppColors.kPrimaryColor,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Язык приложения',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Русский',
                            style: TextStyle(
                                color: AppColors.kGray300,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Изменить пароль',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Вход с Touch ID',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            // print(isSwitched);
                          });
                        },
                        activeTrackColor: AppColors.kPrimaryColor,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Изменить город',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                InkWell(
                  onTap: (){
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyBankCardPage()),
                  );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Мои карты',
                              style: TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Мои бонусы',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        'Мои бонусы',
                        style: TextStyle(
                            color: AppColors.kGray300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Изменить номер телефона',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Сохранить',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
