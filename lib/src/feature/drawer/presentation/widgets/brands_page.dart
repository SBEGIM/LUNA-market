import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/bloc/brand_cubit.dart';

class BrandsPage extends StatefulWidget {
  const BrandsPage({super.key});

  @override
  State<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  final List<int> _selectedListSort = [];
  String subCatName = '';

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
            Navigator.of(context).pop(subCatName);
          },
          child: const Icon(Icons.arrow_back_ios, color: AppColors.kPrimaryColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _selectedListSort.clear();
              setState(() {});
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0, right: 15),
              child: Text('Сбросить', style: TextStyle(color: AppColors.kPrimaryColor)),
            ),
          ),
        ],
        title: const Text(
          'Бренды',
          style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: BlocConsumer<BrandCubit, BrandState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is BrandStateError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              );
            }
            if (state is BrandStateLoaded) {
              return ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.cats.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      const Divider(height: 1),
                      SizedBox(
                        height: 55,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_selectedListSort.contains(index)) {
                                _selectedListSort.remove(index);
                              } else {
                                _selectedListSort.add(index);
                              }

                              GetStorage().write('brandFilterId', _selectedListSort.toString());

                              final filters = context.read<FilterProvider>();

                              BlocProvider.of<ProductCubit>(context).products(filters);
                            });
                          },
                          child: ListTile(
                            selected: _selectedListSort.contains(index),
                            leading: Text(
                              '${state.cats[index].name}',
                              style: AppTextStyles.appBarTextStyle,
                            ),
                            trailing: _selectedListSort.contains(index)
                                ? SvgPicture.asset('assets/icons/check_circle.svg')
                                : SvgPicture.asset('assets/icons/check_circle_no_selected.svg'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop(subCatName);
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
