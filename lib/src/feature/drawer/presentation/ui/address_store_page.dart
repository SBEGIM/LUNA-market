import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/drawer/bloc/address_cubit.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';

@RoutePage()
class AddressStorePage extends StatefulWidget {
  const AddressStorePage({super.key});

  @override
  State<AddressStorePage> createState() => _AddressStorePageState();
}

class _AddressStorePageState extends State<AddressStorePage> {
  TextEditingController streetController = TextEditingController();
  TextEditingController entranceController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController intercomController = TextEditingController();
  TextEditingController commentsCourierController = TextEditingController();
  TextEditingController phoneController =
      MaskedTextController(mask: '+7(000)-000-00-00');

  @override
  void initState() {
    for (final c in [
      streetController,
      entranceController,
      floorController,
      apartmentController,
      intercomController,
      commentsCourierController,
      phoneController,
    ]) {
      c.addListener(() => setState(() {}));
    }
    super.initState();
  }

  Map<String, String?> fieldErrors = {
    'street': null,
    'entrance': null,
    'floor': null,
    'apartment': null,
    'intercom': null,
    'comments': null,
    'phone': null,
  };

  String? _validateError() {
    final street = streetController.text;
    if (street.isEmpty) return 'Укажите улицу';

    final entrance = entranceController.text;
    if (entrance.isEmpty) return 'Укажите номер подъезда';

    final floor = floorController.text;
    if (floor.isEmpty) return 'Укажите на каком этаже';

    final apartment = apartmentController.text;
    if (apartment.isEmpty) return 'Укажите номер квартиры';

    final intercom = intercomController.text;
    if (intercom.isEmpty) return 'Укажите номер домофона';

    final comments = commentsCourierController.text;
    if (comments.isEmpty) return 'Напишите комментарии курьеру';

    final rawDigits = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawDigits.length != 11) return 'Введите корректный номер телефона';
  }

  void _validateFields() {
    final phone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final street = streetController.text;
    final entrance = entranceController.text;
    final floor = floorController.text;
    final apartment = apartmentController.text;
    final intercom = intercomController.text;
    final comments = commentsCourierController.text;

    setState(() {
      fieldErrors['phone'] =
          phone.length != 11 ? 'Введите корректный номер телефона' : null;
      fieldErrors['street'] = street.isEmpty ? 'Укажите улицу' : null;
      fieldErrors['entrance'] =
          entrance.isEmpty ? 'Укажите номер подъезда' : null;
      fieldErrors['floor'] = floor.isEmpty ? 'Укажите на каком этаже' : null;
      fieldErrors['apartment'] =
          apartment.isEmpty ? 'Укажите номер квартиры' : null;
      fieldErrors['intercom'] =
          intercom.isEmpty ? 'Укажите номер домофона' : null;
      fieldErrors['comments'] =
          comments.isEmpty ? 'Напишите комментарии курьеру' : null;
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
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        title: Text(
          'Добавить новый адрес',
          style: AppTextStyles.size18Weight600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: ListView(
          children: [
            _buildFormField(
              controller: streetController,
              text: 'Улица',
              label: 'Укажите улица',
              errorText: fieldErrors['street'],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(
                child: _buildFormField(
                  controller: entranceController,
                  text: 'Подъезд',
                  label: 'Номер подъезда',
                  errorText: fieldErrors['entrance'],
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                child: _buildFormField(
                  controller: floorController,
                  text: 'Этаж',
                  label: 'На каком этаже',
                  errorText: fieldErrors['floor'],
                ),
              ),
            ]),
            Row(
              children: [
                Flexible(
                  child: _buildFormField(
                    controller: apartmentController,
                    text: 'Квартира',
                    label: 'Номер квартиры',
                    errorText: fieldErrors['apartment'],
                  ),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: _buildFormField(
                    controller: intercomController,
                    text: 'Домофон',
                    label: 'Номер домофона',
                    errorText: fieldErrors['intercom'],
                  ),
                ),
              ],
            ),
            FieldsProductRequest(
              titleText: 'Комментарии курьеру',
              hintText: 'Написать',
              maxLines: 4,
              star: true,
              arrow: false,
              controller: commentsCourierController,
              errorText: fieldErrors['comments'],
            ),
            _buildFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              text: 'Номер телефона получателя',
              label: 'Укажите номер телефона получателя ',
              errorText: fieldErrors['phone'],
            ),
          ],
        ),
      ),
      bottomSheet: SafeArea(
          bottom: true,
          child: InkWell(
            onTap: () async {
              _validateFields();
              if (!_ensureValid()) return;
              final statusCode = await BlocProvider.of<AddressCubit>(context)
                  .store(
                      context,
                      GetStorage().read('country'),
                      GetStorage().read('city'),
                      streetController.text,
                      entranceController.text,
                      floorController.text,
                      apartmentController.text,
                      intercomController.text,
                      commentsCourierController.text,
                      phoneController.text);

              if (statusCode == 200) {
                context.router.pop();
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
              height: 52,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.mainPurpleColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                'Сохранить',
                style: AppTextStyles.size18Weight600
                    .copyWith(color: AppColors.kWhite),
              ),
            ),
          )),
    );
  }
}

Widget _buildFormField(
    {required TextEditingController controller,
    required String label,
    required String text,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    VoidCallback? onTap,
    bool showArrow = false,
    final int? maxLines,
    final String? errorText}) {
  final hasError = errorText != null;

  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hasError ? errorText : text,
            style: AppTextStyles.size13Weight500.copyWith(
                color: hasError ? AppColors.mainRedColor : Color(0xFF636366))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: readOnly ? onTap : null,
          child: Container(
            height: maxLines != 0 ? 52 : 300,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xffEAECED),
              border: hasError
                  ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                  : null,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AbsorbPointer(
                    absorbing: readOnly,
                    child: TextField(
                      controller: controller,
                      keyboardType: (maxLines ?? 0) > 1
                          ? TextInputType.multiline
                          : keyboardType,
                      inputFormatters: inputFormatters,
                      readOnly: readOnly,
                      maxLines: maxLines,
                      decoration: InputDecoration.collapsed(
                          hintText: '$label',
                          hintStyle: AppTextStyles.size16Weight400
                              .copyWith(color: Color(0xff8E8E93))),
                      style: AppTextStyles.size16Weight400,
                    ),
                  ),
                ),
                if (showArrow)
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class FieldsProductRequest extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final bool? hintColor;
  final TextEditingController? controller;
  final CatsModel? cats;
  final bool? textInputNumber;
  final bool readOnly;
  final void Function()? onPressed;
  final int? maxLines; // добавили
  final String? errorText;

  const FieldsProductRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.hintColor,
    this.controller,
    this.cats,
    this.textInputNumber,
    Key? key,
    this.onPressed,
    this.readOnly = false,
    this.maxLines, // добавили
    this.errorText,
  }) : super(key: key);

  @override
  State<FieldsProductRequest> createState() => _FieldsProductRequestState();
}

class _FieldsProductRequestState extends State<FieldsProductRequest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                  widget.errorText != null
                      ? widget.errorText!
                      : widget.titleText,
                  style: AppTextStyles.size13Weight500.copyWith(
                      color: widget.errorText != null
                          ? AppColors.mainRedColor
                          : Color(0xFF636366))),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffEAECED),
                border: widget.errorText != null
                    ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                    : null,
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: TextField(
                controller: widget.controller,
                readOnly:
                    (widget.hintColor == false || widget.hintColor == null)
                        ? widget.readOnly
                        : true,
                keyboardType: (widget.maxLines != null && widget.maxLines! > 1)
                    ? TextInputType.multiline
                    : ((widget.textInputNumber == false ||
                            widget.textInputNumber == null)
                        ? TextInputType.text
                        : const TextInputType.numberWithOptions(
                            signed: true, decimal: true)),
                maxLines: widget.maxLines ?? 1,
                decoration: InputDecoration(
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 18, minHeight: 9),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: AppTextStyles.size16Weight400
                      .copyWith(color: Color(0xff8E8E93)),
                  suffixIcon: widget.arrow
                      ? InkWell(
                          onTap: widget.onPressed,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Image.asset(
                              Assets.icons.dropDownIcon.path,
                              width: 18,
                              height: 9,
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
