import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';

class AbouShopAdminPage extends StatefulWidget {
  const AbouShopAdminPage({Key? key}) : super(key: key);

  @override
  State<AbouShopAdminPage> createState() => _AbouShopAdminPageState();
}

class _AbouShopAdminPageState extends State<AbouShopAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'О нас',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
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
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 4),
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/images/shopClick.png',
                height: 80,
                width: 80,
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              color: Colors.white,
              child: Row(
                children: const [
                  Flexible(
                    child: (Text(
                      'ТОП-10 Лучших Маркетплейсов Казахстана. Маркетплейс для Физических, Самозанятых и Юридических Лиц. Выставить Свои Товары на Маркетплейс Казахстана. Продвижение Вашего Бизнеса. Реклама Товаров. Раскрутка Новых Брендов. Бизнес Проект Компании ТОО Маркетплейс.',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Адрес',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 200,
                  color: AppColors.kBackgroundColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'г. Алматы, ул. Шевченко 90(БЦ Каратал), офис 108',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kGray700),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Почта',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kGray700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/mail.svg'),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'hajimarken@gmail.com',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kPrimaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Если хотите с нами связаться, пишите',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kGray300),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Мы в соцсетях:',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kGray900,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/insta.svg'),
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset('assets/icons/facebook.svg'),
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset('assets/icons/telegram.svg'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
