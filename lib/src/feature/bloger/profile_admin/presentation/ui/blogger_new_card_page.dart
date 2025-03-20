import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../../core/common/constants.dart';
import '../../../../app/widgets/custom_back_button.dart';

class BloggerNewCardPage extends StatefulWidget {
  const BloggerNewCardPage({Key? key}) : super(key: key);

  @override
  State<BloggerNewCardPage> createState() => _BloggerNewCardPageState();
}

class _BloggerNewCardPageState extends State<BloggerNewCardPage> {
  TextEditingController _cardController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '#### - #### - #### - ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

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
          'Добавить новую карту',
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
              alignment: Alignment.center,
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
              padding: const EdgeInsets.only(left: 12),
              // margin: const EdgeInsets.only(left: 16),
              child: TextField(
                textAlign: TextAlign.left,
                keyboardType: TextInputType.text,
                inputFormatters: [maskFormatter],
                controller: _cardController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите номер карты',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    // borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () async {
            Get.back();
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Сохранить',
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
