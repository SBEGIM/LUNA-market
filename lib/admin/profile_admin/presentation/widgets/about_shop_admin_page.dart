import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class AbouShopAdminPage extends StatefulWidget {
  AbouShopAdminPage({Key? key}) : super(key: key);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: const [
                  Flexible(
                    child: (Text(
                      'ТОП-10 Лучших Маркетплейсов России. Маркетплейс для Физических, Самозанятых и Юридических Лиц. Выставить Свои Товары на Маркетплейс России. Продвижение Вашего Бизнеса. Реклама Товаров. Раскрутка Новых Брендов. Бизнес Проект Компании ТОО Маркетплейс.',
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
                  style: const TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 17,
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
                  style: const TextStyle(
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
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kGray700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.telegram,
                      color: AppColors.kPrimaryColor,
                    ),
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
                    color: AppColors.kGray700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: const [
                    Icon(Icons.install_mobile_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.format_list_bulleted_outlined),
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
