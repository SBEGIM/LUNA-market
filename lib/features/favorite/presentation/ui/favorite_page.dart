import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_cubit.dart';
import '../../../drawer/data/bloc/favorite_state.dart';
import '../../../drawer/presentation/widgets/detail_card_product_page.dart';
import 'favorite_products.dart';
@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

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
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is LoadingState) {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
              if (state is NoDataState) {
                return Container(
                  width: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 146),
                          child: Image.asset('assets/icons/no_data.png')),
                      const Text(
                        'В избранном нет товаров',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Для выбора вещей перейдите в маркет',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff717171)),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }

              if (state is LoadedState) {
                return ListView.builder(
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
                    });
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}
