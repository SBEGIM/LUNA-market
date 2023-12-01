import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../../core/common/constants.dart';
import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../auth/data/bloc/edit_blogger_cubit.dart';

class BloggerCardPage extends StatefulWidget {
  String check;
  String card;

  BloggerCardPage({required this.check, required this.card, Key? key}) : super(key: key);

  @override
  State<BloggerCardPage> createState() => _BloggerCardPageState();
}

class _BloggerCardPageState extends State<BloggerCardPage> {
  TextEditingController cardController = MaskedTextController(mask: '0000-0000-0000-0000');

  TextEditingController checkController = TextEditingController();

  @override
  void initState() {
    checkController.text = widget.check;
    cardController.text = widget.card;

    super.initState();
  }

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
          'Мои карты',
          style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
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
                    padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Реквизит текущего счета',
                      style:
                          TextStyle(color: Color.fromRGBO(29, 196, 207, 1), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: checkController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Укажите реквизиты',
                        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.credit_card,
                      color: AppColors.kPrimaryColor,
                    ),
                    title: TextField(
                      keyboardType: TextInputType.number,
                      controller: cardController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Введите карту',
                        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          // borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        cardController.clear();
                      },
                      child: const Icon(
                        Icons.delete,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () async {
            // print('object');
            final edit = BlocProvider.of<EditBloggerCubit>(context);
            await edit.edit('', '', '', '', checkController.text, '', null, cardController.text, '', '');

            //Get.to(const BloggerNewCardPage());
            // GetStorage().write('blogger_invoice', checkController.text);

            Navigator.pop(context);
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
