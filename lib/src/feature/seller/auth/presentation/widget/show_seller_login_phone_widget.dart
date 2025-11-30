import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerLoginPhone(BuildContext context, {required Function countryCall}) {
  String select = '';

  CountrySellerDto countrySellerDto = CountrySellerDto(
    code: '+7',
    name: 'Россия',
    flagPath: Assets.icons.ruFlagIcon.path,
  );

  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: AppColors.kGray1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Выберите страну', style: AppTextStyles.size16Weight500),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(Assets.icons.defaultCloseIcon.path, scale: 1.9),
                      ),
                    ],
                  ),
                ),
                _buildOptionTile(
                  context: context,
                  path: Assets.icons.ruFlagIcon.path,
                  title: 'Россия',
                  number: '+7',
                  select: countrySellerDto,
                  onTap: () {
                    setState(() {
                      countrySellerDto = CountrySellerDto(
                        code: '+7',
                        name: 'Россия',
                        flagPath: Assets.icons.ruFlagIcon.path,
                      );
                    });
                  },
                ),
                _buildOptionTile(
                  context: context,
                  path: Assets.icons.belFlagIcon.path,
                  title: 'Беларусь',
                  number: '+7',
                  select: countrySellerDto,
                  onTap: () {
                    setState(() {
                      countrySellerDto = CountrySellerDto(
                        code: '+7',
                        name: 'Беларусь',
                        flagPath: Assets.icons.belFlagIcon.path,
                      );
                    });
                  },
                ),
                _buildOptionTile(
                  context: context,
                  path: Assets.icons.kzFlagIcon.path,
                  title: 'Казахстан',
                  number: '+7',
                  select: countrySellerDto,
                  onTap: () {
                    setState(() {
                      countrySellerDto = CountrySellerDto(
                        code: '+7',
                        name: 'Казахстан',
                        flagPath: Assets.icons.kzFlagIcon.path,
                      );
                    });
                  },
                ),
                _buildOptionTile(
                  context: context,
                  path: Assets.icons.krFlagIcon.path,
                  title: 'Киргизия',
                  number: '+9',
                  select: countrySellerDto,
                  onTap: () {
                    setState(() {
                      countrySellerDto = CountrySellerDto(
                        code: '+9',
                        name: 'Киргизия',
                        flagPath: Assets.icons.krFlagIcon.path,
                      );
                    });
                  },
                ),
                _buildOptionTile(
                  context: context,
                  path: Assets.icons.arFlagIcon.path,
                  title: 'Армения',
                  number: '+9',
                  select: countrySellerDto,
                  onTap: () {
                    setState(() {
                      countrySellerDto = CountrySellerDto(
                        code: '+9',
                        name: 'Армения',
                        flagPath: Assets.icons.arFlagIcon.path,
                      );
                    });
                  },
                ),
                _buildOptionTile(
                  context: context,
                  path: Assets.icons.uzFlagIcon.path,
                  number: '+8',
                  title: 'Узбекистан',
                  select: countrySellerDto,
                  onTap: () {
                    setState(() {
                      countrySellerDto = CountrySellerDto(
                        code: '+8',
                        name: 'Узбекистан',
                        flagPath: Assets.icons.uzFlagIcon.path,
                      );
                    });
                  },
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    countryCall.call(countrySellerDto);

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 52,
                    width: 358,
                    decoration: BoxDecoration(
                      color: AppColors.mainPurpleColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text('Выбрать', style: AppTextStyles.defButtonTextStyle),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildOptionTile({
  required BuildContext context,
  required String path,
  required String title,
  required String number,
  required VoidCallback onTap,
  CountrySellerDto? select,
}) {
  return Container(
    height: 52,
    margin: EdgeInsets.only(left: 16, top: 8, right: 16),
    alignment: Alignment.center,
    decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: BorderRadius.circular(16)),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 18), // Минимальные отступы
      minLeadingWidth: 0, // убирает лишний резерв под leading
      visualDensity: const VisualDensity(horizontal: -4, vertical: 0), // ещё компактнее

      leading: Image.asset(path, scale: 2),
      title: Text("$title $number", style: AppTextStyles.size16Weight600),
      onTap: onTap,
      tileColor: Colors.transparent, // Убираем фон у Tile, если он есть
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Скругляем угол
      ),
      trailing: SizedBox(
        height: 24,
        width: 24,
        child: select!.name == title
            ? Image.asset(
                Assets.icons.defaultCheckIcon.path,
                scale: 1.9,
                color: AppColors.kLightBlackColor,
              )
            : Image.asset(
                Assets.icons.defaultUncheckIcon.path,
                scale: 1.9,
                color: AppColors.kGray200,
              ),
      ),
    ),
  );
}
