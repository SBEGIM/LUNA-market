import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app/widgets/custom_back_button.dart';
import '../../../../auth/data/bloc/login_cubit.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  EditProfilePage({required this.name, Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerRepeat = TextEditingController();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;
  bool woman = false;
  bool man = false;
  bool showGender = false;
  final _box = GetStorage();

  Future<void> _getImage() async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  bool _obscureText = false;
  bool _obscureTextRepeat = false;
  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(mask: '+7(###)-###-##-##');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(252, 252, 252, 1),
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
        color: const Color.fromRGBO(252, 252, 252, 1),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () async {
            Navigator.pop(context);
            final edit = BlocProvider.of<LoginCubit>(context);
            await edit.edit(nameController.text, phoneController.text,
                _image != null ? _image!.path : "");
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
            leading: GestureDetector(
              onTap: () {
                if (_image == null) {
                  Get.defaultDialog(
                      title: "Изменить фото",
                      middleText: '',
                      textConfirm: 'Камера',
                      textCancel: 'Галлерея',
                      titlePadding: EdgeInsets.only(top: 40),
                      onConfirm: () {
                        change = true;
                        setState(() {
                          change;
                        });
                        _getImage();
                      },
                      onCancel: () {
                        change = false;
                        setState(() {
                          change;
                        });
                        _getImage();
                      });
                }
              },
              child: _image != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(
                        File(_image!.path),
                      ),
                      radius: 34,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SvgPicture.asset(
                          'assets/icons/camera.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: 54,
                      width: 54,
                      decoration: _box.read('avatar') != null
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "http://80.87.202.73:8001/storage/${_box.read('avatar')}"),
                                fit: BoxFit.cover,
                              ))
                          : null,
                      child: _box.read('avatar') == null
                          ? CircleAvatar(
                              backgroundImage:
                                  const AssetImage('assets/icons/profile2.png'),
                              radius: 34,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: SvgPicture.asset(
                                  'assets/icons/camera.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
            ),
            title: Text(
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
            color: Color.fromRGBO(196, 200, 204, 1),
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
                  height: 420,
                  //  width: ,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(
                          0.3,
                          0.3,
                        ),
                        blurRadius: 0.5,
                        spreadRadius: 0.3,
                      ), //BoxShadow//BoxShadow
                    ],
                  ),
                  child: ListView(
                      //scrollDirection: Axis.vertical,
                      // physics: const NeverScrollableScrollPhysics(),
                      //  shrinkWrap: false,
                      children: [
                        Column(
                          children: [
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/user.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
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
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/phone.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [maskFormatter],
                                // controller: phoneControllerAuth,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '+7(000) 000-00-00',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    // borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showGender = !showGender;
                                });
                              },
                              child: ListTile(
                                  horizontalTitleGap: 0,
                                  leading: SvgPicture.asset(
                                    'assets/icons/gender.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                  title: TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Пол',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        // borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                  trailing: Image.asset(
                                    'assets/icons/down.png',
                                    height: 16.5,
                                    width: 9.5,
                                  )),
                            ),
                            Visibility(
                              visible: showGender,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 49.5),
                                    child: Text(
                                      'Женский',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    checkColor: Colors.white,
                                    activeColor: AppColors.kPrimaryColor,
                                    value: woman,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        woman = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.only(left: 22.5),
                                    child: Text(
                                      'Мужской',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    checkColor: Colors.white,
                                    activeColor: AppColors.kPrimaryColor,
                                    value: man,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        man = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/date.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Дата рождения',
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
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/country.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Страна',
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
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/location.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Город',
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
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/street.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Улица',
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
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/Route.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Дом',
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
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/Door-open.svg'),
                                        SizedBox(
                                          width: 21,
                                        ),
                                        Text('2 подъезд'),
                                      ],
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/Stairs.svg'),
                                        SizedBox(
                                          width: 21,
                                        ),
                                        Text('3 этаж'),
                                      ],
                                    )),
                              ],
                            ),
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/Key.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Квартира',
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
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/ion_mail-outline.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Почта',
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
                                horizontalTitleGap: 0,
                                leading: SvgPicture.asset(
                                  'assets/icons/password.svg',
                                  height: 24,
                                  width: 24,
                                ),
                                title: TextField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                    hintText: 'Пароль',
                                    border: InputBorder.none,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  obscureText: _obscureText,
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                )),
                            ListTile(
                                leading: SvgPicture.asset(
                                  'assets/icons/password.svg',
                                  height: 24,
                                  width: 24,
                                ),
                                horizontalTitleGap: 0,
                                title: TextField(
                                  controller: passwordControllerRepeat,
                                  decoration: const InputDecoration(
                                    hintText: 'Введите новый пароль',
                                    border: InputBorder.none,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  obscureText: _obscureTextRepeat,
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureTextRepeat = !_obscureTextRepeat;
                                    });
                                  },
                                  child: Icon(_obscureTextRepeat
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                )),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
