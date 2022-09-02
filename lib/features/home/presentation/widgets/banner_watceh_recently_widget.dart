import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class BannerWatcehRecently extends StatelessWidget {
  const BannerWatcehRecently({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: AppColors.kBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/wireles.png',
              height: 144,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Беспроводные наушн...',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.kGray900,
                  fontWeight: FontWeight.w400),
            ),
            const Text(
              'Подкатегория',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.kGray300,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '330 900 ₸ ',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w400),
                ),
                const Text(
                  '330 900 ₸',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                      color: Color(0xFF19191A),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Text(
                      '110 300',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF19191A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'х3',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF19191A),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}