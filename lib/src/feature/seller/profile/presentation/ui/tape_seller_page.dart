import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_state.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/detail_tape_card_page.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/tape_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

// import '../widgets/grid_tape_list.dart';
@RoutePage()
class TapeSellerPage extends StatefulWidget {
  const TapeSellerPage({super.key});

  @override
  State<TapeSellerPage> createState() => _TapeSellerPageState();
}

class _TapeSellerPageState extends State<TapeSellerPage>
    with TickerProviderStateMixin {
  late final TabController _tabs =
      TabController(length: 2, vsync: this, initialIndex: 0);

  final List<Map> myProducts =
      List.generate(6, (index) => {"id": index, "name": "Product "}).toList();

  TextEditingController searchController = TextEditingController();
  final int _value = 1;

  @override
  void initState() {
    _tabs.addListener(_onTab);

    BlocProvider.of<TapeBloggerCubit>(context).tapes(false, false, '');
    super.initState();
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  RefreshController refreshController = RefreshController();

  void _onTab() {
    context.read<TapeBloggerCubit>().tapes(
          _tabs.index == 1,
          _tabs.index == 2,
          searchController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,

          title: Text("Видео обзоры",
              style:
                  AppTextStyles.defaultAppBarTextStyle.copyWith(fontSize: 18)),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: TabBar(
              indicatorWeight: 0,
              automaticIndicatorColorAdjustment: true,
              indicatorPadding: EdgeInsets.zero,
              labelStyle: AppTextStyles.aboutTextStyle,
              indicatorColor: AppColors.kWhite,
              labelColor: AppColors.kLightBlackColor,
              indicator: FixedWidthIndicator(
                width: MediaQuery.of(context).size.width / 2,
                borderSide: const BorderSide(
                    width: 1, color: AppColors.kLightBlackColor),
              ),
              controller: _tabs,
              tabs: const <Widget>[
                Tab(text: 'Ваши обзоры'),
                Tab(text: 'Обзоры блогеров'),
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 1000,
              child: BlocConsumer<TapeBloggerCubit, TapeBloggerState>(
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
                    if (state is LoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.indigoAccent));
                    }
                    if (state is NoDataState) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 146),
                                child: Image.asset('assets/icons/no_data.png')),
                            const Text(
                              'В ленте нет данных',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'По вашему запросу ничего не найдено',
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
                      return SmartRefresher(
                        controller: refreshController,
                        onRefresh: () {
                          BlocProvider.of<TapeBloggerCubit>(context)
                              .tapes(false, false, '');
                          refreshController.refreshCompleted();
                        },
                        child: GridView.builder(
                          cacheExtent: 10000,
                          padding: const EdgeInsets.all(0),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            childAspectRatio: 1 / 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 3,
                          ),
                          itemCount: state.tapeModel.length,
                          // children: const [],
                          itemBuilder: (context, index) {
                            return Shimmer(
                              duration:
                                  const Duration(seconds: 3), //Default value
                              interval: const Duration(
                                  microseconds:
                                      1), //Default value: Duration(seconds: 0)
                              color: Colors.white, //Default value
                              colorOpacity: 0, //Default value
                              enabled: true, //Default value
                              direction: const ShimmerDirection
                                  .fromLTRB(), //Default Value
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black.withOpacity(1.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(DetailTapeBloggerCardPage(
                                        index: index,
                                        tapeId: state.tapeModel[index].tapeId,
                                        tape: state.tapeModel[index],
                                        tapeBloc:
                                            BlocProvider.of<TapeBloggerCubit>(
                                                context),
                                        shopName:
                                            state.tapeModel[index].shop!.name,
                                      ));
                                    },
                                    child: BloggerTapeCardPage(
                                      tape: state.tapeModel[index],
                                      index: index,
                                    ),
                                  )),
                            );
                          },
                        ),
                      );

                      // return GridView.builder(
                      //   padding: const EdgeInsets.all(1),
                      //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      //     maxCrossAxisExtent: 150,
                      //     childAspectRatio: 1 / 2,
                      //     mainAxisSpacing: 3,
                      //     crossAxisSpacing: 3,
                      //   ),
                      //   itemCount: state.tapeModel.length,
                      //   // children: const [],
                      //   itemBuilder: (context, index) {
                      //     return Stack(
                      //       children: [
                      //         Image.asset('assets/images/tape.png'),
                      //         Image.network(
                      //           "https://lunamarket.ru/storage/${state.tapeModel[index].image}",
                      //         ),
                      //         Align(
                      //           alignment: Alignment.bottomCenter,
                      //           child: Container(
                      //             width: MediaQuery.of(context).size.width,
                      //             color: Colors.transparent.withOpacity(0.4),
                      //             child: Text(
                      //               '${state.tapeModel[index].name}',
                      //               textAlign: TextAlign.center,
                      //               style: const TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(right: 5.0, top: 5),
                      //           child: Align(
                      //               alignment: Alignment.topRight,
                      //               child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.white,
                      //                       borderRadius: BorderRadius.circular(10)),
                      //                   padding: const EdgeInsets.all(3),
                      //                   child: InkWell(
                      //                     onTap: () {
                      //                       showAlertTapeWidget(context);
                      //                       // showAlertStaticticsWidget(context);
                      //                     },
                      //                     child: const Icon(
                      //                       Icons.more_vert_outlined,
                      //                       color: AppColors.kPrimaryColor,
                      //                     ),
                      //                   ))),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.indigoAccent));
                    }
                  }),
            ),
          ],
        ));

    //  GridView(
    //   padding: const EdgeInsets.all(1),
    //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 150,
    //     childAspectRatio: 1 / 2,
    //     mainAxisSpacing: 3,
    //     crossAxisSpacing: 3,
    //   ),
    //   children: [
    //     Stack(
    //       children: [
    //         Image.asset('assets/images/tape.png'),
    //         Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Container(
    //             width: MediaQuery.of(context).size.width,
    //             color: Colors.transparent.withOpacity(0.4),
    //             child: const Text(
    //               'ZARA',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(right: 5.0, top: 5),
    //           child: Align(
    //               alignment: Alignment.topRight,
    //               child: Container(
    //                   decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(10)),
    //                   padding: const EdgeInsets.all(3),
    //                   child: InkWell(
    //                     onTap: () {
    //                       showAlertTapeWidget(context);
    //                       // showAlertStaticticsWidget(context);
    //                     },
    //                     child: const Icon(
    //                       Icons.more_vert_outlined,
    //                       color: AppColors.kPrimaryColor,
    //                     ),
    //                   ))),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
    //);
  }
}

class FixedWidthIndicator extends Decoration {
  final double width;
  final BorderSide borderSide;

  const FixedWidthIndicator({
    required this.width,
    required this.borderSide,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FixedWidthPainter(this, onChanged);
  }
}

class _FixedWidthPainter extends BoxPainter {
  final FixedWidthIndicator decoration;

  _FixedWidthPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = decoration.borderSide.color
      ..strokeWidth = decoration.borderSide.width
      ..style = PaintingStyle.stroke;

    final double tabCenter = offset.dx + configuration.size!.width / 2;
    final double y = offset.dy +
        configuration.size!.height -
        decoration.borderSide.width / 2;

    final double startX = tabCenter - decoration.width / 2;
    final double endX = tabCenter + decoration.width / 2;

    canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
  }
}
