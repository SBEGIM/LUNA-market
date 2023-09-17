import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:haji_market/contract_of_sale.dart';
import 'package:haji_market/core/common/constants.dart';

class AdvertBottomSheet extends StatelessWidget {
  String? url;
  String? description;
  AdvertBottomSheet({
    this.url,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35, //set this as you want
      maxChildSize: 0.35, //set this as you want
      minChildSize: 0.35, //set this as you want
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Рекламное объявление',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Get.to(const ContractOfSale());
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 8, left: 16),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              "Мы помогаем нашим продавцам рассказать об их товарах на LUNA market.Для этого у нас есть разные способы продвижения. Узнать больше о ",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: "рекламе на LUNA market",
                          style: TextStyle(fontSize: 14, color: AppColors.kPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const Text(
              //   'Мы помогаем нашим продавцам рассказать об их товарах на LUNA market.Для этого у нас есть разные способы продвижения. Узнать больше о рекламе на LUNA market',
              //   style: TextStyle(
              //       fontSize: 12,
              //       fontWeight: FontWeight.w400),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.info_outline_rounded),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'О рекламодателе',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.kGray1000),
                      ),
                      Text(
                        ' ${description ?? 'Market TOO'}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.link),
                  SizedBox(width: 10),
                  Text(
                    'Скопировать ссылку',
                    style: TextStyle(fontSize: 14, color: AppColors.kPrimaryColor),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
