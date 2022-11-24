import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_cubit.dart';
import 'package:haji_market/features/favorite/presentation/widgets/delivery_page.dart';
import '../../../drawer/data/bloc/favorite_state.dart';
import '../../../drawer/presentation/widgets/detail_card_product_page.dart';
import '../../../drawer/presentation/widgets/products_card_widget.dart';
import 'favorite_products.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    BlocProvider.of<FavoriteCubit>(context).myFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
            backgroundColor: Colors.white,
            elevation: 0,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back_ios,
            //     color: AppColors.kPrimaryColor,
            //   ),
            // ),
            centerTitle: true,
            title: const Text(
              'Избранное',
              style: TextStyle(color: Colors.black, fontSize: 16),
            )),
        body: BlocConsumer<FavoriteCubit, FavoriteState>(
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
              if (state is LoadingState) {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }

              if (state is LoadedState) {
                return Column(
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 12),
                    //   child: Text(
                    //     'Найдено ${state.productModel.length} товаров',
                    //     style: AppTextStyles.kGray400Text,
                    //     textAlign: TextAlign.start,
                    //   ),
                    // ),
                    SizedBox(
                      height: 530,
                      child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.productModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCardProductPage(
                                        product: state.productModel[index])),
                              ),
                              child: FavoriteProductsCardWidget(
                                  product: state.productModel[index]),
                            );
                          }),
                    )
                  ],
                );
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}
