import 'package:flutter/cupertino.dart';
import 'package:haji_market/src/core/common/constants.dart';

class CountZeroDialog extends StatelessWidget {
  final Function()? onYesTap;
  const CountZeroDialog({super.key, this.onYesTap});

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
        'Товара нет в наличии, предзаказ не доступен!',
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          textStyle: AppTextStyles.appBarTextStyle.copyWith(
            color: AppColors.kPrimaryColor,
          ),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
