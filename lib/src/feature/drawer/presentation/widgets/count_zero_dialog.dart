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
            style: AppTextStyles.size22Weight600,
          ),
        ),
        content: Text(
          'К сожалению, товара нет в наличии, предзаказ недоступен!',
          style:
              AppTextStyles.size16Weight400.copyWith(color: Color(0xff636366)),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.mainPurpleColor,
              ),
              alignment: Alignment.center,
              child: Text('Понятно',
                  style: AppTextStyles.size18Weight700.copyWith(
                    color: AppColors.kWhite,
                  )),
            ),
          )
        ]);
  }
}
