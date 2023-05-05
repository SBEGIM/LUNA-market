import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class StoresSellersPage extends StatefulWidget {
  const StoresSellersPage({Key? key}) : super(key: key);

  @override
  State<StoresSellersPage> createState() => _StoresSellersPageState();
}

class _StoresSellersPageState extends State<StoresSellersPage> {
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColors.kPrimaryColor,
              ))
        ],
        title: const Text(
          'Магазины продавца',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
              color: Colors.white,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: AppColors.kGray700,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return const ListTile(
                    leading: Icon(
                      Icons.share_location_rounded,
                      size: 35,
                      color: AppColors.kPrimaryColor,
                    ),
                    title: Text(
                      'Алматы, улица Байзакова, 280',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text(
                      'Пн – Сб с 10:00 до 18:00, Вс – выходной',
                      style: TextStyle(
                          color: AppColors.kGray300,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
