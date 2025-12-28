import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../drawer/presentation/ui/city_page.dart';
import '../../../../drawer/presentation/widgets/country_widget.dart';
import '../../data/bloc/profile_edit_admin_cubit.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
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
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Тинькофф банк',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/bell.svg',
              colorFilter: ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Для подключения банковского сервиса:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kGray500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Если вы зарегистрированы как ИП — необходимо перейти на ООО.\n'
                        'Если вы уже ООО — обновите данные, которые не прошли проверку.',
                        style: TextStyle(fontSize: 14, color: AppColors.kGray500),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Пожалуйста, обновите данные вашей организации, указав:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kGray500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '• Наименование компании\n'
                        '• ИНН, КПП, ОГРН\n'
                        '• ОКВЭД, налоговую инспекцию\n'
                        '• Юридический адрес\n'
                        '• Расчетный счёт, банк\n'
                        '• Генерального директора и учредителя\n'
                        '• Дату регистрации компании',
                        style: TextStyle(fontSize: 14, color: AppColors.kGray500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildOrganizationSection(),
                  const SizedBox(height: 24),
                  _buildShopInfoSection(),
                  const SizedBox(height: 24),
                  _buildContactInfoSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildSaveButton(context),
    );
  }

  Widget _buildOrganizationSection() {
    return Card(
      color: AppColors.kGray,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Данные организации',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.kGray900,
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [Expanded(child: _buildOrganizationTypeToggle())]),
            const SizedBox(height: 16),
            _buildFormField(
              icon: Icons.fingerprint,
              controller: iinController,
              hintText: 'ИНН/БИН',
            ),
            if (typeOrganization)
              _buildFormField(
                icon: Icons.document_scanner,
                controller: kppController,
                hintText: 'КПП',
              ),
            if (typeOrganization)
              _buildFormField(icon: Icons.business, controller: ogrnController, hintText: 'ОГРН'),
            _buildFormField(icon: Icons.business_center, controller: okved, hintText: 'ОКВэД'),
            _buildFormField(
              icon: Icons.account_balance,
              controller: taxAuthority,
              hintText: 'Налоговый орган',
            ),
            _buildFormField(
              icon: Icons.calendar_today,
              controller: dateRegister,
              hintText: 'Дата регистрации',
            ),
            _buildFormField(
              icon: Icons.location_city,
              controller: legalAddress,
              hintText: 'Юридический адрес',
            ),
            if (typeOrganization)
              _buildFormField(
                icon: Icons.foundation,
                controller: founderController,
                hintText: 'Учредитель',
              ),
            if (typeOrganization)
              _buildFormField(
                icon: Icons.calendar_today,
                controller: dateBirthday,
                hintText: 'Дата рождения',
              ),
            if (typeOrganization)
              _buildFormField(
                icon: Icons.south_america,
                controller: citizenshipController,
                hintText: 'Гражданство',
              ),
            _buildFormField(
              icon: Icons.business,
              controller: companyNameController,
              hintText: 'Название компании',
            ),
            // _buildFormField(
            //   icon: Icons.assignment,
            //   controller: addressController,
            //   hintText: 'Адрес',
            // ),
            if (typeOrganization)
              _buildFormField(
                icon: Icons.account_balance_wallet,
                controller: generalDirectorController,
                hintText: 'Ген.директор',
              ),
            _buildFormField(
              icon: Icons.assignment,
              controller: frOrganizations,
              hintText: 'Организации ФР',
            ),
            _buildFormField(
              icon: Icons.account_balance_wallet,
              controller: bankController,
              hintText: 'Банк',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationTypeToggle() {
    return ToggleButtons(
      isSelected: [!typeOrganization, typeOrganization],
      onPressed: (int index) {
        setState(() {
          typeOrganization = index == 1;
        });
      },
      borderRadius: BorderRadius.circular(8),
      selectedColor: Colors.white,
      fillColor: AppColors.kPrimaryColor,
      color: AppColors.kPrimaryColor,
      constraints: const BoxConstraints(minHeight: 40, minWidth: 0),
      children: const [
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('ИП')),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('OOO')),
      ],
    );
  }

  Widget _buildShopInfoSection() {
    return Card(
      color: AppColors.kGray,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Информация о магазине',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.kGray900,
              ),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              icon: Icons.store,
              controller: shopNameController,
              hintText: 'Название Магазина',
            ),
            _buildFormField(icon: Icons.credit_card, controller: checkController, hintText: 'Счёт'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Card(
      color: AppColors.kGray,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Контактные данные',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.kGray900,
              ),
            ),
            const SizedBox(height: 16),
            _buildFormField(
              icon: Icons.person,
              controller: nameController,
              hintText: 'Контактное имя',
            ),
            _buildFormField(
              icon: Icons.phone,
              controller: phoneController,
              hintText: '+7(###)-###-##-##',
              keyboardType: TextInputType.phone,
              inputFormatters: [maskFormatter],
            ),
            _buildFormField(
              icon: Icons.email,
              controller: emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            _buildSelectableField(
              icon: Icons.public,
              controller: countryController,
              hintText: 'Страна',
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
              icon: Icons.location_city,
              controller: cityController,
              hintText: 'Город',
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
            _buildFormField(icon: Icons.route, controller: streetController, hintText: 'Улица'),
            _buildFormField(icon: Icons.home, controller: homeController, hintText: 'Дом'),
            _buildFormField(icon: Icons.map, controller: addressController, hintText: 'Адрес'),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required IconData icon,
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.kPrimaryColor),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildSelectableField({
    required IconData icon,
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: IgnorePointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColors.kPrimaryColor),
              suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
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
          Navigator.of(context).pop();
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
