import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/reqirect_profile_page.dart';
import '../../../../../core/constant/generated/assets.gen.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Мои данные', style: AppTextStyles.appBarTextStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileItem(
              iconPath: Assets.icons.jurIcon.path,
              title: 'Юридические данные',
              onTap: () {
                Get.to(ReqirectProfilePage(title: 'Юридические данные'));
              },
            ),
            buildProfileItem(
              iconPath: Assets.icons.propsIcon.path,
              title: 'Реквизиты банка',
              onTap: () {
                Get.to(ReqirectProfilePage(title: 'Реквизиты банка'));
              },
            ),
            buildProfileItem(
              iconPath: Assets.icons.phoneIcon.path,
              title: 'Контактные данные',
              onTap: () {
                Get.to(ReqirectProfilePage(title: 'Контактные данные'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildProfileItem({
  required String title,
  required String iconPath,
  required VoidCallback onTap,
  bool? switchWidget,
  ValueChanged<bool>? onSwitchChanged,
  bool? switchValue,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.mainIconPurpleColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Image.asset(iconPath, height: 20, width: 20, fit: BoxFit.contain),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.kGray900,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          switchWidget == true
              ? Transform.scale(
                  scale: 0.9,
                  child: Switch(
                    value: switchValue ?? false,
                    onChanged: onSwitchChanged,
                    inactiveThumbColor: Colors.white,
                    activeTrackColor: AppColors.mainPurpleColor,
                    trackOutlineWidth: WidgetStateProperty.all(0.01),
                  ),
                )
              : const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.arrowColor),
        ],
      ),
    ),
  );
}
