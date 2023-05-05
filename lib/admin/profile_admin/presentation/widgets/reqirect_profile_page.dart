import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/home/data/bloc/popular_shops_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../features/drawer/presentation/ui/city_page.dart';
import '../../../../features/drawer/presentation/widgets/country_widget.dart';
import '../../data/bloc/profile_edit_admin_cubit.dart';

class ReqirectProfilePage extends StatefulWidget {
  const ReqirectProfilePage({Key? key}) : super(key: key);

  @override
  State<ReqirectProfilePage> createState() => _ReqirectProfilePageState();
}

class _ReqirectProfilePageState extends State<ReqirectProfilePage> {
  final _box = GetStorage();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  bool change = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController checkController = TextEditingController();

  Future<void> _getImage() async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    if (_box.read('seller_name') != null) {
      shopNameController.text = _box.read('seller_name') ?? '11';
    }
    if (_box.read('seller_phone') != null) {
      phoneController.text = _box.read('seller_phone') ?? '22';
    }

    if (_box.read('seller_email') != null) {
      emailController.text = _box.read('seller_email') ?? '33';
    }
    print(_box.read('seller_country'));
    //_box.write('seller_country', 'kz');

    countryController.text = _box.read('seller_country');

    // if (_box.read('seller_country')) {
    //   countryController.text = _box.read('seller_country').toString() ?? '44';
    // }

    if (_box.read('seller_city') != null) {
      cityController.text = _box.read('seller_city') ?? '55';
    }

    if (_box.read('seller_home') != null) {
      homeController.text = _box.read('seller_home') ?? '66';
    }
    if (_box.read('seller_street') != null) {
      streetController.text = _box.read('seller_street') ?? '77';
    }
    if (_box.read('seller_iin') != null) {
      iinController.text = _box.read('seller_iin') ?? '88';
    }
    if (_box.read('seller_check') != null) {
      checkController.text = _box.read('seller_check') ?? '99';
    }

    super.initState();
  }

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
        centerTitle: true,
        title: const Text(
          'Редактирование профиля',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset('assets/icons/notification.svg'))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
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
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    'http://185.116.193.73/storage/${GetStorage().read('seller_image')}'),
                radius: 34,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    'assets/icons/camera.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(
              '${GetStorage().read('seller_name')}',
              style: const TextStyle(
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
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          'assets/icons/company.png',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          controller: shopNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Название компании',
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
                          'assets/icons/user.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Контактное имя',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/icons/bin.png',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          controller: iinController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ИИН/БИН',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/icons/check.png',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          controller: checkController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Счёт',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
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
                          controller: phoneController,
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
                        leading: Image.asset(
                          'assets/icons/email.png',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          keyboardType: TextInputType.text,
                          //inputFormatters: [maskFormatter],
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final data = await Get.to(() => CountryWidget());
                          countryController.text = data;
                          setState(() {});
                        },
                        child: ListTile(
                          horizontalTitleGap: 0,
                          leading: SvgPicture.asset(
                            'assets/icons/country.svg',
                            height: 24,
                            width: 24,
                          ),
                          trailing: Image.asset(
                            'assets/icons/down.png',
                            height: 16.5,
                            width: 9.5,
                          ),
                          title: TextField(
                            controller: countryController,
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
                      ),
                      GestureDetector(
                        onTap: () async {
                          final data = await Get.to(() => const CityPage());

                          cityController.text = data;
                          setState(() {});
                        },
                        child: ListTile(
                          horizontalTitleGap: 0,
                          leading: SvgPicture.asset(
                            'assets/icons/location.svg',
                            height: 24,
                            width: 24,
                          ),
                          trailing: Image.asset(
                            'assets/icons/down.png',
                            height: 16.5,
                            width: 9.5,
                          ),
                          title: TextField(
                            controller: cityController,
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
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        leading: SvgPicture.asset(
                          'assets/icons/street.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          controller: streetController,
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
                          controller: homeController,
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
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/password.svg',
                          height: 24,
                          width: 24,
                        ),
                        title: TextField(
                          keyboardType: TextInputType.phone,
                          // inputFormatters: [maskFormatter],
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Старый пароль',
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
                          keyboardType: TextInputType.phone,
                          // inputFormatters: [maskFormatter],
                          controller: passwordRepeatController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            // hintText: 'Подтвердите пароль',
                            hintText: 'Новый пароль',
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
      bottomSheet: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () async {
            await BlocProvider.of<ProfileEditAdminCubit>(context).edit(
                nameController.text,
                phoneController.text,
                _image != null ? _image!.path : "",
                passwordRepeatController.text,
                passwordController.text,
                countryController.text,
                cityController.text,
                homeController.text,
                streetController.text,
                shopNameController.text,
                iinController.text,
                checkController.text,
                emailController.text);
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
    );
  }
}
