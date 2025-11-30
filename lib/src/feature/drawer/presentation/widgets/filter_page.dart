import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/characteristic_model.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:haji_market/src/feature/seller/product/bloc/characteristic_seller_cubit.dart'
    as charCubit;
import 'package:haji_market/src/feature/seller/product/bloc/characteristics_seller_state.dart'
    as charState;

import 'brands_page.dart';

class FilterPage extends StatefulWidget {
  String? shopId;
  FilterPage({this.shopId, Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<int> _selectListChar = [];
  List<CharacteristicsModel> subChar = [];
  Map<int, List<CharacteristicsModel>> _subCharMap = {};
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    final initCharCubit = BlocProvider.of<charCubit.CharacteristicSellerCubit>(context);

    if (charState.CharacteristicSellerState is! charState.LoadedState) {
      initCharCubit.characteristic();
      subChars();
    }

    clearFilterIds();
  }

  Future<void> clearFilterIds() async {
    print('hasData ${box.hasData('charFilterId')}');

    if (box.hasData('charFilterId')) {
      final raw = box.read('charFilterId');

      // Если вообще ничего внятного нет – удаляем ключ и выходим
      if (raw == null ||
          (raw is String && raw.trim().isEmpty) ||
          (raw is String && raw.trim() == '[]')) {
        _selectListChar.clear();
        box.remove('charFilterId');

        print('charFilterId пустой, удаляю из хранилища');
      } else {
        try {
          // Если хранишь как строку JSON: "[1,2,3]"
          final decoded = raw is String ? json.decode(raw) : raw;
          final ab = (decoded as List).cast<int>().toList();

          ab.forEach((element) {
            print('charFilterId: $element');

            _selectListChar.contains(element)
                ? _selectListChar.remove(element)
                : _selectListChar.add(element);
          });

          // _selectListChar.addAll(ab);
        } catch (e) {
          print('Ошибка при чтении фильтров: $e');
        }
      }
    }
  }

  Future<void> subChars() async {
    final initCharCubit = BlocProvider.of<charCubit.CharacteristicSellerCubit>(context);

    final subCharList = await initCharCubit.subListCharacteristic();

    subCharList!.forEach((e) {
      _subCharMap.putIfAbsent(e.mainId!, () => []).add(e);
    });

    setState(() {});

    // if (!_subCharMap.containsKey(id)) {
    //   final initCharCubit =
    //       BlocProvider.of<charCubit.CharacteristicSellerCubit>(context);
    //   final subCharList = await initCharCubit.subCharacteristic(id: id);

    //   print(subCharList?.isNotEmpty);
    //   if (subCharList != null && subCharList.isNotEmpty) {
    //     _subCharMap[id] = subCharList;

    //     setState(() {});
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      extendBody: true,
      appBar: AppBar(
        title: Text('Фильтр', style: AppTextStyles.size18Weight600),
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: AppColors.kBackgroundColor,
        surfaceTintColor: AppColors.kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 16),
            child: Text(
              'Отмена',
              style: AppTextStyles.size18Weight600.copyWith(color: AppColors.mainPurpleColor),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: _selectListChar.isEmpty
                ? null
                : () {
                    // GetStorage().remove('CatId');
                    // GetStorage().remove('subCatFilterId');
                    // GetStorage().remove('shopFilterId');
                    // GetStorage().remove('search');
                    setState(() {
                      _selectListChar.clear();
                    });

                    // либо удаляем ключ, либо пишем пустой список — выберите один вариант
                    GetStorage().remove('charFilterId');
                    // GetStorage().write('charFilterId', jsonEncode(<int>[]));
                  },
            child: Container(
              width: 82,
              height: 32,
              margin: const EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _selectListChar.isEmpty ? const Color(0xffEAECED) : AppColors.kAlpha12,
              ),
              child: Text(
                'Сбросить',
                style: AppTextStyles.size13Weight500.copyWith(
                  color: _selectListChar.isEmpty
                      ? const Color(0xffD1D1D6)
                      : const Color(0xff3A3A3C),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          BlocConsumer<charCubit.CharacteristicSellerCubit, charState.CharacteristicSellerState>(
            listener: (context, state) {
              if (state is charState.LoadedState) {
                //   _subCharMap.clear();
                //   final characteristics = state.characteristics.take(3);
                //   for (final item in characteristics) {
                //     subChars(item.id ?? 0);
                //   }
                // }
              }
            },
            builder: (context, state) {
              if (state is charState.ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is charState.LoadedState) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.characteristics.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final subList = _subCharMap[state.characteristics[index].id] ?? [];

                    // print(
                    //     "subList for ${state.characteristics[index].id} : ${subList.length}");
                    return Container(
                      margin: EdgeInsets.only(right: 16, left: 16, top: 12),
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.characteristics[index].key}',
                            style: AppTextStyles.size14Weight600,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              subList.length >= 9 ? 9 : subList.length,
                              (index) =>
                                  chipBrand(subList[index].value ?? '', subList[index].id ?? 0),
                            ),
                          ),
                          subList.length >= 6 ? const Divider(color: AppColors.kGray2) : SizedBox(),
                          subList.length >= 6
                              ? GestureDetector(
                                  onTap: (() {
                                    Get.to(() => const BrandsPage());
                                  }),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Показать еще (${subList.length - 9})',
                                        style: TextStyle(
                                          color: AppColors.mainPurpleColor,
                                          letterSpacing: 0,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.mainPurpleColor,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainPurpleColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () async {
              final filters = context.read<FilterProvider>();
              if (_selectListChar.isEmpty) {
                _selectListChar.clear();
                filters.resetChar();
              } else {
                filters.setChar(_selectListChar);
              }
              await BlocProvider.of<ProductCubit>(context).products(filters);
              Navigator.pop(context);
            },
            child: Text(
              'Применить',
              style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
            ),
          ),
        ),
      ),
    );
  }

  Widget chipBrand(String label, int index) {
    return InkWell(
      onTap: () async {
        setState(() {
          _selectListChar.contains(index)
              ? _selectListChar.remove(index)
              : _selectListChar.add(index);
        });
        // GetStorage().write('charFilterId', jsonEncode(_selectListChar));

        GetStorage().write('charFilterId', _selectListChar.toString());
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Chip(
          labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          label: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.size14Weight500.copyWith(
              color: _selectListChar.contains(index)
                  ? AppColors.mainPurpleColor
                  : Color(0xff636366),
              fontWeight: _selectListChar.contains(index) ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: _selectListChar.contains(index)
                  ? AppColors.mainPurpleColor
                  : Color(0xffAEAEB2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
