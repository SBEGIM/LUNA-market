import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/categories_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/shops_filtr_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/sorting_page.dart';
import '../../data/bloc/brand_cubit.dart';
import '../../data/bloc/brand_state.dart';
import '../../data/bloc/product_cubit.dart' as productCubit;
import '../../data/bloc/product_state.dart' as productState;
import '../../data/bloc/shops_drawer_cubit.dart' as shopsCubit;
import '../../data/bloc/shops_drawer_state.dart' as shopsState;
import 'brands_page.dart';

class FilterPage extends StatefulWidget {
  String? shopId;
  FilterPage({this.shopId, Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues values = const RangeValues(1, 1000000);
  RangeLabels labels = const RangeLabels('1', "1000000");
  TextEditingController priceStartController = TextEditingController();
  TextEditingController priceEndController = TextEditingController();
  bool isSwitched = false;
  final List<int> _selectListBrand = [];
  final List<int> _selectListShop = [];
  String subCatName = 'Не выбрано';
  String sortName = 'Не выбрано';
  int count = 0;

  countProduct(int number) async {
    count = number;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    BrandCubit brandCubit = BlocProvider.of<BrandCubit>(context);

    if (brandCubit.state is! LoadedState) {
      brandCubit.brands();
    }

    BlocProvider.of<productCubit.ProductCubit>(context).products();

    if (GetStorage().hasData('brandFilterId')) {
      var brandId = GetStorage().read('brandFilterId');
      var ab = json.decode(brandId).cast<int>().toList();

      _selectListBrand.addAll(ab);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool selectedView = false;
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
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
                style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
              ),
            ),
          ),
          // ),
          title: const Text(
            'Фильтр',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 20, bottom: 5),
              child: InkWell(
                onTap: () {
                  GetStorage().remove('CatId');
                  GetStorage().remove('subCatFilterId');
                  GetStorage().remove('shopFilterId');
                  GetStorage().remove('search');
                },
                child: const Text(
                  'Сбросить',
                  style:
                      TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        body:
            BlocConsumer<productCubit.ProductCubit, productState.ProductState>(
                listener: (context, state) {
          if (state is productState.LoadedState) {
            countProduct(state.productModel.length);
          }
        }, builder: (context, state) {
          if (state is productState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is productState.LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is productState.LoadedState) {
            return ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        // ListTile(
                        //   title: const Text(
                        //     'Вид страницы ',
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w400),
                        //   ),
                        //   trailing: Wrap(
                        //     spacing: 12,
                        //     children: [
                        //       InkWell(
                        //           onTap: () {
                        //             selectedView = true;
                        //             setState(() {});
                        //           },
                        //           child: SvgPicture.asset('assets/icons/all_cat.svg')),
                        //       InkWell(
                        //           onTap: () {
                        //             selectedView = false;
                        //             setState(() {});
                        //           },
                        //           child: SvgPicture.asset('assets/icons/all_cat2.svg')),
                        //     ],
                        //   ),
                        // ),
                        // const Divider(
                        //   color: AppColors.kGray200,
                        // ),
                        SizedBox(
                          height: 71,
                          child: InkWell(
                            onTap: () async {
                              final data =
                                  await Get.to(() => const SortingPage())
                                      as String;
                              sortName = data;
                              setState(() {});
                            },
                            child: ListTile(
                                title: const Text(
                                  'Сортировка ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                  sortName,
                                  style: const TextStyle(
                                      color: AppColors.kGray300,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                trailing: const InkWell(
                                    child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 19,
                                ))),
                          ),
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.kGray200,
                        ),
                        SizedBox(
                          height: 71,
                          child: InkWell(
                            onTap: () async {
                              final data =
                                  await Get.to(() => const CategoriesPage())
                                      as String;

                              if (data != '') {
                                subCatName = data;

                                await BlocProvider.of<
                                        productCubit.ProductCubit>(context)
                                    .products();
                                setState(() {});
                              }
                            },
                            child: ListTile(
                                title: const Text(
                                  'Категория',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                  subCatName,
                                  style: const TextStyle(
                                      color: AppColors.kGray300,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                trailing: const InkWell(
                                    child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 19,
                                ))),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  // height: 200,
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Цена',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 39,
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.kGray200,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: TextField(
                                controller: priceStartController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'до ${values.start.toString()}',
                                ),
                              )),
                          Container(
                              height: 39,
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.kGray200,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: priceEndController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'до ${values.end.toString()}',
                                ),
                              )
                              // child: Te,
                              // child: Text(
                              //   'до ${values.end.toString()}',
                              //   style: const TextStyle(color: Colors.grey),
                              // ),
                              ),
                        ],
                      ),
                      RangeSlider(
                          divisions: 1000,
                          activeColor: AppColors.kPrimaryColor,
                          inactiveColor: AppColors.kGray300,
                          min: 1,
                          max: 1000000,
                          values: values,
                          labels: labels,
                          onChanged: (value) {
                            setState(() {
                              values = value;
                              priceStartController.text =
                                  value.start.toString();
                              priceEndController.text = value.end.toString();
                              labels = RangeLabels(
                                  value.start.toString(), value.end.toString());
                            });
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 13, right: 8, bottom: 13, top: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Бренд',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<BrandCubit, BrandState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is ErrorState) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: const TextStyle(
                                      fontSize: 20.0, color: Colors.grey),
                                ),
                              );
                            }
                            if (state is LoadedState) {
                              return GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          childAspectRatio: 1.3,
                                          crossAxisSpacing: 2,
                                          mainAxisSpacing: 1),
                                  itemCount: state.cats.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Container(
                                      child: chipBrand(
                                          state.cats[index].name.toString(),
                                          state.cats[index].id ?? 0),
                                    );
                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.indigoAccent));
                            }
                          }),
                      const Divider(
                        color: AppColors.kGray200,
                      ),
                      GestureDetector(
                        onTap: (() {
                          Get.to(() => const BrandsPage());
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Показать все',
                              style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.kGray300,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 13, right: 13, top: 10, bottom: 10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Высокий рейтинг',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: AppColors.kPrimaryColor,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.shopId == null)
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        left: 13, right: 8, bottom: 13, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Продавцы',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<shopsCubit.ShopsDrawerCubit,
                                shopsState.ShopsDrawerState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is shopsState.ErrorState) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: const TextStyle(
                                        fontSize: 20.0, color: Colors.grey),
                                  ),
                                );
                              }
                              if (state is shopsState.LoadedState) {
                                return GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            childAspectRatio: 1.3,
                                            crossAxisSpacing: 4,
                                            mainAxisSpacing: 1),
                                    itemCount: state.shopsDrawer.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Container(
                                          child: chipShops(
                                              state.shopsDrawer[index].name
                                                  .toString(),
                                              index));
                                    });
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.indigoAccent));
                              }
                            }),
                        const Divider(
                          color: AppColors.kGray200,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShopsFiltrPage()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Показать все',
                                style: TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.kGray300,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 60,
                ),
              ],
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        }),
        bottomSheet: GestureDetector(
            onTap: () {
              // GetStorage().remove('CatId');
              //           GetStorage().remove('subCatFilterId');
              //           GetStorage().remove('shopFilterId');
              //           GetStorage().remove('search');
              //           GetStorage().write('shopFilter',
              //               state.popularShops[index].name ?? '');
              //           // GetStorage().write('shopFilterId', state.popularShops[index].id);
              //           List<int> selectedListSort = [];
              //           selectedListSort
              //               .add(state.popularShops[index].id as int);
              //           GetStorage().write(
              //               'shopFilterId', selectedListSort.toString());
              //           // GetStorage().write('shopSelectedIndexSort', index);
              //  context.router.push(ProductsRoute(
              //   cats: subCatName != '' ? Cats(id:GetStorage().read('CatId') , name:subCatName ) : Cats(id: 0, name: ''),
              // ));

              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.kPrimaryColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  child: productState.ProductState is productState.LoadingState
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ))
                      : Text(
                          'Показать $count товара',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
            )));
  }

  Widget chipBrand(String label, int index) {
    return GestureDetector(
      onTap: () async {
        //_selectListBrand[index] = index;

        if (_selectListBrand.contains(index)) {
          _selectListBrand.remove(index);
        } else {
          _selectListBrand.add(index);
        }

        GetStorage().write('brandFilterId', _selectListBrand.toString());

        await BlocProvider.of<productCubit.ProductCubit>(context).products();

        setState(() {});

        // _selectListBrand.forEach((element) {
        //   return print(element);
        // });
        // BlocProvider.of<productCubit.ProductCubit>(context).products();
      },
      child: Chip(
        labelPadding: const EdgeInsets.all(4.0),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: _selectListBrand.contains(index)
            ? AppColors.kPrimaryColor
            : Colors.white,
        elevation: 1.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        // shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(6.0),
      ),
    );
  }

  Widget chipShops(String label, int index) {
    return GestureDetector(
      onTap: () {
        if (_selectListShop.contains(index)) {
          _selectListShop.remove(index);
        } else {
          _selectListShop.add(index);
        }

        BlocProvider.of<productCubit.ProductCubit>(context).products();

        setState(() {});
        // BlocProvider.of<productCubit.ProductCubit>(context).products();
      },
      child: Chip(
        labelPadding: const EdgeInsets.all(4.0),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: _selectListShop.contains(index)
            ? AppColors.kPrimaryColor
            : Colors.white,
        elevation: 1.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        // shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(6.0),
      ),
    );
  }
}
