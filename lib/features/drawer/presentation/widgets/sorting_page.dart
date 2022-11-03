import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';

import '../../data/bloc/product_cubit.dart';

class SortingPage extends StatefulWidget {
  SortingPage({Key? key}) : super(key: key);

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
    'Высокий рейтинг'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back(result:sort[_selectedIndexSort]);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        title: const Text(
          'Сортировка',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sort.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  setState(() {
                    // устанавливаем индекс выделенного элемента
                    _selectedIndexSort = index;
                  });
                  BlocProvider.of<ProductCubit>(context).products();

                },
                child: ListTile(
                  selected: index == _selectedIndexSort,
                  leading:  Text(
                  sort[index],
                    style: AppTextStyles.appBarTextStyle,
                  ),
                  trailing: _selectedIndexSort == index
                      ? SvgPicture.asset(
                          'assets/icons/check_circle.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/check_circle_no_selected.svg',
                        ),
                ));
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Get.back(result:sort[_selectedIndexSort]);
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
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
