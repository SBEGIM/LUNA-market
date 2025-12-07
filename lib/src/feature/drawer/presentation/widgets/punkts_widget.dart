import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';

class PunktsWidget extends StatelessWidget {
  const PunktsWidget({super.key});

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
            const Divider(height: 1, thickness: 0.33, color: Color(0xffC7C7CC)),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 70,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 11,
              leading: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(Assets.icons.location.path),
              ),
              title: const Text(
                'Алматы, улица Байзакова, 280',
                style: AppTextStyles.size18Weight600,
              ),
              subtitle: Text(
                'Пн – Сб с 10:00 до 18:00, Вс – выходной',
                style: AppTextStyles.size14Weight400.copyWith(color: Color(0xff8E8E93)),
              ),
            ),
          );
        },
      ),
    );
  }
}
