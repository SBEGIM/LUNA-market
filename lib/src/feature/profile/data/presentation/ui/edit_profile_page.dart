import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/profile/data/presentation/widgets/show_blogger_register_type_widget.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../auth/bloc/login_cubit.dart';

class EditProfilePage extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? surName;
  final String? phone;
  final String? gender;
  final String? birthday;
  final String? email;

  const EditProfilePage({
    required this.firstName,
    required this.lastName,
    required this.surName,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
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
  TextEditingController genController = TextEditingController();

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
  CountrySellerDto? countrySellerDto;

  Map<String, String?> fieldErrors = {'phone': null, 'password': null};

  @override
  void initState() {
    countrySellerDto = CountrySellerDto(
      code: '+7',
      flagPath: Assets.icons.ruFlagIcon.path,
      name: 'Россия',
    );
    firstNameController.text = widget.firstName ?? '';
    lastNameController.text = widget.lastName ?? '';
    surNameController.text = widget.surName ?? '';
    phoneController.text = widget.phone ?? '';
    gender = widget.gender ?? '';
    birthdayController.text = widget.birthday ?? '';
    emailController.text = widget.email ?? '';
    super.initState();
  }

  String? _validateError() {
    final rawDigits = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawDigits.length != 10) return 'Введите корректный номер телефона';

    final pass = passwordController.text;
    if (pass.isEmpty) return 'Введите пароль';

    return null;
  }

  void _validateFields() {
    final phone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final pass = passwordController.text;

    setState(() {
      fieldErrors['phone'] = phone.length != 10 ? 'Введите корректный номер телефона' : null;

      fieldErrors['password'] = pass.isEmpty ? 'Введите пароль' : null;
    });
  }

  bool _ensureValid() {
    final msg = _validateError();
    if (msg != null) {
      AppSnackBar.show(context, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  final maskFormatter = MaskTextInputFormatter(mask: '+7(###)-###-##-##');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhite,
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Мои данные', style: AppTextStyles.size18Weight600),
        leading: InkWell(
          onTap: () {
            Get.back(result: 'ok');
          },
          child: Image.asset(Assets.icons.defaultBackIcon.path, height: 24, width: 24, scale: 1.9),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField(controller: firstNameController, label: 'Имя'),
                    _buildFormField(controller: lastNameController, label: 'Фамилия'),
                    _buildFormField(controller: surNameController, label: 'Отчество'),
                    Text(
                      'Номер телефона',
                      style: AppTextStyles.size13Weight500.copyWith(color: Color(0xff636366)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showSellerLoginPhone(
                              context,
                              countryCall: (dto) {
                                countrySellerDto = dto;
                                setState(() {});
                              },
                            );
                          },
                          child: Shimmer(
                            child: Container(
                              height: 52,
                              width: 83,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffEAECED),
                                border: fieldErrors['phone'] != null
                                    ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                                    : null,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(countrySellerDto!.flagPath, width: 24, height: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    '${countrySellerDto!.code}',
                                    style: AppTextStyles.size16Weight400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Flexible(
                          child: Container(
                            height: 52,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.kGray2,
                              borderRadius: BorderRadius.circular(16),
                              border: fieldErrors['phone'] != null
                                  ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Введите номер телефона',
                                hintStyle: AppTextStyles.size16Weight400.copyWith(
                                  color: Color(0xFF8E8E93),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildFormField(
                      controller: emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildDateOfBirthField(
                      callback: () {
                        setState(() {});
                      },
                      context: context,
                      controller: birthdayController,
                      label: 'Дата рождения',
                    ),
                    _buildFormField(
                      controller: genController,
                      label: 'Выберите пол',
                      readOnly: true,
                      onTap: () {
                        showGenderType(
                          context,
                          gender == 'x' ? true : false,
                          typeCall: (value) {
                            print(value);

                            if (value == true) {
                              man = true;
                              woman = false;
                              gender = 'x';
                            } else {
                              woman = true;
                              man = false;
                              gender = 'y';
                            }

                            setState(() {});
                          },
                        );
                      },
                      showArrow: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 42),
        child: InkWell(
          onTap: () async {
            final edit = BlocProvider.of<LoginCubit>(context);
            await edit.edit(
              firstNameController.text,
              lastNameController.text,
              surNameController.text,
              phoneController.text != widget.phone ? phoneController.text : '',
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
              emailController.text,
            );

            Get.back(result: 'ok');
            // Navigator.pop(context);
          },
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.mainPurpleColor,
            ),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              'Сохранить',
              style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildFormField({
  required TextEditingController controller,
  required String label,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  bool readOnly = false,
  VoidCallback? onTap,
  bool showArrow = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.size13Weight500.copyWith(color: Color(0xff636366))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: readOnly ? onTap : null,
          child: Container(
            height: 52,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xffEAECED),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AbsorbPointer(
                    absorbing: readOnly,
                    child: TextField(
                      controller: controller,
                      keyboardType: keyboardType,
                      inputFormatters: inputFormatters,
                      readOnly: readOnly,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Введите $label',
                        hintStyle: AppTextStyles.size16Weight400.copyWith(color: Color(0xff8E8E93)),
                      ),
                      style: AppTextStyles.size16Weight400,
                    ),
                  ),
                ),
                if (showArrow) const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPasswordField({
  required TextEditingController controller,
  required String label,
  required bool obscureText,
  required VoidCallback onToggle,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.size13Weight500.copyWith(color: Color(0xff636366))),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xffEAECED),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              InkWell(
                onTap: onToggle,
                child: Image.asset(
                  obscureText
                      ? Assets.icons.passwordViewHiddenIcon.path
                      : Assets.icons.passwordViewIcon.path,
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDateOfBirthField({
  required TextEditingController controller,
  required String label,
  required Function callback,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.size13Weight500.copyWith(color: Color(0xff636366))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              // locale: Locale('ru'),
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {
              controller.text =
                  "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";

              callback.call();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.text.isEmpty ? 'дд.дд.гггг' : controller.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
