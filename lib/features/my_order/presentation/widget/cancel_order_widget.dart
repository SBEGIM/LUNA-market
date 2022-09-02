import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class CancelOrderWidget extends StatefulWidget {
  CancelOrderWidget({Key? key}) : super(key: key);

  @override
  State<CancelOrderWidget> createState() => _CancelOrderWidgetState();
}

class _CancelOrderWidgetState extends State<CancelOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Выберите причину',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ListTile(
                    title: Text(
                      'Не устрайвает сроки',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.done,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Не устрайвает сроки',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.done,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Не устрайвает сроки',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.done,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Не устрайвает сроки',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.done,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Отменить заказ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
