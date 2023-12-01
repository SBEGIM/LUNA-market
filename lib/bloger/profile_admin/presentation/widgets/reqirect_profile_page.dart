import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/bloger/auth/data/bloc/edit_blogger_cubit.dart';
import 'package:haji_market/bloger/profile_admin/presentation/ui/blogger_profile_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../auth/data/bloc/edit_blogger_statet.dart';

class ReqirectProfilePage extends StatefulWidget {
  const ReqirectProfilePage({Key? key}) : super(key: key);

  @override
  State<ReqirectProfilePage> createState() => _ReqirectProfilePageState();
}

class _ReqirectProfilePageState extends State<ReqirectProfilePage> {
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final iinController = TextEditingController();
  final socialNetworkController = TextEditingController();
  final emailController = TextEditingController();
  final reapatPasswordController = TextEditingController();
  final checkController = TextEditingController();

  final _box = GetStorage();
  bool change = false;

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
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
    nameController.text = GetStorage().read('blogger_name') ?? '';
    nickNameController.text = GetStorage().read('blogger_nick_name') ?? '';
    iinController.text = GetStorage().read('blogger_iin') != 'null' ? (GetStorage().read('blogger_iin') ?? '') : '';
    socialNetworkController.text = GetStorage().read('blogger_social_network') ?? '';
    emailController.text = GetStorage().read('blogger_email') ?? '';
    checkController.text =
        GetStorage().read('blogger_invoice') != 'null' ? (GetStorage().read('blogger_invoice') ?? '') : '';
    // phoneController.text = GetStorage().read('blogger_phone') ?? '';

    super.initState();
  }

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
          'Редактирование профиля',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 16.0), child: SvgPicture.asset('assets/icons/notification.svg'))
        ],
      ),
      body: BlocConsumer<EditBloggerCubit, EditBloggerState>(listener: (context, state) {
        if (state is LoadedState) {
          // Get.to(() => const ProfileBloggerPage());

          Get.back(result: 'ok');
        }
      }, builder: (context, state) {
        if (state is InitState) {
          return ListView(
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
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                          image: _box.read('blogger_avatar') != null
                              ? NetworkImage("http://185.116.193.73/storage/${_box.read('blogger_avatar')}")
                              : const AssetImage('assets/icons/profile2.png') as ImageProvider,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                title: Text(
                  _box.read('blogger_nick_name') ?? 'Никнэйм не найден',
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.kGray900, fontSize: 16),
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
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.kGray300),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
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
                            leading: Image.asset(
                              'assets/icons/company.png',
                              height: 24,
                              width: 24,
                            ),
                            title: TextField(
                              controller: nickNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Никнейм',
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
                              'assets/icons/bin.png',
                              height: 24,
                              width: 24,
                            ),
                            title: TextField(
                              keyboardType: TextInputType.number,
                              controller: iinController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ИИН',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/street.svg',
                              height: 24,
                              width: 24,
                            ),
                            title: TextField(
                              keyboardType: TextInputType.number,
                              controller: socialNetworkController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Ссылка на соц сеть',
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
                              keyboardType: TextInputType.number,
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
                          ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/password.svg',
                              height: 24,
                              width: 24,
                            ),
                            title: TextField(
                              keyboardType: TextInputType.text,
                              // inputFormatters: [maskFormatter],
                              controller: passwordController,
                              decoration: const InputDecoration(
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
                            title: TextField(
                              keyboardType: TextInputType.text,
                              // inputFormatters: [maskFormatter],
                              controller: reapatPasswordController,
                              decoration: const InputDecoration(
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
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
        }
      }),
      bottomSheet: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () async {
            if (nameController.text.isNotEmpty || nickNameController.text.isNotEmpty) {
              if (passwordController.text == reapatPasswordController.text) {}

              final edit = BlocProvider.of<EditBloggerCubit>(context);
              await edit.edit(
                  nameController.text,
                  nickNameController.text,
                  phoneController.text,
                  passwordController.text,
                  iinController.text,
                  checkController.text,
                  _image != null ? _image!.path : null,
                  '',
                  emailController.text,
                  socialNetworkController.text);
            }
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
