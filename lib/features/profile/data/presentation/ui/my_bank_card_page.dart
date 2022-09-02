import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/profile/data/presentation/ui/new_bank_card_page.dart';
import 'package:haji_market/features/profile/data/presentation/widgets/show_dialog_redirect.dart';

import '../../../../../core/common/constants.dart';

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
        backgroundColor: Colors.white,
        title: const Text(
          'Мои карты',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
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
                children: [
                  ListTile(
                      leading: const Icon(
                        Icons.credit_card,
                        color: AppColors.kPrimaryColor,
                      ),
                      title: const Text('Kaspi Gold'),
                      trailing: InkWell(
                          onTap: () {
                            showDialogRegirect(context);
                          },
                          child:
                              const Icon(Icons.vertical_distribute_outlined))),
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/user.svg'),
                    title: const Text('ULAN SHOTEYULY'),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.credit_card,
                      color: AppColors.kPrimaryColor,
                    ),
                    title: Text('4400-4400-4400-4400'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: const [
                        Text('04/23'),
                        SizedBox(
                          width: 150,
                        ),
                        Text('04/23'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewBankCardPage()),
            );
            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Добавить новую карту',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
