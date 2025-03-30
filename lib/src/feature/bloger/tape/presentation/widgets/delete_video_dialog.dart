import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

class DeleteVideoDialog extends StatelessWidget {
  final Function()? onYesTap;
  const DeleteVideoDialog({super.key, this.onYesTap});

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
        'Вы действительно хотите удалить данное видео?',
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: onYesTap,
          textStyle: AppTextStyles.appBarTextStyle.copyWith(
            color: Colors.red,
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
