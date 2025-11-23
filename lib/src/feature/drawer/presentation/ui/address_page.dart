import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_basket_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/address_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/address_state.dart';
import 'package:haji_market/src/feature/drawer/data/models/address_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class AddressPage extends StatefulWidget {
  bool? select;

  AddressPage({super.key, this.select});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final Set<int> isChecked = {};

  AddressModel? selectedAddress;

  final RefreshController _refreshController = RefreshController();

  Future<void> _refresh() async {
    await context.read<AddressCubit>().address();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    // первый фетч
    context.read<AddressCubit>().address();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: AppColors.kBackgroundColor,
        backgroundColor: AppColors.kBackgroundColor,
        title: Text('Сохраненные адреса', style: AppTextStyles.size18Weight600),
      ),

      // Кнопка снизу — через bottomNavigationBar, чтобы не перекрывать контент
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: SizedBox(
            height: 52,
            width: double.infinity,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                if (widget.select == true && isChecked.isNotEmpty) {
                  context.router.pop(selectedAddress);
                } else {
                  context.router.push(const AddressStoreRoute());
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.mainPurpleColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  isChecked.isNotEmpty
                      ? 'Сохранить и продолжить'
                      : 'Добавить новый адрес',
                  style: AppTextStyles.size18Weight600
                      .copyWith(color: AppColors.kWhite),
                ),
              ),
            ),
          ),
        ),
      ),

      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          // Оборачиваем во SmartRefresher, чтобы pull-to-refresh работал
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _refresh,
            child: _buildBodyByState(state),
          );
        },
      ),
    );
  }

  /// Возвращает скроллящийся виджет под SmartRefresher для любого состояния
  Widget _buildBodyByState(AddressState state) {
    if (state is LoadingState) {
      // Скелет (скроллящийся, чтобы pull-to-refresh был доступен)
      return ListView.separated(
        padding:
            const EdgeInsets.fromLTRB(16, 16, 16, 88), // 88 = запас под кнопку
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => _ShimmerTile(),
      );
    }

    if (state is ErrorState) {
      return _CenteredScroll(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              state.message,
              style: const TextStyle(
                  fontSize: 16, color: AppColors.kLightBlackColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state is NoDataState) {
      // Никаких Expanded — только скролл, чтобы не словить ParentData ошибки
      return _CenteredScroll(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.icons.defaultNoDataIcon.path,
                height: 72, width: 72),
            const SizedBox(height: 12),
            const Text(
              'Нет адресов',
              style: AppTextStyles.size16Weight500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Здесь появятся адреса доставки,\nкоторые вы добавите',
              style: AppTextStyles.size14Weight400
                  .copyWith(color: AppColors.kGray300),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state is LoadedState) {
      final items = state.addressModel;
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16), // низ — под кнопку
        itemCount: items.length,
        // separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final a = items[index];
          // Аккуратно формируем строку адреса (без "лишних запятых")
          final parts = <String>[
            if ((a.city ?? '').isNotEmpty) a.city!,
            if ((a.street ?? '').isNotEmpty) a.street!,
            if ((a.home ?? '').isNotEmpty) a.home!,
            if ((a.entrance ?? '').isNotEmpty) 'подъезд ${a.entrance!}',
            if ((a.floor ?? '').isNotEmpty) 'этаж ${a.floor!}',
            if ((a.apartament ?? '').isNotEmpty) 'кв. ${a.apartament!}',
          ];
          final addressLine = parts.join(', ');

          final phoneText = _formatKzPhone(a.phone);

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: index == 0
                  ? BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))
                  : items.length - 1 == index
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))
                      : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Текст занимает всё доступное; никаких SizedBox(width: 285)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок адреса
                      Text(
                        addressLine.isEmpty ? '—' : addressLine,
                        style: AppTextStyles.size18Weight600,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Телефон / id (оставляю как у тебя — примерный формат)
                      Text(
                        phoneText,
                        style: AppTextStyles.size14Weight400
                            .copyWith(color: Color(0xff8E8E93)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                widget.select == true
                    ? InkWell(
                        onTap: () async {
                          if (isChecked.contains(a.id!)) {
                            isChecked.remove(a.id!);
                          } else {
                            isChecked.clear();
                            selectedAddress = items[index];
                            isChecked.add(a.id!);
                          }

                          setState(() {});
                        },
                        child: isChecked.contains(a.id!)
                            ? Image.asset(
                                Assets.icons.defaultCheckIcon.path,
                                height: 20,
                                width: 20,
                                color: AppColors.mainPurpleColor,
                              )
                            : Image.asset(
                                Assets.icons.defaultUncheckIcon.path,
                                height: 20,
                                width: 20,
                                color: Color(0xffD1D1D6),
                              ),
                      )
                    : InkWell(
                        onTap: () async {
                          final ok = await showBasketAlert(
                            context,
                            title: 'Удалить',
                            message:
                                'Вы действительно хотите удалить этот адрес?',
                            mode: AccountAlertMode.confirm,
                            cancelText: 'Отмена',
                            primaryText: 'Да',
                            primaryColor: Colors.red,
                          );
                          if (ok == true) {
                            context.read<AddressCubit>().delete(context, a.id!);
                          }
                        },
                        child: Image.asset(Assets.icons.trashIcon.path,
                            height: 21),
                      ),
              ],
            ),
          );
        },
      );
    }

    // Fallback (на всякий)
    return const Center(
      child: CircularProgressIndicator(color: Colors.indigoAccent),
    );
  }
}

String _formatKzPhone(String? input) {
  if (input == null || input.trim().isEmpty) return '+0 (000) 000-00-00';
  // Оставляем только цифры
  var d = input.replaceAll(RegExp(r'\D'), '');

  // Приводим 8XXXXXXXXXX → 7XXXXXXXXXX
  if (d.startsWith('8')) d = '7${d.substring(1)}';

  // Если нет кода страны — добавим 7
  if (!d.startsWith('7')) d = '7$d';

  // Нужно минимум 11 цифр (включая код страны)
  if (d.length < 11) return '+$d';

  final c = d[0]; // 7
  final p1 = d.substring(1, 4); // XXX
  final p2 = d.substring(4, 7); // XXX
  final p3 = d.substring(7, 9); // XX
  final p4 = d.substring(9, 11); // XX

  return '+$c ($p1) $p2-$p3-$p4';
}

/// Простой «центрированный скролл», чтобы pull-to-refresh работал даже без контента.
class _CenteredScroll extends StatelessWidget {
  const _CenteredScroll({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: child),
        ),
      ],
    );
  }
}

/// Заглушка для состояния загрузки
class _ShimmerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // фейковая «иконка»
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.kGray200,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          // фейковый текст
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 14,
                    width: double.infinity,
                    color: AppColors.kGray200),
                const SizedBox(height: 8),
                Container(height: 12, width: 120, color: AppColors.kGray200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
