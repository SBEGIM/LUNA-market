import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/admin/auth/presentation/ui/auth_admin_page.dart';

import 'package:haji_market/core/common/constants.dart';

class CoopRequestPage extends StatefulWidget {
  CoopRequestPage({Key? key}) : super(key: key);

  @override
  State<CoopRequestPage> createState() => _CoopRequestPageState();
}

class _CoopRequestPageState extends State<CoopRequestPage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Заявка на сотрудничество',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: ListView(
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Укажите данные Вашего бизнеса',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.kGray900),
                ),
                SizedBox(
                  height: 10,
                ),
                FieldsCoopRequest(
                  titleText: 'ИИН/БИН ',
                  hintText: 'Введите ИИН/БИН',
                  star: false,
                  arrow: false,
                ),
                FieldsCoopRequest(
                    titleText: 'Название компании ',
                    hintText: 'Введите название компании',
                    star: false,
                    arrow: false),
                FieldsCoopRequest(
                  titleText: 'Основная категория товаров ',
                  hintText: 'Выберите категорию',
                  star: false,
                  arrow: false,
                ),
                FieldsCoopRequest(
                  titleText: 'Контактное имя ',
                  hintText: 'Введите контактное имя',
                  star: false,
                  arrow: false,
                ),
                FieldsCoopRequest(
                  titleText: 'Мобильный телефон ',
                  hintText: 'Введите мобильный телефон ',
                  star: false,
                  arrow: false,
                ),
                FieldsCoopRequest(
                  titleText: 'Email ',
                  hintText: 'Введите Email',
                  star: false,
                  arrow: false,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(Colors.),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const SizedBox(width: 5),
                const Flexible(
                    child: Text(
                  'Я согласен на обработку персональных данных',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthAdminPage()),
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
                'Продолжить',
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

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  const FieldsCoopRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                titleText,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.kGray900),
              ),
              star != true
                  ? const Text(
                      '*',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.red),
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(194, 197, 200, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    // borderRadius: BorderRadius.circular(3),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/back_menu.svg ',
                          color: Colors.grey)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
