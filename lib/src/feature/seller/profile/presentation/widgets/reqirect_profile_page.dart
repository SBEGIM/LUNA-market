import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../drawer/presentation/ui/city_page.dart';
import '../../../../drawer/presentation/widgets/country_widget.dart';
import '../../data/bloc/profile_edit_admin_cubit.dart';

class ReqirectProfilePage extends StatefulWidget {
  final String title;

  const ReqirectProfilePage({required this.title, super.key});

  @override
  State<ReqirectProfilePage> createState() => _ReqirectProfilePageState();
}

class _ReqirectProfilePageState extends State<ReqirectProfilePage> {
  final _box = GetStorage();
  XFile? _image;
  bool typeOrganization = false;

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController kppController = TextEditingController();
  TextEditingController ogrnController = TextEditingController();
  TextEditingController checkController = TextEditingController();
  TextEditingController okved = TextEditingController();
  TextEditingController taxAuthority = TextEditingController();
  TextEditingController dateRegister = TextEditingController();
  TextEditingController dateBirthday = TextEditingController();
  TextEditingController legalAddress = TextEditingController();
  TextEditingController founderController = TextEditingController();
  TextEditingController frOrganizations = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController citizenshipController = TextEditingController();
  TextEditingController generalDirectorController = TextEditingController();

  final maskFormatter = MaskTextInputFormatter(mask: '+7(###)-###-##-##');
  bool _obscureText = true;
  bool _obscureTextRepeat = true;

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  void _initializeControllers() {
    if (_box.read('seller_name') != null && _box.read('seller_name') != 'null') {
      shopNameController.text = _box.read('seller_name') ?? '';
    }
    if (_box.read('seller_phone') != null && _box.read('seller_phone') != 'null') {
      phoneController.text = maskFormatter.maskText(_box.read('seller_phone') ?? '');
    }
    if (_box.read('seller_email') != null && _box.read('seller_email') != 'null') {
      emailController.text = _box.read('seller_email') ?? '';
    }
    if (_box.read('seller_country') != null && _box.read('seller_country') != 'null') {
      countryController.text = _box.read('seller_country') ?? '';
    }
    if (_box.read('seller_city') != null && _box.read('seller_city') != 'null') {
      cityController.text = _box.read('seller_city') ?? '';
    }
    if (_box.read('seller_userName') != null && _box.read('seller_userName') != 'null') {
      nameController.text = _box.read('seller_userName') ?? '';
    }
    if (_box.read('seller_home') != null && _box.read('seller_home') != 'null') {
      homeController.text = _box.read('seller_home') ?? '';
    }
    if (_box.read('seller_street') != null && _box.read('seller_street') != 'null') {
      streetController.text = _box.read('seller_street') ?? '';
    }
    if (_box.read('seller_iin') != null && _box.read('seller_iin') != 'null') {
      iinController.text = _box.read('seller_iin') ?? '';
    }
    if (_box.read('seller_check') != null && _box.read('seller_check') != 'null') {
      checkController.text = _box.read('seller_check') ?? '';
    }
    if (_box.read('seller_type_organization') != null &&
        _box.read('seller_type_organization') != 'null') {
      typeOrganization = _box.read('seller_type_organization') == 'ИП' ? false : true;
    }

    if (_box.read('seller_kpp') != null && _box.read('seller_kpp') != 'null') {
      kppController.text = _box.read('seller_kpp') ?? '';
    }

    if (_box.read('seller_ogrn') != null && _box.read('seller_ogrn') != 'null') {
      ogrnController.text = _box.read('seller_ogrn') ?? '';
    }
    if (_box.read('seller_okved') != null && _box.read('seller_okved') != 'null') {
      okved.text = _box.read('seller_okved') ?? '';
    }
    if (_box.read('seller_tax_authority') != null && _box.read('seller_tax_authority') != 'null') {
      taxAuthority.text = _box.read('seller_tax_authority') ?? '';
    }
    if (_box.read('seller_date_register') != null && _box.read('seller_date_register') != 'null') {
      dateRegister.text = _box.read('seller_date_register') ?? '';
    }
    if (_box.read('seller_legal_address') != null && _box.read('seller_legal_address') != 'null') {
      legalAddress.text = _box.read('seller_legal_address') ?? '';
    }

    if (_box.read('seller_founder') != null && _box.read('seller_founder') != 'null') {
      founderController.text = _box.read('seller_founder') ?? '';
    }
    if (_box.read('seller_date_of_birth') != null && _box.read('seller_date_of_birth') != 'null') {
      dateBirthday.text = _box.read('seller_date_of_birth') ?? '';
    }
    if (_box.read('seller_citizenship') != null && _box.read('seller_citizenship') != 'null') {
      citizenshipController.text = _box.read('seller_citizenship') ?? '';
    }
    if (_box.read('seller_CEO') != null && _box.read('seller_CEO') != 'null') {
      generalDirectorController.text = _box.read('seller_CEO') ?? '';
    }
    if (_box.read('seller_organization_fr') != null &&
        _box.read('seller_organization_fr') != 'null') {
      frOrganizations.text = _box.read('seller_organization_fr') ?? '';
    }
    if (_box.read('seller_bank') != null && _box.read('seller_bank') != 'null') {
      bankController.text = _box.read('seller_bank') ?? '';
    }

    if (_box.read('seller_company_name') != null && _box.read('seller_company_name') != 'null') {
      companyNameController.text = _box.read('seller_company_name') ?? '';
    }

    if (_box.read('seller_legal_address') != null && _box.read('seller_legal_address') != 'null') {
      legalAddress.text = _box.read('seller_legal_address') ?? '';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // _buildProfileHeader(),
            // const Divider(height: 0.00, color: AppColors.kGray200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'Чтобы поменять текущий пароль, необходимо сначала ввести старый правильно, а затем придумать новый',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: AppColors.kGray500,
                  //   ),
                  // ),
                  if (widget.title == 'Юридические данные') _buildOrganizationSection(),
                  if (widget.title == 'Реквизиты банка') _buildShopInfoSection(),
                  if (widget.title == 'Контактные данные') _buildContactInfoSection(),
                  if (widget.title == 'Контактные данные') _buildPasswordSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Material(color: Colors.white, elevation: 0, child: _buildSaveButton(context)),
    );
  }

  Widget _buildOrganizationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   'Юридические данные',
        //   style: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w600,
        //     color: AppColors.kGray900,
        //   ),
        // ),
        // const SizedBox(height: 16),
        // Row(
        //   children: [
        //     Expanded(
        //       child: _buildOrganizationTypeToggle(),
        //     ),
        //   ],
        // ),
        const SizedBox(height: 16),
        _buildFormField(controller: iinController, label: 'ИНН/БИН'),

        if (typeOrganization) _buildFormField(controller: kppController, label: 'КПП'),
        if (typeOrganization) _buildFormField(controller: ogrnController, label: 'ОГРН'),
        _buildFormField(controller: okved, label: 'ОКВэД'),
        _buildFormField(controller: taxAuthority, label: 'Налоговый орган'),
        _buildFormField(controller: dateRegister, label: 'Дата регистрации'),
        _buildFormField(controller: legalAddress, label: 'Юридический адрес'),
        if (typeOrganization) _buildFormField(controller: founderController, label: 'Учредитель'),
        if (typeOrganization) _buildFormField(controller: dateBirthday, label: 'Дата рождения'),
        if (typeOrganization)
          _buildFormField(controller: citizenshipController, label: 'Гражданство'),
        _buildFormField(controller: companyNameController, label: 'Название компании'),
        // _buildFormField(
        //   icon: Icons.assignment,
        //   controller: addressController,
        //   hintText: 'Адрес',
        // ),
        if (typeOrganization)
          _buildFormField(controller: generalDirectorController, label: 'Ген.директор'),
        _buildFormField(controller: frOrganizations, label: 'Организации ФР'),
        _buildFormField(controller: bankController, label: 'Банк'),
      ],
    );
  }

  Widget _buildShopInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField(controller: shopNameController, label: 'Название Магазина'),
        _buildFormField(controller: checkController, label: 'Счёт'),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField(controller: nameController, label: 'Контактное имя'),
        _buildFormField(
          controller: phoneController,
          label: '+7(###)-###-##-##',
          keyboardType: TextInputType.phone,
          inputFormatters: [maskFormatter],
        ),
        _buildFormField(
          controller: emailController,
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        _buildSelectableField(
          controller: countryController,
          label: 'Страна',
          onTap: () async {
            final data = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (_) => const CountryWidget()),
            );
            if (data != null) {
              countryController.text = data;
              setState(() {});
            }
          },
        ),
        _buildSelectableField(
          controller: cityController,
          label: 'Город',
          onTap: () async {
            final data = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (_) => const CityPage()),
            );
            if (data != null) {
              cityController.text = data;
              setState(() {});
            }
          },
        ),
        _buildFormField(controller: streetController, label: 'Улица'),
        _buildFormField(controller: homeController, label: 'Дом'),
        _buildFormField(controller: addressController, label: 'Адрес'),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   'Смена пароля',
        //   style: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w600,
        //     color: AppColors.kGray900,
        //   ),
        // ),
        // const SizedBox(height: 16),
        _buildPasswordField(
          controller: passwordController,
          label: 'Старый пароль',
          obscureText: _obscureText,
          onToggle: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        _buildPasswordField(
          controller: passwordRepeatController,
          label: 'Новый пароль',
          obscureText: _obscureTextRepeat,
          onToggle: () {
            setState(() {
              _obscureTextRepeat = !_obscureTextRepeat;
            });
          },
        ),
      ],
    );
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
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: readOnly ? onTap : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
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
                        decoration: const InputDecoration.collapsed(hintText: ''),
                        style: const TextStyle(fontSize: 16),
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

  Widget _buildSelectableField({
    required TextEditingController controller,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(controller.text, style: const TextStyle(fontSize: 16))),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
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
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
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
                    decoration: const InputDecoration(border: InputBorder.none),
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
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.2),
      //       spreadRadius: 0,
      //       blurRadius: 0,
      //       offset: const Offset(0, -2),
      //     ),
      //   ],
      // ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainPurpleColor,
          elevation: 0, // Убирает тень от кнопки
          shadowColor: Colors.white, // Подстраховка
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () async {
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
            emailController.text,
            '',
            typeOrganization,
            addressController.text,
            kppController.text,
            ogrnController.text,
            okved.text,
            taxAuthority.text,
            dateRegister.text,
            legalAddress.text,
            founderController.text,
            dateBirthday.text,
            citizenshipController.text,
            generalDirectorController.text,
            ogrnController.text,
            bankController.text,
            companyNameController.text,
          );
          Navigator.of(context).pop('ok');
        },
        child: const Text(
          'Сохранить',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
    countryController.dispose();
    cityController.dispose();
    streetController.dispose();
    homeController.dispose();
    addressController.dispose();
    emailController.dispose();
    companyNameController.dispose();
    shopNameController.dispose();
    iinController.dispose();
    kppController.dispose();
    ogrnController.dispose();
    checkController.dispose();
    okved.dispose();
    taxAuthority.dispose();
    dateRegister.dispose();
    dateBirthday.dispose();
    legalAddress.dispose();
    founderController.dispose();
    frOrganizations.dispose();
    bankController.dispose();
    citizenshipController.dispose();
    generalDirectorController.dispose();
    super.dispose();
  }
}
