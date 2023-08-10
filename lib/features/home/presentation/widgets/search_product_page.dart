import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/drawer/data/bloc/product_cubit.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import '../../../drawer/data/bloc/product_state.dart';
import '../../../drawer/presentation/widgets/detail_card_product_page.dart';

@RoutePage()
class SearchProductPage extends StatefulWidget {
  const SearchProductPage({Key? key}) : super(key: key);

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).products();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/back_header.svg'),
          ),
          title: Container(
            width: 311,
            height: 40,
            padding: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: searchController,
              onChanged: (value) async {
                GetStorage().write('search', value);
                GetStorage().write('shopFilterId', 0);

                await BlocProvider.of<ProductCubit>(context).products();

                // if(value.isEmpty){
                //   BlocProvider.of<SubCatsCubit>(context)
                //       .subSave();
                // }else{
                //   BlocProvider.of<SubCatsCubit>(context)
                //       .searchSubCats(value , widget.cats.id);
                // }
                // if (searchController.text.isEmpty)
                //   BlocProvider.of<CityCubit>(context)
                //       .cities(value);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.kGray300,
                ),
                hintText: 'Поиск',
                hintStyle: TextStyle(
                  color: AppColors.kGray300,
                  fontSize: 18,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          )),
      body: BlocConsumer<ProductCubit, ProductState>(
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
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }

            if (state is LoadedState) {
              return ListView(shrinkWrap: true, children: [
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   color: AppColors.kBackgroundColor,
                //   padding: const EdgeInsets.only(
                //       left: 16, right: 16, top: 8, bottom: 8),
                //   child: const Text(
                //     'Поиск продуктов',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //         color: AppColors.kGray900),
                //   ),
                // ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.productModel.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => ProductsPage(
                                //           cats: state.productModel[index])),
                                // );

                                GetStorage().remove('CatId');
                                GetStorage().remove('subCatFilterId');
                                GetStorage().remove('shopFilterId');
                                // context.router.push(ProductsRoute(
                                //   // cats: state.cats[index],
                                // ));
                                context.router.push(DetailCardProductRoute(product: state.productModel[index]));
                              },
                              child: UnderCatalogListTile(
                                title: state.productModel[index].name.toString(),
                                product: state.productModel[index],
                              )),
                          const Divider(
                            color: AppColors.kGray300,
                          )
                        ],
                      );
                    }),
              ]);
            } else {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          }),
    );
  }
}

class UnderCatalogListTile extends StatelessWidget {
  final String title;
  ProductModel product;
  UnderCatalogListTile({
    required this.product,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: const EdgeInsets.only(left: 16, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.chanheLangTextStyle,
          ),
          SvgPicture.asset('assets/icons/back_menu.svg', width: 12, height: 16),
        ],
      ),
    );
  }
}
