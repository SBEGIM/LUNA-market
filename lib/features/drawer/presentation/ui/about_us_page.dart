import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      'LUNA market-это лучшее мобильное приложение для покупки и продажи товаров,с видео обзорами от Блогеров  , Маркетплейс для Физических,Самозанятых и Юридических Лиц.\nВозможность\nПродвижения Вашего Бизнеса,Реклама товаров, Раскрутка новых Брендов с эксклюзивной программой для Блогеров',
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
                // Container(
                //   // height: 150,
                //   color: AppColors.kBackgroundColor,
                //   child: Image.asset('assets/images/map.png'),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
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
                  'Контакты',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kGray700),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'АДМИНИСТРАЦИЯ:',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kGray900,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kGray700),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () => launch("https://Lunamarket@inbox.Ru",
                          forceSafariVC: false),
                      child: const Text(
                        'https://Lunamarket@inbox.Ru',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kPrimaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
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
                    const Text(
                      'Telegram ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kGray700),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () => launch("https://t.me/LunaMarke_t",
                          forceSafariVC: false),
                      child: const Text(
                        'https://t.me/LunaMarke_t',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kPrimaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Telegram Канал для Продавцов ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kGray700),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () => launch("https://t.me/LUNAmarketSeller",
                          forceSafariVC: false),
                      child: const Text(
                        'https://t.me/LUNAmarketSeller',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kPrimaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Telegram Канал для Блогеров',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kGray700),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () => launch("https://t.me/LUNAmarketBlogger",
                          forceSafariVC: false),
                      child: const Text(
                        'https://t.me/LUNAmarketBlogger',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kPrimaryColor),
                      ),
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
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => launch(
                            "https://instagram.com/luna_market.ru?igshid=YmMyMTA2M2Y=",
                            forceSafariVC: false),
                        child: SvgPicture.asset('assets/icons/insta.svg')),
                    const SizedBox(
                      width: 16,
                    ),
                    // GestureDetector(
                    //     onTap: () => launch("https://www.facebook.com/",
                    //         forceSafariVC: false),
                    //     child: SvgPicture.asset('assets/icons/facebook.svg')),
                    // const SizedBox(
                    //   width: 16,
                    // ),
                    GestureDetector(
                        onTap: () => launch("https://t.me/LUNAmarketAdmin",
                            forceSafariVC: false),
                        child: SvgPicture.asset('assets/icons/telegram.svg')),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () => launch(
                          "https://www.youtube.com/@lunamarket365",
                          forceSafariVC: false),
                      child: SvgPicture.asset(
                        'assets/icons/youtube.svg',
                        height: 34,
                        width: 34,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () => launch(
                          "https://www.tiktok.com/@lunamarket365?_t=8bXOtWBKkIU&_r=1",
                          forceSafariVC: false),
                      child: SvgPicture.asset('assets/icons/tiktok.svg',
                          height: 34, width: 34),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                        onTap: () async {
                          await Share.share('http://lunamarket.info/');
                        },
                        child: SvgPicture.asset(
                          'assets/icons/share.svg',
                          height: 34,
                          width: 34,
                        ))
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
