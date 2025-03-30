import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/widgets/custom_back_button.dart';

@RoutePage()
class InitSellerPage extends StatefulWidget {
  final String shopName;
  const InitSellerPage({required this.shopName, Key? key}) : super(key: key);

  @override
  State<InitSellerPage> createState() => _InitSellerPageState();
}

class _InitSellerPageState extends State<InitSellerPage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;
  TextEditingController shopNameController = TextEditingController();

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
    shopNameController.text = widget.shopName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 22.0),
        //     child: CustomDropButton(
        //       onTap: () {},
        //     ),
        //   ),
        // ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Регистрация магазина',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
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
                  },
                  child: Container(
                      height: 120,
                      width: 120,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          SvgPicture.asset('assets/icons/border.svg'),
                          Center(
                              child: _image != null
                                  ? CircleAvatar(
                                      backgroundImage: FileImage(
                                        File(_image!.path),
                                      ),
                                      radius: 34,
                                      child: Container())
                                  : SvgPicture.asset(
                                      'assets/icons/camera2.svg')),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'ЗАГРУЗИТЬ ЛОГОТИП',
                  style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/shop1.svg',
                  height: 24,
                  width: 24,
                  color: const Color.fromRGBO(28, 189, 199, 1),
                ),
                minLeadingWidth: 10,
                title: TextField(
                  controller: shopNameController,
                  cursorColor: const Color.fromRGBO(31, 196, 207, 1),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Название магазина',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(170, 174, 179, 1)),
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
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.01,
            ),
            child: DefaultButton(
                backgroundColor: AppColors.kPrimaryColor,
                text: 'Войти',
                press: () {
                  context.router.popUntil(
                      (route) => route.settings.name == LauncherRoute.name);
                  BlocProvider.of<AppBloc>(context).add(
                      const AppEvent.chageState(
                          state: AppState.inAppAdminState()));

                  //                    Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // );
                },
                color: Colors.white,
                width: 343),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
