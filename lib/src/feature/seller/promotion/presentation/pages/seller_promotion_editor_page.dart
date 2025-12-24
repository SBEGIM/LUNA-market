import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/product_promotion_page.dart';
import 'package:haji_market/src/feature/seller/promotion/model/seller_promotion.dart';
import 'package:intl/intl.dart';

@RoutePage()
class SellerPromotionEditorPage extends StatefulWidget {
  const SellerPromotionEditorPage({super.key, this.initialPromotion});

  final SellerPromotion? initialPromotion;

  @override
  State<SellerPromotionEditorPage> createState() => _SellerPromotionEditorPageState();
}

class _SellerPromotionEditorPageState extends State<SellerPromotionEditorPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _discountController;
  late final TextEditingController _scopeController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;

  final DateFormat _formatter = DateFormat('dd.MM.yyyy');
  PromotionScope _scope = PromotionScope.allProducts;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialPromotion;
    _scope = initial?.scope ?? PromotionScope.allProducts;

    _nameController = TextEditingController(text: initial?.title ?? '');
    _discountController = TextEditingController(
      text: initial != null ? initial.discountPercent.toString() : '',
    );
    _scopeController = TextEditingController(text: _scopeLabel(_scope));
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();

    _startDate = initial?.startDate;
    _endDate = initial?.endDate;
    _syncDates();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _discountController.dispose();
    _scopeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  String _scopeLabel(PromotionScope scope) {
    return scope == PromotionScope.allProducts ? 'Все товары' : 'Выбрано вручную';
  }

  void _syncDates() {
    if (_startDate != null) {
      _startDateController.text = _formatter.format(_startDate!);
    }
    if (_endDate != null) {
      _endDateController.text = _formatter.format(_endDate!);
    }
  }

  Future<void> _pickStartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx)
              .colorScheme
              .copyWith(primary: AppColors.mainPurpleColor, onPrimary: AppColors.kWhite),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = DateTime(picked.year, picked.month, picked.day);
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = _startDate;
        }
        _syncDates();
      });
    }
  }

  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final firstDate = _startDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? firstDate,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx)
              .colorScheme
              .copyWith(primary: AppColors.mainPurpleColor, onPrimary: AppColors.kWhite),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        _endDate = DateTime(picked.year, picked.month, picked.day);
        _syncDates();
      });
    }
  }

  Future<void> _selectScope() async {
    final selected = await showModalBottomSheet<PromotionScope>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Применить к', style: AppTextStyles.size16Weight600),
                const SizedBox(height: 12),
                ...PromotionScope.values.map(
                  (scope) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      _scopeLabel(scope),
                      style: AppTextStyles.size16Weight500,
                    ),
                    trailing: this._scope == scope
                        ? const Icon(Icons.check, color: AppColors.mainPurpleColor)
                        : null,
                    onTap: () => Navigator.of(context).pop(scope),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _scope = selected;
        _scopeController.text = _scopeLabel(_scope);
      });
    }
  }

  void _submit() {
    final title = _nameController.text.trim().isEmpty ? 'Новая акция' : _nameController.text.trim();
    final discount = int.tryParse(_discountController.text.trim()) ?? 0;
    final start = _startDate ?? DateTime.now();
    final end = _endDate ?? start.add(const Duration(days: 30));

    final promotion = SellerPromotion(
      id: widget.initialPromotion?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      scope: _scope,
      discountPercent: discount,
      startDate: start,
      endDate: end,
    );

    context.router.pop(promotion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 68,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomBackButton(onTap: () => context.router.pop()),
        ),
        title: const Text('Добавить акцию', style: AppTextStyles.appBarTextStyle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          FieldsProductRequest(
            titleText: ' Название акции (для вас)',
            hintText: 'Введите название',
            star: false,
            arrow: false,
            controller: _nameController,
          ),
          const SizedBox(height: 8),
          FieldsProductRequest(
            titleText: ' Применить к',
            hintText: _scopeLabel(_scope),
            star: false,
            arrow: true,
            controller: _scopeController,
            readOnly: true,
            onPressed: _selectScope,
          ),
          const SizedBox(height: 8),
          FieldsProductRequest(
            titleText: ' Скидка (%)',
            hintText: 'Введите размер скидки',
            star: false,
            arrow: false,
            controller: _discountController,
            textInputNumber: true,
          ),
          const SizedBox(height: 8),
          FieldsProductRequest(
            titleText: ' Дата начала',
            hintText: _startDateController.text.isEmpty ? 'Укажите дату' : _startDateController.text,
            star: false,
            arrow: true,
            controller: _startDateController,
            readOnly: true,
            onPressed: _pickStartDate,
          ),
          const SizedBox(height: 8),
          FieldsProductRequest(
            titleText: ' Дата окончания',
            hintText: _endDateController.text.isEmpty ? 'Укажите дату' : _endDateController.text,
            star: false,
            arrow: true,
            controller: _endDateController,
            readOnly: true,
            onPressed: _pickEndDate,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainPurpleColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: _submit,
            child: const Text('Готово', style: AppTextStyles.defButtonTextStyle),
          ),
        ),
      ),
    );
  }
}
