import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/home/data/model/characteristic_model.dart';
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

  @override
  void initState() {
    super.initState();
    final initCharCubit =
        BlocProvider.of<charCubit.CharacteristicSellerCubit>(context);
    initCharCubit.characteristic();
    subChars();
    if (GetStorage().hasData('charFilterId')) {
      var brandId = GetStorage().read('charFilterId');
      try {
        var ab = json.decode(brandId).cast<int>().toList();
        _selectListChar.addAll(ab);
      } catch (e) {
        print('Ошибка при чтении фильтров: $e');
      }
    }
  }

  Future<void> subChars() async {
    final initCharCubit =
        BlocProvider.of<charCubit.CharacteristicSellerCubit>(context);

    final subCharList = await initCharCubit.subListCharacteristic();

    subCharList!.forEach((e) {
      print('${e.value} : ${e.mainId}');
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
        appBar: AppBar(
          title: Text(
            'Фильтр',
            style: TextStyle(color: AppColors.kLightBlackColor, fontSize: 16),
          ),
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leadingWidth: 100,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 8),
              child: Text(
                'Отмена',
                style: TextStyle(
                    color: AppColors.mainPurpleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                // GetStorage().remove('CatId');
                // GetStorage().remove('subCatFilterId');
                // GetStorage().remove('shopFilterId');
                // GetStorage().remove('search');
              },
              child: Container(
                width: 82,
                height: 32,
                margin: EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.kGray200),
                child: const Text(
                  'Сбросить',
                  style: TextStyle(color: AppColors.kGray2, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<charCubit.CharacteristicSellerCubit,
                    charState.CharacteristicSellerState>(
                listener: (context, state) {
              if (state is charState.LoadedState) {
                //   _subCharMap.clear();
                //   final characteristics = state.characteristics.take(3);
                //   for (final item in characteristics) {
                //     subChars(item.id ?? 0);
                //   }
                // }
              }
            }, builder: (context, state) {
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
                      final subList =
                          _subCharMap[state.characteristics[index].id] ?? [];

                      print(
                          "subList for ${state.characteristics[index].id} : ${subList.length}");
                      return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.only(
                              left: 13, right: 8, bottom: 13, top: 13),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.characteristics[index].key}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 8.0,
                                  children: List.generate(
                                    subList.length >= 9 ? 9 : subList.length,
                                    (index) => chipBrand(
                                      subList[index].value ?? '',
                                      subList[index].id ?? 0,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.kGray2,
                                ),
                                subList.length >= 9
                                    ? GestureDetector(
                                        onTap: (() {
                                          Get.to(() => const BrandsPage());
                                        }),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Показать еще (${subList.length - 9})',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.mainPurpleColor,
                                                  letterSpacing: 0,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColors.mainPurpleColor,
                                              size: 13,
                                            )
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ]));
                    });
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }),
          ],
        ),
        bottomSheet: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainPurpleColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Применить',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  )),
            )));
  }

  Widget chipBrand(String label, int index) {
    return InkWell(
      onTap: () async {
        if (_selectListChar.contains(index)) {
          _selectListChar.remove(index);
        } else {
          _selectListChar.add(index);
        }
        GetStorage().write('charFilterId', _selectListChar.toString());
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Chip(
          labelPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          label: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _selectListChar.contains(index)
                  ? AppColors.mainPurpleColor
                  : AppColors.kGray300,
              fontWeight: FontWeight.w500,
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: _selectListChar.contains(index)
                  ? AppColors.mainPurpleColor
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          elevation: 2.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        ),
      ),
    );
  }
}
