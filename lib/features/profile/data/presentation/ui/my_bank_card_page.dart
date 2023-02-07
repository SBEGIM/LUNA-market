import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/features/profile/data/presentation/ui/new_bank_card_page.dart';
import 'package:haji_market/features/profile/data/presentation/widgets/show_dialog_redirect.dart';

import '../../../../../core/common/constants.dart';
import '../../../../app/widgets/custom_back_button.dart';

class MyBankCardPage extends StatefulWidget {
  const MyBankCardPage({Key? key}) : super(key: key);

  @override
  State<MyBankCardPage> createState() => _MyBankCardPageState();
}

class _MyBankCardPageState extends State<MyBankCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Способы оплаты',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
              height: 86,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Реквизит текущего счета',
                      style: TextStyle(
                          color: Color.fromRGBO(29, 196, 207, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Укажите реквизиты',
                        hintStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          // borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(
                      Icons.credit_card,
                      color: AppColors.kPrimaryColor,
                    ),
                    title: Text('********1254-4400'),
                    trailing: Icon(
                      Icons.delete,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: DefaultButton(
          text: 'Добавить карту',
          press: () {},
          color: AppColors.kWhite,
          backgroundColor: AppColors.kPrimaryColor,
          width: 300),
    );
  }
}
