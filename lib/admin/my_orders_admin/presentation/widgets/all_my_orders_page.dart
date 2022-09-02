import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/my_orders_admin/presentation/widgets/detail_my_orders_page.dart';
import 'package:haji_market/core/common/constants.dart';

class AllMyOrdersPage extends StatefulWidget {
  AllMyOrdersPage({Key? key}) : super(key: key);

  @override
  State<AllMyOrdersPage> createState() => _AllMyOrdersPageState();
}

class _AllMyOrdersPageState extends State<AllMyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Сегодня',
                  style: TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailMyOrdersPage()),
                  );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  '№1920-293',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.kGray700),
                                ),
                                Icon(
                                  Icons.credit_card,
                                )
                              ],
                            ),
                            const Icon(Icons.more_vert_rounded)
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.timer,
                              color: AppColors.kGray300,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '23 июня, 17:50',
                              style: TextStyle(
                                  color: AppColors.kGray300,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Silver Macbook Air M1',
                                    style: TextStyle(
                                        color: AppColors.kGray750,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'х1',
                                    style: TextStyle(
                                        color: AppColors.kGray750,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '556 900 ₸',
                                    style: TextStyle(
                                        color: AppColors.kGray750,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Сумма заказа:',
                              style: TextStyle(
                                  color: AppColors.kGray400,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '1 113 800 ₸',
                              style: TextStyle(
                                  color: AppColors.kGray750,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/user.svg',
                              color: AppColors.kGray400,
                            ),
                            const Text(
                              'Улан шотейулы',
                              style: TextStyle(
                                  color: AppColors.kGray500,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(5),
                          child: const Text('Передан курьеру'),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ));
  }
}
