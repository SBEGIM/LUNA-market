import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
                'assets/images/appIcon.png',
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
                      'LUNA market-это лучшее мобильное приложение для покупки и продажи товаров,с видео обзорами от Блогеров  , Маркетплейс для Физических,Самозанятых и Юридических Лиц .Возможность Продвижения Вашего Бизнеса,Реклама товаров, Раскрутка новых Брендов с эксклюзивной программой для Блогеров',
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
                  // height: 150,
                  color: AppColors.kBackgroundColor,
                  child: Image.asset('assets/images/map.png'),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Россия Чеченская республика, Грозный.',
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
                      'Lunamarket@inbox.ru',
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
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/mail.svg'),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'https://t.me/LUNAmarketAdmin',
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
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/mail.svg'),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'thousand@gmail.com',
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

                    //https://t.me/LUNAmarketAdmin

                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(
                      'assets/icons/youtube.svg',
                      height: 34,
                      width: 34,
                    ),
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
