import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/home/bloc/popular_shops_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/popular_shops_state.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PopularShopsPage extends StatefulWidget {
  const PopularShopsPage({Key? key}) : super(key: key);

  @override
  _PopularShopsPageState createState() => _PopularShopsPageState();
}

class _PopularShopsPageState extends State<PopularShopsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularShopsCubit, PopularShopsState>(
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
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is LoadedState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Бренды и Магазины',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.65,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: state.popularShops.length >= 6
                            ? 6
                            : state.popularShops.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                GetStorage().remove('CatId');
                                GetStorage().remove('subCatFilterId');
                                GetStorage().remove('shopFilterId');
                                GetStorage().remove('search');
                                GetStorage().write('shopFilter',
                                    state.popularShops[index].name ?? '');
                                // GetStorage().write('shopFilterId', state.popularShops[index].id);

                                List<int> selectedListSort = [];

                                selectedListSort
                                    .add(state.popularShops[index].id as int);

                                GetStorage().write('shopFilterId',
                                    selectedListSort.toString());

                                // GetStorage().write('shopSelectedIndexSort', index);
                                context.router.push(ProductsRoute(
                                  cats: CatsModel(id: 0, name: ''),
                                  shopId:
                                      state.popularShops[index].id.toString(),
                                ));
                                // Get.to(ProductsPage(
                                //   cats: Cats(id: 0, name: ''),
                                // ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color.fromARGB(15, 227, 9, 9),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5, left: 12, right: 12),
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: DecorationImage(
                                                  image: state
                                                              .popularShops[
                                                                  index]
                                                              .image !=
                                                          null
                                                      ? NetworkImage(
                                                          "https://lunamarket.ru/storage/${state.popularShops[index].image!}",
                                                        )
                                                      : const AssetImage(
                                                              'assets/icons/shops&brands.png')
                                                          as ImageProvider,
                                                  fit: BoxFit.fitWidth),
                                              color: const Color(0xFFF0F5F5)),
                                          // child: Image.network(
                                          //   "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
                                          //   width: 70,
                                          // ),
                                        ),
                                        // Container(
                                        //   height: 90,
                                        //   width: 90,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //       image: DecorationImage(
                                        //         image: NetworkImage(
                                        //             "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}"),
                                        //         fit: BoxFit.cover,
                                        //       )),
                                        // ),
                                        if (state.popularShops[index].credit ==
                                            true)
                                          Container(
                                            width: 50,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  31, 196, 207, 1),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 130,
                                                top: 5,
                                                left: 5,
                                                right: 50),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "0·0·12",
                                              style:
                                                  AppTextStyles.bannerTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        Container(
                                          width: 35,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          margin: const EdgeInsets.only(
                                              bottom: 80,
                                              top: 5,
                                              left: 5,
                                              right: 65),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${state.popularShops[index].bonus.toString()}% Б",
                                            style:
                                                AppTextStyles.bannerTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.17,
                                              left: 4),
                                          alignment: Alignment.center,
                                          child: Text(
                                              state.popularShops[index].name ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .categoryTextStyle),
                                        ),
                                      ],
                                    ),

                                    // Center(
                                    //   child: Image.asset(
                                    //
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // Text(state.popularShops[index].name!,
                                    //     style: AppTextStyles.categoryTextStyle),
                                    // Flexible(
                                    //     child:
                                  ],
                                ),
                              )); // );
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.push(const ShopsRoute());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Все предложения ',
                            style: AppTextStyles.kcolorPrimaryTextStyle,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.kPrimaryColor,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Shimmer(
              duration: const Duration(seconds: 3), //Default value
              interval: const Duration(
                  microseconds: 1), //Default value: Duration(seconds: 0)
              color: Colors.white, //Default value
              colorOpacity: 0, //Default value
              enabled: true, //Default value
              direction: const ShimmerDirection.fromLTRB(), //Default Value
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.6),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: SizedBox(
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
            );
          }
        });
  }
}
