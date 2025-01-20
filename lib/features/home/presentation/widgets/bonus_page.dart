import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/home/presentation/widgets/bonus_detail_page.dart';

class BonusPage extends StatefulWidget {
  final String name;
  final int bonus;
  final String date;
  final String image;
  final String url;
  final String description;
  const BonusPage(
      {required this.name,
      required this.bonus,
      required this.date,
      required this.image,
      required this.url,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  State<BonusPage> createState() => _BonusPageState();
}

class _BonusPageState extends State<BonusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: SvgPicture.asset('assets/icons/share.svg'),
          ),
        ],
        title: Text(
          'Дарим ${widget.bonus}% бонусов',
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F1F1F)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 218,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://lunamarket.ru/storage/${widget.image}"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 60),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 22),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 4, bottom: 4),
                          child: Text(
                            '${widget.bonus}% Б',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 160),
                      child: Text(
                        widget.date,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.only(right: 16, top: 185),
                      child: GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            isDismissible: true,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                initialChildSize: 0.30, //set this as you want
                                maxChildSize: 0.30, //set this as you want
                                minChildSize: 0.30, //set this as you want
                                builder: (context, scrollController) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Рекламный баннер',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     // Get.to(const ContractOfSale());
                                        //   },
                                        //   child: Container(
                                        //     padding: const EdgeInsets.only(
                                        //         top: 8, left: 16),
                                        //     alignment: Alignment.centerLeft,
                                        //     child: Text(
                                        //       '${widget.description}',
                                        //       style: const TextStyle(
                                        //           fontSize: 14,
                                        //           color:
                                        //               AppColors.kPrimaryColor),
                                        //     ),
                                        //   ),
                                        // ),
                                        // const Text(
                                        //   'Мы помогаем нашим продавцам рассказать об их товарах на LUNA market.Для этого у нас есть разные способы продвижения. Узнать больше о рекламе на LUNA market',
                                        //   style: TextStyle(
                                        //       fontSize: 12,
                                        //       fontWeight: FontWeight.w400),
                                        //   textAlign: TextAlign.center,
                                        // ),
                                        // const SizedBox(height: 16),

                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Описание:',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${widget.description}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors
                                                        .kPrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 50),

                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.link),
                                              const SizedBox(width: 10),
                                              const Text(
                                                'Ссылка:',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${widget.url}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors
                                                        .kPrimaryColor),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 4.0, right: 4, top: 4, bottom: 4),
                            child: Text(
                              'РЕКЛАМА',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BonusDetailPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              color: Colors.white,
              child: const ListTile(
                title: Text(
                  'Магазины на LUNA market',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                subtitle: Text(
                  'Выбирайте товары и покупайте онлайн',
                  style: TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 77,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BonusDetailPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                color: Colors.white,
                child: const ListTile(
                  title: Text(
                    'Магазины вашего города',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    'Выбирайте товары в магазинах города и оплачивайте в рассрочку',
                    style: TextStyle(
                        color: AppColors.kGray300,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
