import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/reqirect_profile_page.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';

class EditProfileBloggerPage extends StatefulWidget {
  const EditProfileBloggerPage({super.key});

  @override
  State<EditProfileBloggerPage> createState() => _EditProfileBloggerPageState();
}

class _EditProfileBloggerPageState extends State<EditProfileBloggerPage> {
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
        title: const Text('Мои данные', style: AppTextStyles.size18Weight600),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop('ok');
          },
          child: Image.asset(Assets.icons.defaultBackIcon.path, height: 24, width: 24, scale: 1.9),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileItem(
              iconPath: Assets.icons.jurIcon.path,
              title: 'Основная информация',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReqirectBloggerProfilePage(title: 'Основная информация'),
                  ),
                );
              },
            ),
            buildProfileItem(
              iconPath: Assets.icons.internet.path,
              title: 'Социальные сети',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReqirectBloggerProfilePage(title: 'Социальные сети'),
                  ),
                );
              },
            ),
            buildProfileItem(
              iconPath: Assets.icons.jurIcon.path,
              title: 'Юридический статус',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReqirectBloggerProfilePage(title: 'Юридический статус'),
                  ),
                );
              },
            ),
            buildProfileItem(
              iconPath: Assets.icons.phoneIcon.path,
              title: 'Контактные данные',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReqirectBloggerProfilePage(title: 'Контактные данные'),
                  ),
                );
              },
            ),
            buildProfileItem(
              iconPath: Assets.icons.propsIcon.path,
              title: 'Реквизиты банка',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReqirectBloggerProfilePage(title: 'Реквизиты банка'),
                  ),
                );
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
      padding: const EdgeInsets.only(top: 16.0, right: 16, left: 16),
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
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Image.asset(iconPath, height: 18, width: 18, fit: BoxFit.contain),
              ),
              const SizedBox(width: 12),
              Text(title, style: AppTextStyles.size16Weight600),
            ],
          ),
          Image.asset(Assets.icons.defaultArrowForwardIcon.path, height: 24, width: 24, scale: 1.9),
        ],
      ),
    ),
  );
}
