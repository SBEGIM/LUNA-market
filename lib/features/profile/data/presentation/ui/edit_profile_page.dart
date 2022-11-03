import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app/widgets/custom_back_button.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  EditProfilePage({required this.name ,Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {



 TextEditingController passwordController = TextEditingController();
 TextEditingController passwordControllerRepeat = TextEditingController();

bool _obscureText = false;
bool _obscureTextRepeat = false;
  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(mask: '+7(###)-###-##-##');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
       // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Редактирование профиля',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset('assets/icons/notification.svg'))
        ],
      ),
      bottomSheet: Container(
        color:  AppColors.kBackgroundColor,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () {
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
            height: 28,
          ),
          ListTile(
             horizontalTitleGap: 12,
                leading: CircleAvatar(
                  backgroundImage: const AssetImage('assets/images/kana.png'),
                  radius: 34,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      'assets/icons/camera.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            title:  Text(
              '${widget.name}',
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.kGray900,
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            color: Color.fromRGBO(225,227,229, 1),
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
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const[
                       BoxShadow(
                        color: Colors.grey,
                        offset:  Offset(
                          0.3,
                          0.3,
                        ),
                        blurRadius: 0.5,
                        spreadRadius:0.3,
                      ), //BoxShadow//BoxShadow
                    ],
                  ),
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
                        title: TextField(
                          controller: passwordController,

                          decoration:const InputDecoration(
                            hintText: 'Пароль',
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          obscureText: _obscureText,
                        ),
                          trailing : GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child:
                            new Icon(_obscureText ? Icons.visibility_off : Icons.visibility ),
                          )
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/password.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          controller: passwordControllerRepeat,
                          decoration:const InputDecoration(
                            hintText: 'Введите новый пароль',
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          obscureText: _obscureTextRepeat,
                        ),
                          trailing : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureTextRepeat = !_obscureTextRepeat;
                                });
                              },
                          child:
                          new Icon(_obscureTextRepeat ? Icons.visibility_off : Icons.visibility ),
                          )
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
