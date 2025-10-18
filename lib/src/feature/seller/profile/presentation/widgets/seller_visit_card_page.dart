import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class SellerVisitCardPage extends StatefulWidget {
  const SellerVisitCardPage({super.key});

  @override
  State<SellerVisitCardPage> createState() => _BloggerVisitCardPageState();
}

class _BloggerVisitCardPageState extends State<SellerVisitCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFAD32F8), // Фиолетовый
              Color(0xFF3275F8), // Синий
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.kWhite,
                      )),
                )),
            Stack(alignment: Alignment.center, children: [
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: EdgeInsets.only(top: 30),
                child: Container(
                  height: 465,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        '@${GetStorage().read('seller_name')}',
                        style: AppTextStyles.size18Weight700
                            .copyWith(color: AppColors.kWhite),
                      ),
                      QrImageView(
                        data: '${GetStorage().read('seller_id')}',
                        version: QrVersions.min,
                        size: 242,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        errorStateBuilder: (cxt, err) {
                          return Center(
                            child: Text(
                              'Uh oh! Something went wrong...',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      Text(
                        'СКАНИРУЙТЕ QR-КОД',
                        style: AppTextStyles.defButtonTextStyle.copyWith(
                            color: AppColors.kWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'чтобы подписаться и следить за новыми обзорами товаров',
                        style: AppTextStyles.catalogTextStyle.copyWith(
                            color: AppColors.kGray1.withOpacity(0.4),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://lunamarket.ru/storage/${GetStorage().read('seller_image')}',
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text:
                              'https://lunamarket.ru?blogger_id=${GetStorage().read('seller_id')}'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Текст скопирован')),
                      );
                    },
                    child: Container(
                      height: 68,
                      width: 176,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            Assets.icons.copyIcon.path,
                            color: Colors.white,
                            height: 16.5,
                          ),
                          Text(
                            'Скопировать',
                            style: AppTextStyles.size18Weight400
                                .copyWith(color: AppColors.kWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Share.share(
                          'https://lunamarket.ru?blogger_id=${GetStorage().read('seller_id')}');
                    },
                    child: Container(
                      height: 68,
                      width: 176,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            Assets.icons.shareNewIcon.path,
                            color: Colors.white,
                            height: 16.5,
                          ),
                          Text(
                            'Поделиться',
                            style: AppTextStyles.size18Weight400
                                .copyWith(color: AppColors.kWhite),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 32),
            Image.asset(
              Assets.images.lunaMarketBottomImage.path,
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
