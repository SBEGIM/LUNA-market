import 'package:flutter/cupertino.dart';
import 'package:haji_market/core/common/constants.dart';

class PreOrderDialog extends StatelessWidget {
  final Function()? onYesTap;
  const PreOrderDialog({super.key, this.onYesTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          'Внимание',
        ),
      ),
      content: const Text(
        'Данный товар не в наличии, но доступен к предзаказу, вы хотите продолжить покупку?',
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: onYesTap,
          textStyle: AppTextStyles.appBarTextStyle.copyWith(
            color: AppColors.kPrimaryColor,
          ),
          child: const Text('Да'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          textStyle: AppTextStyles.appBarTextStyle.copyWith(
            color: AppColors.kPrimaryColor,
          ),
          child: const Text('Нет'),
        ),
      ],
    );
  }
}
