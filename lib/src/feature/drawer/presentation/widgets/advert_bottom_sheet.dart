import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/utils/url_util.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/meta_state.dart';
import 'package:haji_market/src/feature/home/data/repository/popular_shops_repository.dart';

class AdvertBottomSheet extends StatefulWidget {
  String? url;
  String? urlAdmin;
  String? description;

  AdvertBottomSheet({
    this.url,
    this.description,
    this.urlAdmin,
    super.key,
  });

  @override
  State<AdvertBottomSheet> createState() => _AdvertBottomSheetState();
}

class _AdvertBottomSheetState extends State<AdvertBottomSheet> {
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
    baseUrl;
    if (BlocProvider.of<MetaCubit>(context).state is! LoadedState) {
      BlocProvider.of<MetaCubit>(context).partners();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.35, //set this as you want
        maxChildSize: 0.35, //set this as you want
        minChildSize: 0.35, //set this as you want
        builder: (context, scrollController) {
          return BlocBuilder<MetaCubit, MetaState>(
            builder: (context, state) {
              if (state is LoadedState) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Рекламное объявление',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          if (widget.urlAdmin != null) {
                            UrlUtil.launch(context, url: widget.urlAdmin ?? '');
                          } else {
                            Get.to(() => MetasPage(
                                  title: metas[4],
                                  body: metasBody[4],
                                ));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 8, left: 16),
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "Мы помогаем нашим продавцам рассказать об их товарах на LUNA market.Для этого у нас есть разные способы продвижения. Узнать больше о ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: "рекламе на LUNA market",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.kPrimaryColor),
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
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.kGray1000),
                              ),
                              Text(
                                '${widget.description != 'null' ? widget.description : ''}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.url.toString()));
                          },
                          child: const SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                Icon(Icons.link),
                                SizedBox(width: 10),
                                Text(
                                  'Скопировать ссылку',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        });
  }
}
