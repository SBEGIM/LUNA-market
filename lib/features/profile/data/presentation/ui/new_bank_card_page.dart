import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';

class NewBankCardPage extends StatefulWidget {
  NewBankCardPage({Key? key}) : super(key: key);

  @override
  State<NewBankCardPage> createState() => _NewBankCardPageState();
}

class _NewBankCardPageState extends State<NewBankCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Новая карта',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Чтобы добавить новую карту, введите данные с передней и задней сторон вашей банковской карты',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.kGray400),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                          leading:
                              SvgPicture.asset('assets/icons/bank_card.svg'),
                          title: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Дайте название',
                                hintStyle:
                                    TextStyle(color: AppColors.kGray300)),
                          ),
                          trailing: SvgPicture.asset(
                              'assets/icons/delete_circle.svg'),
                        ),
                        ListTile(
                          leading: SvgPicture.asset('assets/icons/user.svg'),
                          title: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Имя держателя',
                                hintStyle:
                                    TextStyle(color: AppColors.kGray300)),
                          ),
                          trailing: SvgPicture.asset(
                              'assets/icons/delete_circle.svg'),
                        ),
                        ListTile(
                          leading:
                              SvgPicture.asset('assets/icons/card_bank1.svg'),
                          title: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Номер карты',
                                hintStyle:
                                    TextStyle(color: AppColors.kGray300)),
                          ),
                          trailing:
                              SvgPicture.asset('assets/icons/master_card.svg'),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: const [
                              Flexible(
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Срок действия',
                                      hintStyle:
                                          TextStyle(color: AppColors.kGray300)),
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'CVV',
                                      hintStyle:
                                          TextStyle(color: AppColors.kGray300)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DefaultButton(
                    backgroundColor: AppColors.kPrimaryColor,
                    text: 'Добавить',
                    press: () {},
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width)
              ],
            ),
          )
        ],
      ),
    );
  }
}
