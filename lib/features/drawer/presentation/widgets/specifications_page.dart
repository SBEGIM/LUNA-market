import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class SpecificationsPage extends StatefulWidget {
  SpecificationsPage({Key? key}) : super(key: key);

  @override
  State<SpecificationsPage> createState() => _SpecificationsPageState();
}

class _SpecificationsPageState extends State<SpecificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        title: const Text(
          'Характеристики',
          style: TextStyle(
              color: AppColors.kGray900,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Основные характеристики',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: const Text(
                        'Назначение',
                        style: const TextStyle(
                            color: AppColors.kGray400,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      'Обычные',
                      style: const TextStyle(
                          color: AppColors.kGray1000,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: const Text(
                        'Тип конструкции ',
                        style: const TextStyle(
                            color: AppColors.kGray400,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      'Полноразмерные',
                      style: const TextStyle(
                          color: AppColors.kGray1000,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: const Text(
                        'Тип крепления',
                        style: const TextStyle(
                            color: AppColors.kGray400,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      'С оголовьем',
                      style: const TextStyle(
                          color: AppColors.kGray1000,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: const Text(
                        'Частотный диапазон, Гц-кГц:',
                        style: TextStyle(
                            color: AppColors.kGray400,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      '20 - 20',
                      style: const TextStyle(
                          color: AppColors.kGray1000,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: const Text(
                        'Импеданс, Ом',
                        style: TextStyle(
                            color: AppColors.kGray400,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      '32',
                      style: TextStyle(
                          color: AppColors.kGray1000,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: AppColors.kGray400,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Основные характеристики',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.33,
                              child: const Text(
                                'Импеданс, Ом',
                                style: TextStyle(
                                    color: AppColors.kGray400,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            const Text(
                              '32',
                              style: TextStyle(
                                  color: AppColors.kGray1000,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
