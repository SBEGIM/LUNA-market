import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/edit_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/edit_blogger_statet.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
// import '../../auth/bloc/edit_blogger_cubit.dart';
// import '../../auth/bloc/edit_blogger_statet.dart';

class ReqirectProfilePage extends StatefulWidget {
  final String title;
  ReqirectProfilePage({required this.title, Key? key}) : super(key: key);

  @override
  State<ReqirectProfilePage> createState() => _ReqirectProfilePageState();
}

class _ReqirectProfilePageState extends State<ReqirectProfilePage> {
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  TextEditingController phoneController =
      MaskedTextController(mask: '(000)-000-00-00');
  final passwordController = TextEditingController();
  final iinController = TextEditingController();
  final socialNetworkController = TextEditingController();
  final emailController = TextEditingController();
  final reapatPasswordController = TextEditingController();
  final checkController = TextEditingController();

  final _box = GetStorage();
  bool change = false;
  bool _obscureText = true;
  bool _obscureTextRepeat = true;

  CountrySellerDto? countrySellerDto;

  Map<String, String?> fieldErrors = {
    'phone': null,
    'password': null,
  };

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  void _initializeControllers() {
    countrySellerDto = CountrySellerDto(
        code: '+7', flagPath: Assets.icons.ruFlagIcon.path, name: 'Россия');
    nameController.text = _box.read('blogger_name') ?? '';
    phoneController.text = _box.read('blogger_phone') ?? '(000)-000-00-00';
    nickNameController.text = _box.read('blogger_nick_name') ?? '';
    iinController.text = _box.read('blogger_iin') != 'null'
        ? (_box.read('blogger_iin') ?? '')
        : '';
    socialNetworkController.text = _box.read('blogger_social_network') ?? '';
    emailController.text = _box.read('blogger_email') ?? '';
    checkController.text = _box.read('blogger_invoice') != 'null'
        ? (_box.read('blogger_invoice') ?? '')
        : '';
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
      fieldErrors['phone'] =
          phone.length != 10 ? 'Введите корректный номер телефона' : null;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${widget.title}',
          style: AppTextStyles.appBarTextStyle,
        ),
      ),
      body: BlocConsumer<EditBloggerCubit, EditBloggerState>(
        listener: (context, state) {
          if (state is LoadedState) {
            Get.back(result: 'ok');
          }
        },
        builder: (context, state) {
          if (state is InitState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: widget.title == 'Основная информация',
                            child: Column(children: [
                              _buildFormField(
                                controller: nameController,
                                label: 'Фамилия',
                              ),
                              _buildFormField(
                                controller: nameController,
                                label: 'Имя',
                              ),
                              _buildFormField(
                                controller: nameController,
                                label: 'Отчество',
                              ),
                            ])),
                        Visibility(
                          visible: widget.title == 'Социальные сети',
                          child: Column(
                            children: [
                              _buildFormField(
                                controller: nickNameController,
                                label: 'Никнейм',
                              ),
                              _buildFormField(
                                controller: socialNetworkController,
                                label: 'Ссылка на социальную сеть',
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.title == 'Юридический статус',
                          child: Column(
                            children: [
                              _buildFormField(
                                controller: iinController,
                                label: 'Выберите статус',
                                keyboardType: TextInputType.number,
                              ),
                              _buildFormField(
                                controller: iinController,
                                label: 'ИИН',
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.title == 'Реквизиты банка',
                          child: Column(
                            children: [
                              _buildFormField(
                                controller: iinController,
                                label: 'Название банка',
                                keyboardType: TextInputType.number,
                              ),
                              _buildFormField(
                                controller: iinController,
                                label: 'БИК банка',
                                keyboardType: TextInputType.number,
                              ),
                              _buildFormField(
                                controller: checkController,
                                label: 'Счёт',
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.title == 'Контактные данные',
                          child: Column(
                            children: [
                              SizedBox(height: 8),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: AppColors.kGray2,
                                          border: fieldErrors['phone'] != null
                                              ? Border.all(
                                                  color: AppColors.mainRedColor,
                                                  width: 1.0)
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              countrySellerDto!.flagPath,
                                              width: 24,
                                              height: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Text('${countrySellerDto!.code}',
                                                style: AppTextStyles
                                                    .size16Weight400),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  // Поле ввода
                                  Flexible(
                                    child: Container(
                                      height: 52,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: AppColors.kGray2,
                                        borderRadius: BorderRadius.circular(16),
                                        border: fieldErrors['phone'] != null
                                            ? Border.all(
                                                color: AppColors.mainRedColor,
                                                width: 1.0)
                                            : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: phoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          hintText: 'Введите номер телефона',
                                          hintStyle: AppTextStyles
                                              .size16Weight400
                                              .copyWith(
                                                  color: Color(0xFF8E8E93)),
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
                              // _buildPasswordField(
                              //   controller: passwordController,
                              //   label: 'Пароль',
                              //   obscureText: _obscureText,
                              //   onToggle: () {
                              //     setState(() {
                              //       _obscureText = !_obscureText;
                              //     });
                              //   },
                              // ),
                              // _buildPasswordField(
                              //   controller: reapatPasswordController,
                              //   label: 'Подтвердите пароль',
                              //   obscureText: _obscureTextRepeat,
                              //   onToggle: () {
                              //     setState(() {
                              //       _obscureTextRepeat = !_obscureTextRepeat;
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomSheet: _buildSaveButton(context),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyles.size13Weight500
                  .copyWith(color: Color(0xFF636366))),
          const SizedBox(height: 8),
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Color(0xffEAECED),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите $label',
                  hintStyle: AppTextStyles.size16Weight400
                      .copyWith(color: Color(0xFF8E8E93)),
                  contentPadding:
                      EdgeInsets.zero, // Better control over padding
                  isDense: true,
                ),
                style: AppTextStyles.size16Weight400),
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
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: obscureText,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: onToggle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
      width: double.infinity,
      color: AppColors.kWhite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainPurpleColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () async {
          if (nameController.text.isNotEmpty ||
              nickNameController.text.isNotEmpty) {
            if (passwordController.text == reapatPasswordController.text) {
              final edit = BlocProvider.of<EditBloggerCubit>(context);
              await edit.edit(
                nameController.text,
                nickNameController.text,
                phoneController.text,
                passwordController.text,
                iinController.text,
                checkController.text,
                '',
                '',
                emailController.text,
                socialNetworkController.text,
              );
            }
          }
        },
        child: Text(
          'Сохранить',
          style:
              AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
        ),
      ),
    );
  }
}
