import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_cubit.dart';
import 'package:haji_market/features/tape/presentation/widgets/tape_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../data/bloc/tape_state.dart';
import '../widgets/anim_search_widget.dart';

@RoutePage()
class TapePage extends StatefulWidget {
  const TapePage({Key? key}) : super(key: key);

  @override
  State<TapePage> createState() => _TapePageState();
}

class _TapePageState extends State<TapePage> {
  RefreshController refreshController = RefreshController();
  String title = 'Лента';
  final TextEditingController searchController = TextEditingController();
  bool visible = true;

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  Future<void> onLoading() async {
    await BlocProvider.of<TapeCubit>(context).tapePagination(title == 'Подписки', title == 'Избранное', '', 0);
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  @override
  void initState() {
    if (BlocProvider.of<TapeCubit>(context).state is! LoadedState) {
      BlocProvider.of<TapeCubit>(context).tapes(false, false, '', 0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: title != 'Лента' ? const IconThemeData(color: AppColors.kWhite) : null,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: title != 'Лента'
              ? GestureDetector(
                  onTap: () {
                    context.router.pop();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => new Base(index: 0)),
                    // );
                    // BlocProvider.of<navCubit.NavigationCubit>(context)
                    //     .getNavBarItem(const navCubit.NavigationState.tape());
                    title = 'Лента';
                    BlocProvider.of<TapeCubit>(context).tapes(false, false, '', 0);

                    setState(() {});
                    // print(title);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.kPrimaryColor,
                  ),
                )
              : null,
          actions: [
            AnimSearchBar(
              helpText: 'Поиск..',
              color: AppColors.kPrimaryColor,
              onChanged: (String? value) {
                BlocProvider.of<TapeCubit>(context).tapes(false, false, searchController.text, 0);
                setState(() {});
              },
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
              textController: searchController,
              onSuffixTap: () {
                searchController.clear();
              },
              onArrowTap: () {
                visible = !visible;
                // print(visible.toString());
                setState(() {
                  visible;
                });
                searchController.clear();
              },
              width: MediaQuery.of(context).size.width,
            ),

            // Padding(
            //   padding: EdgeInsets.only(right: 22.0),
            //   child: Icon(
            //     Icons.search,
            //   ),
            // )
          ],
          centerTitle: true,
          title: visible == true
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PopupMenuButton(
                      color: const Color.fromRGBO(230, 231, 232, 1),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      position: PopupMenuPosition.under,
                      offset: const Offset(0, 25),
                      itemBuilder: (BuildContext bc) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              title = 'Подписки';
                              BlocProvider.of<TapeCubit>(context).tapes(true, false, '', 0);

                              setState(() {});
                            },
                            value: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Подписки",
                                  style: TextStyle(color: Colors.black),
                                ),
                                SvgPicture.asset('assets/icons/lenta1.svg'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              BlocProvider.of<TapeCubit>(context).tapes(false, true, '', 0);

                              title = 'Избранное';
                              setState(() {});
                            },
                            value: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Избранное"),
                                SvgPicture.asset('assets/icons/lenta2.svg'),
                              ],
                            ),
                          ),
                        ];
                      },
                      child: Row(
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            'assets/icons/drop_down2.svg',
                            //height: 16.5,
                            // width: 16.5,
                          )
                        ],
                      ), // Icon(Icons.done,color: AppColors.kPrimaryColor,size: 16,)
                    ),
                  ],
                )
              : null,
        ),
        body: BlocConsumer<TapeCubit, TapeState>(
            listener: (context, state) {
            },
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
              if (state is NoDataState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.height,
                  child: SmartRefresher(
                    controller: refreshController,
                    onRefresh: () {
                      BlocProvider.of<TapeCubit>(context).tapes(title == 'Подписки', title == 'Избранное', '', 0);
                      refreshController.refreshCompleted();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 146), child: Image.asset('assets/icons/no_data.png')),
                        const Text(
                          'В ленте нет данных',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'По вашему запросу ничего не найдено',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff717171)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              }

              if (state is LoadedState) {
                return SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  onLoading: () {
                    onLoading();
                  },
                  onRefresh: () {
                    BlocProvider.of<TapeCubit>(context).tapes(title == 'Подписки', title == 'Избранное', '', 0);
                    refreshController.refreshCompleted();
                  },
                  child: GridView.builder(
                    cacheExtent: 10000,
                    padding: const EdgeInsets.all(1),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 1 / 2,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                    ),
                    itemCount: state.tapeModel.length,
                    // children: const [],
                    itemBuilder: (context, index) {
                      return Shimmer(
                        duration: const Duration(seconds: 3), //Default value
                        interval: const Duration(microseconds: 1), //Default value: Duration(seconds: 0)
                        color: Colors.white, //Default value
                        colorOpacity: 0, //Default value
                        enabled: true, //Default value
                        direction: const ShimmerDirection.fromLTRB(), //Default Value
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withOpacity(0.6),
                          ),
                          child: TapeCardWidget(
                            tape: state.tapeModel[index],
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                );
                // return GridView.custom(
                //   gridDelegate: SliverQuiltedGridDelegate(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 4,
                //     crossAxisSpacing: 4,
                //     repeatPattern: QuiltedGridRepeatPattern.inverted,
                //     pattern: [
                //       // const QuiltedGridTile(4, 2),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(4, 2),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       // const QuiltedGridTile(2, 1),
                //       const QuiltedGridTile(1, 1),
                //       const QuiltedGridTile(1, 1),
                //       const QuiltedGridTile(1, 1),
                //       const QuiltedGridTile(1, 1),
                //     ],
                //   ),
                //   childrenDelegate: SliverChildBuilderDelegate(
                //     childCount: state.tapeModel.length,
                //     (context, index) =>

                //         // Image.network(
                //         //   "http://80.87.202.73:8001/storage/${state.tapeModel[index].image}",
                //         //   fit: BoxFit.fitWidth,
                //         // ),
                //         TapeCardWidget(
                //       index: index,
                //       tape: state.tapeModel[index],
                //     ),
                //   ),
                // );
                // StaggeredGrid.count(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 3,
                //     crossAxisSpacing: 3,

                //     children: [
                //       StaggeredGridTile.count(
                //         crossAxisCellCount: 1,
                //         mainAxisCellCount: 1,
                //         child: TapeCardWidget(
                //           tape: state.tapeModel[0],
                //           index: 0,
                //         ),
                //       ),
                //       StaggeredGridTile.count(
                //         crossAxisCellCount: 1,
                //         mainAxisCellCount: 1,
                //         child: TapeCardWidget(
                //           tape: state.tapeModel[1],
                //           index: 1,
                //         ),
                //       ),
                //       StaggeredGridTile.count(
                //         crossAxisCellCount: 1,
                //         mainAxisCellCount: 2,
                //         child: TapeCardWidget(
                //           tape: state.tapeModel[2],
                //           index: 2,
                //         ),
                //       ),
                //       StaggeredGridTile.count(
                //         crossAxisCellCount: 1,
                //         mainAxisCellCount: 1,
                //         child: TapeCardWidget(
                //           tape: state.tapeModel[2],
                //           index: 2,
                //         ),
                //       ),
                //       StaggeredGridTile.count(
                //         crossAxisCellCount: 1,
                //         mainAxisCellCount: 2,
                //         child: TapeCardWidget(
                //           tape: state.tapeModel[2],
                //           index: 2,
                //         ),
                //       ),
                //     ]
                //     // state.tapeModel
                //     //     .map((e) => StaggeredGridTile.count(
                //     //           crossAxisCellCount: random(1, 4),
                //     //           mainAxisCellCount: random(1, 4),
                //     //           child: TapeCardWidget(
                //     //             tape: e,
                //     //             index: e.id ?? 1,
                //     //           ),
                //     //         ))
                //     //     .toList(),
                //     );

                // return MasonryGridView.count(
                //   crossAxisCount: 3,
                //   mainAxisSpacing: 3,
                //   crossAxisSpacing: 3,
                //   itemCount: state.tapeModel.length,
                //   itemBuilder: (context, index) {
                //     return TapeCardWidget(
                //       tape: state.tapeModel[index],
                //       index: index,
                //     );
                //   },
                // );

                // return MasonryGridView.count(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 3,
                //     crossAxisSpacing: 3,
                //     itemCount: state.tapeModel.length,
                //     itemBuilder: (context, index) {
                //       return TapeCardWidget(
                //         tape: state.tapeModel[index],
                //         index: index,
                //       );
                //     });

                //   },
                // );
              } else {
                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}
