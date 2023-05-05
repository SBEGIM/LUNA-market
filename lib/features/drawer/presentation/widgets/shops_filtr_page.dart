import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../../../../core/common/constants.dart';
import '../../data/bloc/shops_drawer_cubit.dart';
import '../../data/bloc/shops_drawer_state.dart';

class ShopsFiltrPage extends StatefulWidget {
  const ShopsFiltrPage({Key? key}) : super(key: key);

  @override
  State<ShopsFiltrPage> createState() => _ShopsFiltrPageState();
}

class _ShopsFiltrPageState extends State<ShopsFiltrPage> {
  final List<int> _selectedListSort = [];

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
            Get.back(result: '');
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _selectedListSort.clear();
              setState(() {});
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0, right: 15),
              child: Text(
                'Сбросить',
                style: TextStyle(color: AppColors.kPrimaryColor),
              ),
            ),
          )
        ],
        title: const Text(
          'Магазины',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: BlocConsumer<ShopsDrawerCubit, ShopsDrawerState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is LoadedState) {
                return SizedBox(
                  height: 225,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.shopsDrawer.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          const Divider(
                            height: 1,
                          ),
                          SizedBox(
                            height: 55,
                            child: InkWell(
                                onTap: () {
                                  // BlocProvider.of<ProductCubit>(context)
                                  //     .products();

                                  // устанавливаем индекс выделенного элемента
                                  // _selectedIndexSort = index;

                                  if (_selectedListSort.contains(index)) {
                                    _selectedListSort.remove(index);
                                  } else {
                                    _selectedListSort.add(index);
                                  }

                                  // _selectedListSort.subCatName = state
                                  //     .shopsDrawer[index].name
                                  //
                                  //
                                  //
                                  setState(() {});
                                },
                                child: ListTile(
                                  selected: _selectedListSort.contains(index),
                                  leading: Text(
                                    '${state.shopsDrawer[index].name}',
                                    style: AppTextStyles.appBarTextStyle,
                                  ),
                                  trailing: _selectedListSort.contains(index)
                                      ? SvgPicture.asset(
                                          'assets/icons/check_circle.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/check_circle_no_selected.svg',
                                        ),
                                )),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Get.back(result: '');
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
