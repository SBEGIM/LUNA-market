import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/theme/resources.dart' show Assets;
import 'package:haji_market/src/core/utils/extensions/object.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/meta_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
  ];

  List<String> metasBody = [];

  @override
  void initState() {
    BlocProvider.of<MetaCubit>(context).partners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const Text(
      //     'О нас',
      //     style: TextStyle(
      //         color: AppColors.kGray900,
      //         fontSize: 16,
      //         fontWeight: FontWeight.w500),
      //   ),
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       color: AppColors.kPrimaryColor,
      //     ),
      //   ),
      // ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.kLightBlackColor,
                  ),
                ),
              ),
              Image.asset(Assets.images.aboutImage.path),
              Container(
                margin: EdgeInsets.only(top: 250),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'О нас',
                      style: AppTextStyles.defaultButtonTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12),
                    Flexible(
                      child: Text(
                        'LUNA Market — это современное мобильное приложение '
                        'для покупки и продажи товаров с видеообзорами от блогеров. '
                        'Мы — маркетплейс, открытый как для физических, так и юридических лиц.\n\n'
                        'Наши возможности:\n'
                        '• Продвижение вашего бизнеса\n'
                        '• Реклама товаров\n'
                        '• Раскрутка новых брендов\n\n'
                        'Уникальная программа для блогеров делает нас идеальной платформой '
                        'для эффективного взаимодействия между продавцами, покупателями и контент-мейкерами.',
                        style: AppTextStyles.aboutTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),

          Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Мы в соцсетях',
                    style: AppTextStyles.defaultButtonTextStyle,
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 16),
                  buildContactItem(
                      onTap: () => launch(
                            "https://instagram.com/luna_market.ru?igshid=YmMyMTA2M2Y=",
                            forceSafariVC: false,
                          ),
                      label: 'Instagram',
                      iconPath: Assets.icons.insta.path),
                  SizedBox(height: 16),
                  buildContactItem(
                      onTap: () => launch(
                            "https://www.tiktok.com/@lunamarket365?_t=8bXOtWBKkIU&_r=1",
                            forceSafariVC: false,
                          ),
                      label: 'TikTok',
                      iconPath: Assets.icons.tiktok.path),
                  SizedBox(height: 16),
                  buildContactItem(
                      onTap: () => launch(
                            "https://www.youtube.com/@lunamarket365",
                            forceSafariVC: false,
                          ),
                      label: 'YouTube',
                      iconPath: Assets.icons.youtube.path),
                ],
              )),

          Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Администрация',
                    style: AppTextStyles.defaultButtonTextStyle,
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 16),
                  buildContactItem(
                      onTap: () => launch(
                            "http://Lunamarket@inbox.ru",
                            forceSafariVC: false,
                          ),
                      label: 'Email',
                      iconPath: Assets.icons.mail.path),
                  SizedBox(height: 16),
                  buildContactItem(
                      onTap: () => launch(
                            "http://Lunamarket@inbox.ru",
                            forceSafariVC: false,
                          ),
                      label: 'Telegram - LunaMarket',
                      iconPath: Assets.icons.telegram.path),
                  SizedBox(height: 16),
                  buildContactItem(
                      onTap: () => launch(
                            "http://Lunamarket@inbox.ru",
                            forceSafariVC: false,
                          ),
                      label: 'Telegram - Продавец',
                      iconPath: Assets.icons.telegram.path),
                  SizedBox(height: 16),
                  buildContactItem(
                      onTap: () => launch(
                            "http://Lunamarket@inbox.ru",
                            forceSafariVC: false,
                          ),
                      label: 'Telegram - Блогер',
                      iconPath: Assets.icons.telegram.path),
                ],
              )),

          Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Условия и политики',
                    style: AppTextStyles.defaultButtonTextStyle,
                    textAlign: TextAlign.right,
                  ),
                  BlocBuilder<MetaCubit, MetaState>(builder: (context, state) {
                    if (state is LoadedState) {
                      metasBody.addAll([
                        state.metas.terms_of_use!,
                        state.metas.privacy_policy!,
                        state.metas.contract_offer!,
                        state.metas.shipping_payment!,
                        state.metas.TTN!,
                      ]);
                      return ListView.builder(
                          padding: EdgeInsets.only(top: 12),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => MetasPage(
                                      title: metas[index],
                                      body: metasBody[index],
                                    ));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  buildContactItem(
                                    onTap: () {},
                                    label: metas[index],
                                    iconPath: Assets.icons.metaIcon.path,
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainPurpleColor,
                        ),
                      );
                    }
                  }),
                ],
              )),

          // Container(
          //   color: Colors.white,
          //   padding: const EdgeInsets.all(16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Адрес',
          //         style: TextStyle(
          //             color: AppColors.kGray900,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w700),
          //       ),
          //       const SizedBox(
          //         height: 8,
          //       ),
          //       // Container(
          //       //   // height: 150,
          //       //   color: AppColors.kBackgroundColor,
          //       //   child: Image.asset('assets/images/map.png'),
          //       // ),
          //       // const SizedBox(
          //       //   height: 8,
          //       // ),
          //       const Text(
          //         'Россия Чеченская республика, Грозный.',
          //         style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.w500,
          //             color: AppColors.kGray700),
          //       )
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),

          // Container(
          //   color: Colors.white,
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.all(16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(
          //         height: 8,
          //       ),
          //       Row(
          //         children: [
          //           GestureDetector(
          //               onTap: () => launch(
          //                   "https://instagram.com/luna_market.ru?igshid=YmMyMTA2M2Y=",
          //                   forceSafariVC: false),
          //               child: SvgPicture.asset('assets/icons/insta.svg')),
          //           const SizedBox(
          //             width: 16,
          //           ),
          //           // GestureDetector(
          //           //     onTap: () => launch("https://www.facebook.com/",
          //           //         forceSafariVC: false),
          //           //     child: SvgPicture.asset('assets/icons/facebook.svg')),
          //           // const SizedBox(
          //           //   width: 16,
          //           // ),
          //           GestureDetector(
          //               onTap: () => launch("https://t.me/LunaMarke_t",
          //                   forceSafariVC: false),
          //               child:
          //                   SvgPicture.asset('assets/icons/telegram.svg')),
          //           const SizedBox(
          //             width: 16,
          //           ),
          //           GestureDetector(
          //             onTap: () => launch(
          //                 "https://www.youtube.com/@lunamarket365",
          //                 forceSafariVC: false),
          //             child: SvgPicture.asset(
          //               'assets/icons/youtube.svg',
          //               height: 34,
          //               width: 34,
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 16,
          //           ),
          //           GestureDetector(
          //             onTap: () => launch(
          //                 "https://www.tiktok.com/@lunamarket365?_t=8bXOtWBKkIU&_r=1",
          //                 forceSafariVC: false),
          //             child: SvgPicture.asset('assets/icons/tiktok.svg',
          //                 height: 34, width: 34),
          //           ),
          //           const SizedBox(
          //             width: 16,
          //           ),
          //           GestureDetector(
          //               onTap: () async {
          //                 await Share.share('$kDeepLinkUrl/');
          //               },
          //               child: SvgPicture.asset(
          //                 'assets/icons/share.svg',
          //                 height: 34,
          //                 width: 34,
          //               ))
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

Widget buildContactItem({
  required String iconPath,
  required String label,
  required VoidCallback onTap,
}) {
  final bool isSvg = iconPath.toLowerCase().endsWith('.svg');

  return Row(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.mainBackgroundPurpleColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isSvg
                ? SvgPicture.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          label,
          style: AppTextStyles.defaultButtonTextStyle,
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}

class ContactItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final String url;

  const ContactItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.mainBackgroundPurpleColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () => launch(url, forceSafariVC: false),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: AppTextStyles.defaultButtonTextStyle,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
