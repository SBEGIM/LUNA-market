import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import '../../../product/cubit/product_cubit.dart';

class SortingPage extends StatefulWidget {
  const SortingPage({Key? key}) : super(key: key);

  @override
  State<SortingPage> createState() => _SortingPageState();
}

class _SortingPageState extends State<SortingPage> {
  int _selectedIndexSort = -1;

  List<String> sort = [
    'Популярные',
    'Новинки',
    'Сначала дешевые',
    'Сначала дорогие',
    'Высокий рейтинг',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            final select = _selectedIndexSort == -1 ? 'Не выбрано' : sort[_selectedIndexSort];

            Get.back(result: select);
          },
          child: const Icon(Icons.arrow_back_ios, color: AppColors.kPrimaryColor),
        ),
        title: const Text(
          'Сортировка',
          style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SizedBox(
        height: 275,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sort.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                index == 0
                    ? const Divider(height: 0.3, color: Color.fromRGBO(196, 200, 204, 1))
                    : Container(),
                Container(
                  color: Colors.white,
                  height: 55,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndexSort = index;
                      });
                      final filters = context.read<FilterProvider>();

                      switch (sort[_selectedIndexSort]) {
                        case 'Популярные':
                          filters.setSort('orderByPopular');
                          break;
                        case 'Новинки':
                          filters.setSort('orderByNew');
                          break;
                        case 'Сначала дешевые':
                          filters.setSort('priceAsc');
                          break;
                        case 'Сначала дорогие':
                          filters.setSort('priceDesc');
                          break;
                        case 'Высокий рейтинг':
                          filters.setSort('rating');
                          break;
                      }
                      BlocProvider.of<ProductCubit>(context).products(filters);
                    },
                    child: ListTile(
                      selected: index == _selectedIndexSort,
                      leading: Text(
                        sort[index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.kLightBlackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: _selectedIndexSort == index
                          ? SvgPicture.asset('assets/icons/check_circle.svg')
                          : SvgPicture.asset('assets/icons/check_circle_no_selected.svg'),
                    ),
                  ),
                ),
                const Divider(height: 0, color: Color.fromRGBO(196, 200, 204, 1)),
              ],
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: GestureDetector(
          onTap: () {
            final select = _selectedIndexSort == -1 ? 'Не выбрано' : sort[_selectedIndexSort];

            Get.back(result: select);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.kPrimaryColor,
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Готово',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
