import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/ui/city_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/country_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app/widgets/custom_back_button.dart';
import '../../../../auth/data/bloc/login_cubit.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String phone;
  final String gender;
  final String birthday;
  final String country;
  final String city;
  final String street;
  final String home;
  final String porch;
  final String floor;
  final String room;
  final String email;

  const EditProfilePage(
      {required this.name,
      required this.phone,
      required this.gender,
      required this.birthday,
      required this.country,
      required this.city,
      required this.street,
      required this.home,
      required this.porch,
      required this.floor,
      required this.room,
      required this.email,
      Key? key})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerRepeat = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController kvController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController doorController = TextEditingController();
  TextEditingController spaceController = TextEditingController();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;
  bool woman = false;
  bool man = false;
  bool showGender = false;
  String gender = '';

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
  void initState() {
    userNameController.text = widget.name;
    phoneController.text = widget.phone;
    gender = widget.gender;
    birthdayController.text = widget.birthday;
    countryController.text = widget.country;
    cityController.text = widget.city;
    streetController.text = widget.street;
    homeController.text = widget.home;
    kvController.text = widget.room;
    spaceController.text = widget.floor;
    doorController.text = widget.porch;
    emailController.text = widget.email;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(mask: '+7(###)-###-##-##');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
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
                      textCancel: 'Фото',
                      titlePadding: const EdgeInsets.only(top: 40),
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
                                    "https://lunamarket.ru/storage/${_box.read('avatar')}"),
                                fit: BoxFit.cover,
                              ))
                          : null,
                      child: _box.read('avatar') == null ||
                              _box.read('avatar') == 'null'
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
              widget.name,
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
            padding: const EdgeInsets.all(16),
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
                                controller: userNameController,
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
                                    height: 19,
                                    width: 19,
                                  ),
                                  title: gender != ''
                                      ? Text(
                                          gender != 'y' ? 'Мужской' : 'Женский')
                                      : const Text('Пол'),
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
                                    padding: const EdgeInsets.only(left: 52.0),
                                    child: const Text(
                                      'Женский',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    checkColor: Colors.white,
                                    activeColor: AppColors.kPrimaryColor,
                                    value: woman,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        woman = value!;
                                        man = false;
                                        gender = 'y';
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.only(left: 22.5),
                                    child: const Text(
                                      'Мужской',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    checkColor: Colors.white,
                                    activeColor: AppColors.kPrimaryColor,
                                    value: man,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        man = value!;
                                        woman = false;
                                        gender = 'x';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: SvgPicture.asset(
                                'assets/icons/date_edit.svg',
                                height: 24,
                                width: 24,
                              ),
                              title: TextField(
                                controller: birthdayController,
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
                            // GestureDetector(
                            //   onTap: () async {
                            //     final data =
                            //         await Get.to(() => CountryWidget());
                            //     countryController.text = data;
                            //     setState(() {});
                            //   },
                            //   child: ListTile(
                            //     horizontalTitleGap: 0,
                            //     leading: SvgPicture.asset(
                            //       'assets/icons/country.svg',
                            //       height: 24,
                            //       width: 24,
                            //     ),
                            //     trailing: Image.asset(
                            //       'assets/icons/down.png',
                            //       height: 16.5,
                            //       width: 9.5,
                            //     ),
                            //     title: TextField(
                            //       controller: countryController,
                            //       decoration: const InputDecoration(
                            //         border: InputBorder.none,
                            //         hintText: 'Страна',
                            //         enabledBorder: UnderlineInputBorder(
                            //           borderSide:
                            //               BorderSide(color: Colors.white),
                            //           // borderRadius: BorderRadius.circular(3),
                            //         ),
                            //       ),
                            //     ),
                            //     // trailing: SvgPicture.asset(
                            //     //   'assets/icons/delete_circle.svg',
                            //     //   height: 24,
                            //     //   width: 24,
                            //     // ),
                            //   ),
                            // ),
                            // GestureDetector(
                            //   onTap: () async {
                            //     final data =
                            //         await Get.to(() => const CityPage());

                            //     cityController.text = data;
                            //     setState(() {});
                            //   },
                            //   child: ListTile(
                            //     horizontalTitleGap: 0,
                            //     leading: SvgPicture.asset(
                            //       'assets/icons/location.svg',
                            //       height: 24,
                            //       width: 24,
                            //     ),
                            //     trailing: Image.asset(
                            //       'assets/icons/down.png',
                            //       height: 16.5,
                            //       width: 9.5,
                            //     ),
                            //     title: TextField(
                            //       controller: cityController,
                            //       decoration: const InputDecoration(
                            //         border: InputBorder.none,
                            //         hintText: 'Город',
                            //         enabledBorder: UnderlineInputBorder(
                            //           borderSide:
                            //               BorderSide(color: Colors.white),
                            //           // borderRadius: BorderRadius.circular(3),
                            //         ),
                            //       ),
                            //     ),
                            //     // trailing: SvgPicture.asset(
                            //     //   'assets/icons/delete_circle.svg',
                            //     //   height: 24,
                            //     //   width: 24,
                            //     // ),
                            //   ),
                            // ),
                            // ListTile(
                            //   horizontalTitleGap: 0,
                            //   leading: SvgPicture.asset(
                            //     'assets/icons/street.svg',
                            //     height: 24,
                            //     width: 24,
                            //   ),
                            //   title: TextField(
                            //     controller: streetController,
                            //     decoration: const InputDecoration(
                            //       border: InputBorder.none,
                            //       hintText: 'Улица',
                            //       enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.white),
                            //         // borderRadius: BorderRadius.circular(3),
                            //       ),
                            //     ),
                            //   ),
                            // trailing: SvgPicture.asset(
                            //   'assets/icons/delete_circle.svg',
                            //   height: 24,
                            //   width: 24,
                            // ),
                            //),
                            // ListTile(
                            //   horizontalTitleGap: 0,
                            //   leading: SvgPicture.asset(
                            //     'assets/icons/Route.svg',
                            //     height: 24,
                            //     width: 24,
                            //   ),
                            //   title: TextField(
                            //     controller: homeController,
                            //     decoration: const InputDecoration(
                            //       border: InputBorder.none,
                            //       hintText: 'Дом',
                            //       enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.white),
                            //         // borderRadius: BorderRadius.circular(3),
                            //       ),
                            //     ),
                            //   ),
                            // trailing: SvgPicture.asset(
                            //   'assets/icons/delete_circle.svg',
                            //   height: 24,
                            //   width: 24,
                            // ),
                            // ),
                            // SizedBox(
                            //   height: 48,
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Container(
                            //             padding:
                            //                 const EdgeInsets.only(left: 16),
                            //             child: Row(
                            //               children: [
                            //                 SvgPicture.asset(
                            //                     'assets/icons/Door-open.svg'),
                            //                 const SizedBox(
                            //                   width: 21,
                            //                 ),
                            //                 Expanded(
                            //                   child: TextField(
                            //                     controller: doorController,
                            //                     decoration:
                            //                         const InputDecoration(
                            //                       border: InputBorder.none,
                            //                       hintText: 'Подъезд',
                            //                       enabledBorder:
                            //                           UnderlineInputBorder(
                            //                         borderSide: BorderSide(
                            //                             color: Colors.white),
                            //                         // borderRadius: BorderRadius.circular(3),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             )),
                            //       ),
                            //       const SizedBox(
                            //         width: 10,
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //             padding:
                            //                 const EdgeInsets.only(left: 16),
                            //             child: Row(
                            //               children: [
                            //                 SvgPicture.asset(
                            //                     'assets/icons/Stairs.svg'),
                            //                 const SizedBox(
                            //                   width: 21,
                            //                 ),
                            //                 Expanded(
                            //                   child: TextField(
                            //                     controller: spaceController,
                            //                     decoration:
                            //                         const InputDecoration(
                            //                       border: InputBorder.none,
                            //                       hintText: 'Этаж',
                            //                       enabledBorder:
                            //                           UnderlineInputBorder(
                            //                         borderSide: BorderSide(
                            //                             color: Colors.white),
                            //                         // borderRadius: BorderRadius.circular(3),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 //  const Text('3 этаж'),
                            //               ],
                            //             )),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // ListTile(
                            //   horizontalTitleGap: 0,
                            //   leading: SvgPicture.asset(
                            //     'assets/icons/Key.svg',
                            //     height: 24,
                            //     width: 24,
                            //   ),
                            //   title: TextField(
                            //     controller: kvController,
                            //     decoration: const InputDecoration(
                            //       border: InputBorder.none,
                            //       hintText: 'Квартира',
                            //       enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.white),
                            //         // borderRadius: BorderRadius.circular(3),
                            //       ),
                            //     ),
                            //   ),
                            //   // trailing: SvgPicture.asset(
                            //   //   'assets/icons/delete_circle.svg',
                            //   //   height: 24,
                            //   //   width: 24,
                            //   // ),
                            // ),
                            // ListTile(
                            //   horizontalTitleGap: 0,
                            //   leading: SvgPicture.asset(
                            //     'assets/icons/ion_mail-outline.svg',
                            //     height: 24,
                            //     width: 24,
                            //   ),
                            //   title: TextField(
                            //     controller: emailController,
                            //     decoration: const InputDecoration(
                            //       border: InputBorder.none,
                            //       hintText: 'Почта',
                            //       enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(color: Colors.white),
                            //         // borderRadius: BorderRadius.circular(3),
                            //       ),
                            //     ),
                            //   ),
                            //   // trailing: SvgPicture.asset(
                            //   //   'assets/icons/delete_circle.svg',
                            //   //   height: 24,
                            //   //   width: 24,
                            //   // ),
                            // ),
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
      bottomSheet: Container(
        color: const Color.fromRGBO(252, 252, 252, 1),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () async {
            final edit = BlocProvider.of<LoginCubit>(context);
            await edit.edit(
                userNameController.text,
                phoneController.text != widget.phone
                    ? phoneController.text
                    : '',
                _image != null ? _image!.path : "",
                gender,
                birthdayController.text,
                countryController.text,
                cityController.text,
                streetController.text,
                homeController.text,
                doorController.text,
                spaceController.text,
                kvController.text,
                emailController.text);

            Get.back(result: 'ok');
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
    );
  }
}
