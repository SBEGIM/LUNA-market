import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_state.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart'
    as productCubit;
import '../../../drawer/bloc/brand_cubit.dart' as brandCubit;

class CatsProductWidget extends StatefulWidget {
  const CatsProductWidget({Key? key}) : super(key: key);

  @override
  _CatsProductWidgetState createState() => _CatsProductWidgetState();
}

class _CatsProductWidgetState extends State<CatsProductWidget> {
  String subCatName = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCatsCubit, SubCatsState>(
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
            return Container(
              height: 50,
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.cats.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (subCatName == state.cats[index].name.toString()) {
                          setState(() {
                            subCatName = '';
                          });
                          GetStorage().remove('subCatId');
                        } else {
                          GetStorage().write('subCatId', state.cats[index].id);
                          GetStorage().write('subCatFilterId',
                              [state.cats[index].id].toString());
                          setState(() {
                            subCatName = state.cats[index].name.toString();
                          });
                        }
                        BlocProvider.of<productCubit.ProductCubit>(context)
                            .products();
                        BlocProvider.of<brandCubit.BrandCubit>(context)
                            .brands(subCatId: state.cats[index].id);
                      },
                      child: Container(
                        height: 28,
                        padding: const EdgeInsets.only(right: 10),
                        child: Chip(
                          //labelPadding: const EdgeInsets.all(0.0),

                          label: Text(
                            state.cats[index].name.toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          backgroundColor:
                              state.cats[index].name.toString() == subCatName
                                  ? AppColors.kPrimaryColor
                                  : AppColors.steelGray,
                          elevation: 1.0,

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          // shadowColor: Colors.grey[60],
                          //padding: const EdgeInsets.all(4.0),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        });
  }
}
