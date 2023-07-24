import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../my_orders_admin/presentation/widgets/tape_card_widget.dart';
import '../../data/cubit/tape_blogger_cubit.dart';
import '../../data/cubit/tape_blogger_state.dart';

// import '../widgets/grid_tape_list.dart';
@RoutePage()
class TapeBloggerPage extends StatefulWidget {
  const TapeBloggerPage({Key? key}) : super(key: key);

  @override
  State<TapeBloggerPage> createState() => _TapeBloggerPageState();
}

class _TapeBloggerPageState extends State<TapeBloggerPage> {
  final List<Map> myProducts =
      List.generate(6, (index) => {"id": index, "name": "Product "}).toList();

  final int _value = 1;

  @override
  void initState() {
    BlocProvider.of<TapeBloggerCubit>(context).tapes(false, false, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          // leading: const Icon(
          //   Icons.arrow_back_ios,
          //   color: AppColors.kPrimaryColor,
          // ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: Icon(
                Icons.search,
                color: AppColors.kPrimaryColor,
              ),
            )
          ],
          title: const Text(
            "Мои видео",
            style: AppTextStyles.appBarTextStylea,
          ),
        ),
        body: BlocConsumer<TapeBloggerCubit, TapeBloggerState>(
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
                return GridView.builder(
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
                      interval: const Duration(
                          microseconds:
                              1), //Default value: Duration(seconds: 0)
                      color: Colors.white, //Default value
                      colorOpacity: 0, //Default value
                      enabled: true, //Default value
                      direction:
                          const ShimmerDirection.fromLTRB(), //Default Value
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        child: BloggerTapeCardWidget(
                          tape: state.tapeModel[index],
                          index: index,
                        ),
                      ),
                    );
                  },
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
                //           "http://185.116.193.73/storage/${state.tapeModel[index].image}",
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
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));

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
