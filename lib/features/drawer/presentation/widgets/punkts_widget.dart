import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';

class PunktsWidget extends StatelessWidget {
  const PunktsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 70,
            child: ListTile(
              //minLeadingWidth: 23,
              horizontalTitleGap: 0,
              leading: SvgPicture.asset('assets/icons/location.svg'),
              title: const Text(
                'Алматы, улица Байзакова, 280',
                style: TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              subtitle: const Text(
                'Пн – Сб с 10:00 до 18:00, Вс – выходной',
                style: TextStyle(
                    color: AppColors.kGray300,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
          );
        },
      ),
    );
  }
}
