import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/edit_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/edit_blogger_statet.dart';
import 'package:haji_market/src/feature/bloger/auth/data/DTO/blogger_dto.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/show_blogger__type_widget.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ReqirectBloggerProfilePage extends StatefulWidget {
  final String title;
  const ReqirectBloggerProfilePage({required this.title, super.key});

  @override
  State<ReqirectBloggerProfilePage> createState() => _ReqirectProfilePageState();
}

class _ReqirectProfilePageState extends State<ReqirectBloggerProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final surNameController = TextEditingController();

  final nickNameController = TextEditingController();
  TextEditingController phoneController = MaskedTextController(mask: '(000)-000-00-00');
  final passwordController = TextEditingController();
  final iinController = TextEditingController();
  final legalStatusController = TextEditingController();

  final socialNetworkController = TextEditingController();
  final emailController = TextEditingController();
  final reapatPasswordController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankBikController = TextEditingController();

  final checkController = TextEditingController();

  final _box = GetStorage();
  bool change = false;
  String legalStatus = '';

  CountrySellerDto? countrySellerDto;

  Map<String, String?> fieldErrors = {'phone': null, 'password': null};

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  void _initializeControllers() {
    countrySellerDto = CountrySellerDto(
      code: '+7',
      flagPath: Assets.icons.ruFlagIcon.path,
      name: 'Россия',
    );

    firstNameController.text = _box.read('blogger_first_name') ?? '';
    lastNameController.text = _box.read('blogger_last_name') ?? '';
    surNameController.text = _box.read('blogger_sur_name') ?? '';

    phoneController.text = _box.read('blogger_phone') ?? '(000)-000-00-00';
    nickNameController.text = _box.read('blogger_nick_name') ?? '';
    iinController.text = _box.read('blogger_iin') != 'null' ? (_box.read('blogger_iin') ?? '') : '';
    socialNetworkController.text = _box.read('blogger_social_network') ?? '';
    emailController.text = _box.read('blogger_email') ?? '';
    bankNameController.text = _box.read('blogger_bank_name') ?? '';
    bankBikController.text = _box.read('blogger_bank_bik') ?? '';
    checkController.text = _box.read('blogger_invoice') != 'null'
        ? (_box.read('blogger_invoice') ?? '')
        : '';

    legalStatus = _box.read('blogger_legal_status');

    if (legalStatus != '') {
      legalStatusController.text = legalStatus != 'individual-entrepreneur' ? 'Самозанятый' : 'ИП';
    }
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
        title: Text(widget.title, style: AppTextStyles.appBarTextStyle),
      ),
      body: BlocConsumer<EditBloggerCubit, EditBloggerState>(
        listener: (context, state) {
          if (state is LoadedState) {
            Navigator.of(context).pop('ok');
          }
        },
        builder: (context, state) {
          if (state is InitState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: widget.title == 'Основная информация',
                          child: Column(
                            children: [
                              _buildFormField(controller: lastNameController, label: 'Фамилия'),
                              _buildFormField(controller: firstNameController, label: 'Имя'),
                              _buildFormField(controller: surNameController, label: 'Отчество'),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.title == 'Социальные сети',
                          child: Column(
                            children: [
                              _buildFormField(controller: nickNameController, label: 'Никнейм'),
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
                              _buildStatusField(
                                controller: legalStatusController,
                                label: 'Выберите статус',
                                readOnly: true,
                                onTap: () {
                                  showBloggerLegalStatusType(
                                    context,
                                    legalStatus == 'individual-entrepreneur' ? false : true,
                                    typeCall: (value) {
                                      if (value == true) {
                                        legalStatus = 'self-employed';

                                        legalStatusController.text = 'Самозанятый';
                                      } else {
                                        legalStatus = 'individual-entrepreneur';
                                        legalStatusController.text = 'ИП';
                                      }

                                      setState(() {});
                                    },
                                  );
                                },
                                showArrow: true,
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
                                controller: bankNameController,
                                label: 'Название банка',
                                keyboardType: TextInputType.number,
                              ),
                              _buildFormField(
                                controller: bankBikController,
                                label: 'БИК банка',
                                keyboardType: TextInputType.number,
                              ),
                              _buildFormField(controller: checkController, label: 'Счёт'),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.title == 'Контактные данные',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Номер телефона',
                                style: AppTextStyles.size13Weight500.copyWith(
                                  color: Color(0xff636366),
                                ),
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
                                              ? Border.all(
                                                  color: AppColors.mainRedColor,
                                                  width: 1.0,
                                                )
                                              : null,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              countrySellerDto!.flagPath,
                                              width: 24,
                                              height: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              '${countrySellerDto?.code}',
                                              style: AppTextStyles.size16Weight400,
                                            ),
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
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Color(0xffEAECED),
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
          Text(label, style: AppTextStyles.size13Weight500.copyWith(color: Color(0xFF636366))),
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
                hintStyle: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF8E8E93)),
                contentPadding: EdgeInsets.zero, // Better control over padding
                isDense: true,
              ),
              style: AppTextStyles.size16Weight400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusField({
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
                          hintStyle: AppTextStyles.size16Weight400.copyWith(
                            color: Color(0xff8E8E93),
                          ),
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

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
      width: double.infinity,
      color: AppColors.kWhite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainPurpleColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () async {
          // if (nameController.text.isNotEmpty ||
          //     nickNameController.text.isNotEmpty) {
          //   if (passwordController.text == reapatPasswordController.text) {
          final edit = BlocProvider.of<EditBloggerCubit>(context);

          final BloggerDTO dto = BloggerDTO(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            surName: surNameController.text,
            nick: nickNameController.text,
            phone: phoneController.text,
            password: passwordController.text,
            legalStatus: legalStatus,
            iin: iinController.text,
            bankName: bankNameController.text,
            bankBik: bankBikController.text,
            check: checkController.text,
            email: emailController.text,
            socialNetwork: socialNetworkController.text,
          );
          await edit.edit(context, dto);
        },
        child: Text(
          'Сохранить',
          style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
        ),
      ),
    );
  }
}
