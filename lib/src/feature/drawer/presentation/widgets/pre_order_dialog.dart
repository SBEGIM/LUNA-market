import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/data/bloc/meta_cubit.dart';
import 'package:haji_market/src/feature/home/data/bloc/meta_state.dart';

class PreOrderDialog extends StatefulWidget {
  final Function()? onYesTap;
  const PreOrderDialog({super.key, this.onYesTap});

  @override
  State<PreOrderDialog> createState() => _PreOrderDialogState();
}

class _PreOrderDialogState extends State<PreOrderDialog> {
  @override
  Widget build(BuildContext context) {
    List<String> metas = [
      'Пользовательское соглашение',
      'Оферта для продавцов',
      'Политика конфиденциальности',
      'Типовой договор купли-продажи',
      'Типовой договор на оказание рекламных услуг'
    ];

    List<String> metasBody = [];

    return CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          'Внимание',
        ),
      ),
      content: BlocBuilder<MetaCubit, MetaState>(builder: (context, state) {
        if (state is LoadedState) {
          metasBody.addAll([
            state.metas.terms_of_use!,
            state.metas.privacy_policy!,
            state.metas.contract_offer!,
            state.metas.shipping_payment!,
            state.metas.TTN!,
          ]);
          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              children: <TextSpan>[
                const TextSpan(
                    text:
                        'Данный товар не в наличии,но доступен к предзаказу, нажимая ДА вы принимаете условия покупки по предзаказу, '),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(() => MetasPage(
                          title: metas[3],
                          body: metasBody[3],
                        )),
                  text: 'типового договора купли продажи',
                  style: const TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: widget.onYesTap,
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
