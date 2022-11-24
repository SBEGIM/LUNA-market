import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_cubit.dart';
import 'package:haji_market/features/tape/presentation/widgets/tape_card_widget.dart';

import '../data/bloc/tape_state.dart';

class TapePage extends StatefulWidget {
  TapePage({Key? key}) : super(key: key);

  @override
  State<TapePage> createState() => _TapePageState();
}

class _TapePageState extends State<TapePage> {
  String? title;
  final TextEditingController searchController = TextEditingController();
  bool visible = true;
  @override
  void initState() {
    BlocProvider.of<TapeCubit>(context).tapes(false, false, null);
    title = 'Лента';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          // leading:  GestureDetector(
          //   onTap: () => Get.back(),
          //   child: const Icon(
          //     Icons.arrow_back_ios,
          //     color: AppColors.kPrimaryColor,
          //   ),
          // ),
          actions: [
            AnimSearchBar(
              helpText: 'Поиск..',
              Onchaged: () {
                BlocProvider.of<TapeCubit>(context)
                    .tapes(true, false, searchController.text);
              },
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(153, 162, 173, 1)),
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
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      position: PopupMenuPosition.under,
                      offset: const Offset(0, 25),
                      itemBuilder: (BuildContext bc) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              title = 'Подписки';
                              BlocProvider.of<TapeCubit>(context)
                                  .tapes(true, false, null);
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
                              BlocProvider.of<TapeCubit>(context)
                                  .tapes(false, true, null);

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
                            '${title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/icons/down.png',
                            height: 16.5,
                            width: 9.5,
                          )
                        ],
                      ), // Icon(Icons.done,color: AppColors.kPrimaryColor,size: 16,)
                    ),
                  ],
                )
              : null,
        ),
        body: BlocConsumer<TapeCubit, TapeState>(
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
                return GridView.builder(
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
                    return TapeCardWidget(
                      tape: state.tapeModel[index],
                      index: index,
                    );
                  },
                );
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}
