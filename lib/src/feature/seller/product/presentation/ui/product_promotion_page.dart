import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ProductPromotionPage extends StatefulWidget implements AutoRouteWrapper {
  const ProductPromotionPage({super.key});

  @override
  State<ProductPromotionPage> createState() => ProductPromotionPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductSellerCubit(productAdminRepository: ProductSellerRepository()),
      child: this,
    );
  }
}

class ProductPromotionPageState extends State<ProductPromotionPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController compoundController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  final _dateFmt = DateFormat('dd.MM.yyyy');
  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    nameController.text = 'Введите название';
    compoundController.text = 'Введите размер скидки';
    fromDateController.text = 'Дата начала';
    toDateController.text = 'Дата окончания';

    super.initState();
  }

  Future<void> _pickRange() async {
    FocusScope.of(context).unfocus(); // убрать клаву, если открыта
    final now = DateTime.now();

    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1, 1, 1),
      lastDate: DateTime(now.year + 3, 12, 31),
      initialDateRange: (_from != null && _to != null)
          ? DateTimeRange(start: _from!, end: _to!)
          : null,
      helpText: 'Выберите период',
      builder: (ctx, child) {
        // подкрашиваем под ваш фиолетовый
        final scheme = Theme.of(ctx).colorScheme.copyWith(
              primary: AppColors.mainPurpleColor,
              onPrimary: Colors.white,
            );
        return Theme(
            data: Theme.of(ctx).copyWith(colorScheme: scheme), child: child!);
      },
      useRootNavigator: true, // чтобы поверх модалок
    );

    if (range != null) {
      setState(() {
        _from = DateTime(range.start.year, range.start.month, range.start.day);
        _to = DateTime(range.end.year, range.end.month, range.end.day);
        fromDateController.text = _dateFmt.format(_from!);
        toDateController.text = _dateFmt.format(_to!);
      });
    }
  }

  Future<void> _pickTo() async {
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    final first = _from ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: _to ?? first,
      firstDate: first,
      lastDate: DateTime(now.year + 3, 12, 31),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx)
              .colorScheme
              .copyWith(primary: AppColors.mainPurpleColor),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _to = DateTime(picked.year, picked.month, picked.day);
        toDateController.text = _dateFmt.format(_to!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Акция на товар',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 8),
            FieldsProductRequest(
              titleText: ' Название акции (для вас)',
              hintText: nameController.text,
              star: false,
              arrow: false,
              onPressed: () async {},
            ),
            const SizedBox(height: 8),
            FieldsProductRequest(
              titleText: ' Скидка (%)',
              hintText: compoundController.text,
              star: false,
              arrow: false,
              onPressed: () async {},
            ),
            const SizedBox(height: 8),
            FieldsProductRequest(
              titleText: ' Дата начала',
              hintText: fromDateController.text,
              star: false,
              arrow: true,
              onPressed: _pickRange,
            ),
            const SizedBox(height: 8),
            FieldsProductRequest(
              titleText: ' Дата окончания',
              hintText: toDateController.text,
              star: false,
              arrow: true,
              onPressed: _pickRange,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
          height: 140,
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
          child: Column(
            children: [
              InkWell(
                onTap: () async {},
                child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.mainPurpleColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Text(
                      'Изменить',
                      style: AppTextStyles.size18Weight500
                          .copyWith(color: AppColors.kWhite),
                    )),
              ),
              SizedBox(height: 8),
              Text(
                'Удалить',
                style:
                    AppTextStyles.size18Weight600.copyWith(color: Colors.red),
              )
            ],
          )),
    );
  }
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
                widget.titleText,
                style: AppTextStyles.size13Weight500,
              ),
              widget.star == true
                  ? const Text(
                      '*',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.red),
                    )
                  : Container()
            ],
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
                color: AppColors.kGray2,
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
                  hintStyle: AppTextStyles.size14Weight400.copyWith(
                      color:
                          widget.hintColor == null || widget.hintColor != true
                              ? AppColors.kLightBlackColor
                              : AppColors.kWhite),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
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
