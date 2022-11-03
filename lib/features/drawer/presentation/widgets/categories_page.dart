import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../../../../core/common/constants.dart';
import '../../data/bloc/product_cubit.dart';
import '../../data/bloc/sub_cats_cubit.dart';
import '../../data/bloc/sub_cats_state.dart';



class CategoriesPage extends StatefulWidget {

  CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _selectedIndexSort = -1;
  String subCatName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back(result: subCatName);

          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 20.0, right: 15),
            child: Text(
              'Сбросить',
              style: TextStyle(color: AppColors.kPrimaryColor),
            ),
          )
        ],
        title: const Text(
          'Категории',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: BlocConsumer<SubCatsCubit,SubCatsState>(
            listener: (context, state) {},

            builder: (context, state) {
              if (state is ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is LoadedState) {
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.cats.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          BlocProvider.of<ProductCubit>(context).products();

                          setState(() {
                            // устанавливаем индекс выделенного элемента
                            _selectedIndexSort = index;
                            subCatName = state.cats[index].name.toString();
                          });
                        },
                        child: ListTile(
                          selected: index == _selectedIndexSort,
                          leading:  Text(
                            '${state.cats[index].name}',
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
                );
              }else {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.indigoAccent)
                );
              }
            }),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Get.back(result: subCatName);
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
