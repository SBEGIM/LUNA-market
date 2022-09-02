import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReqirectProfilePage extends StatefulWidget {
  ReqirectProfilePage({Key? key}) : super(key: key);

  @override
  State<ReqirectProfilePage> createState() => _ReqirectProfilePageState();
}

class _ReqirectProfilePageState extends State<ReqirectProfilePage> {
  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: AppColors.kPrimaryColor,
        //   ),
        // ),
        centerTitle: true,
        title: const Text(
          'Редактирование профиля',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.timer,
              color: AppColors.kPrimaryColor,
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () {
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
                'Сохранить',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: ClipOval(
              child: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                  'assets/images/wireles.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text(
              'Маржан Жумадилова',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.kGray900,
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: AppColors.kGray700,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Чтобы поменять текущий пароль, необходимо сначала ввести старый правильно, а затем придумать новый',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.kGray300),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/user.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Имя и фамилия',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        // trailing: SvgPicture.asset(
                        //   'assets/icons/delete_circle.svg',
                        //   height: 24,
                        //   width: 24,
                        // ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/phone.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [maskFormatter],
                          // controller: phoneControllerAuth,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '+7(777) 777-71-18',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/password.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: const TextField(
                          keyboardType: TextInputType.phone,
                          // inputFormatters: [maskFormatter],
                          // controller: phoneControllerAuth,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' Пароль',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/password.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: const TextField(
                          keyboardType: TextInputType.phone,
                          // inputFormatters: [maskFormatter],
                          // controller: phoneControllerAuth,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Подтвердите пароль',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
