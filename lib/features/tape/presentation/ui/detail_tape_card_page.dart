import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import 'package:haji_market/features/drawer/presentation/widgets/count_zero_dialog.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_check_cubit.dart';
import 'package:haji_market/features/tape/presentation/data/repository/tape_repo.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/subs_cubit.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';
//import 'package:video_player/video_player.dart';
import '../../../chat/presentation/message.dart';
import '../../../drawer/data/bloc/basket_cubit.dart' as basCubit;
import '../../../drawer/data/bloc/favorite_cubit.dart' as favCubit;
import '../../../drawer/presentation/widgets/pre_order_dialog.dart';
import '../data/bloc/tape_cubit.dart' as tapeCubit;
import '../data/bloc/tape_state.dart' as tapeState;

@RoutePage()
class DetailTapeCardPage extends StatefulWidget implements AutoRouteWrapper {
  final int? index;
  final int? tapeId;
  final String? shopName;
  final tapeCubit.TapeCubit tapeBloc;
  const DetailTapeCardPage({required this.index, required this.shopName, Key? key, required this.tapeBloc, this.tapeId})
      : super(key: key);

  @override
  State<DetailTapeCardPage> createState() => _DetailTapeCardPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<tapeCubit.TapeCubit>.value(
          value: tapeBloc,
        ),
        BlocProvider(
          create: (context) => TapeCheckCubit(tapeRepository: TapeRepository()),
        )
      ],
      child: this,
    );
  }
}

class _DetailTapeCardPageState extends State<DetailTapeCardPage> {
  PageController controller = PageController();
  String? title;
  final TextEditingController searchController = TextEditingController();
  bool visible = true;

  // bool? inSub;
  int currentIndex = 0;

  bool stop = false;

  procentPrice(price, compound) {
    var pp = (((price!.toInt() - compound!.toInt()) / price!.toInt()) * 100) as double;
    return pp.toInt();
  }

  @override
  void initState() {
    if (widget.index != null) {
      currentIndex = widget.index!;
      controller = PageController(initialPage: widget.index!);
    }
    final tape = BlocProvider.of<tapeCubit.TapeCubit>(context);
    if (tape.state is tapeState.LoadedState) {
      if ((tape.state as tapeState.LoadedState).tapeModel[currentIndex].tapeId != null) {
        BlocProvider.of<TapeCheckCubit>(context)
            .tapeCheck(tapeId: (tape.state as tapeState.LoadedState).tapeModel[currentIndex].tapeId!);
      }
    }
    title = 'Лента';
    // GetStorage().write('title_tape', 'Отписаться');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // excludeHeaderSemantics: true,

          leading: visible == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomBackButton(onTap: () {
                    context.router.pop();
                  }),
                )
              : null,
          toolbarHeight: 26,
          actions: [
            BlocBuilder<tapeCubit.TapeCubit, tapeState.TapeState>(
              builder: (context, state) {
                if (state is tapeState.LoadedState) {
                  return BlocConsumer<TapeCheckCubit, TapeCheckState>(
                    listener: (context, stateCheck) {
                      if (stateCheck is LoadedState) {
                        log(state.tapeModel[currentIndex].tapeId.toString());
                        BlocProvider.of<tapeCubit.TapeCubit>(context).updateTapeByIndex(
                            index: currentIndex,
                            updatedTape: state.tapeModel[currentIndex].copyWith(
                                tapeId: state.tapeModel[currentIndex].tapeId,
                                inBasket: stateCheck.tapeCheckModel.inBasket,
                                inSubscribe: stateCheck.tapeCheckModel.inSubs));
                      }
                    },
                    builder: (context, stateCheck) => GestureDetector(
                      onTap: () async {
                        // if (GetStorage().read('title_tape').toString() ==
                        //     'Отписаться') {
                        //   GetStorage().write('title_tape', 'Подписаться');
                        // } else {
                        //   GetStorage().write('title_tape', 'Отписаться');
                        // }

                        BlocProvider.of<SubsCubit>(context).sub(state.tapeModel[currentIndex].blogger?.id.toString());

                        await BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                            state.tapeModel[currentIndex],
                            currentIndex,
                            !(state.tapeModel[currentIndex].inSubscribe ?? true),
                            state.tapeModel[currentIndex].inBasket,
                            state.tapeModel[currentIndex].inFavorite,
                            state.tapeModel[currentIndex].inReport);

                        setState(() {
                          // inSub = !(state.tapeModel[currentIndex].inSubscribe ??
                          //     true);
                        });
                      },
                      child: Container(
                        height: 26,
                        width: 98,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 0.3,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        child: Text(
                          stateCheck is LoadingState
                              ? ''
                              : state.tapeModel[currentIndex].inSubscribe == true
                                  ? 'Отписаться'
                                  : 'Подписаться',
                          style: const TextStyle(color: AppColors.kPrimaryColor, fontSize: 12),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
          centerTitle: true,
          title: BlocBuilder<tapeCubit.TapeCubit, tapeState.TapeState>(
            builder: (context, state) {
              if (state is tapeState.LoadedState) {
                return visible == true && (state.tapeModel[currentIndex].blogger != null)
                    ? GestureDetector(
                        onTap: () {
                          context.router
                              .push(ProfileBloggerTapeRoute(
                            bloggerAvatar: state.tapeModel[currentIndex].blogger?.image ?? '',
                            bloggerId: state.tapeModel[currentIndex].blogger!.id!,
                            bloggerName: state.tapeModel[currentIndex].blogger?.nickName ?? '',
                            inSubscribe: state.tapeModel[currentIndex].inSubscribe ?? false,
                            onSubChanged: (value) {
                              BlocProvider.of<tapeCubit.TapeCubit>(context).updateTapeByIndex(
                                  index: currentIndex,
                                  updatedTape: state.tapeModel[currentIndex]
                                      .copyWith(tapeId: state.tapeModel[currentIndex].tapeId, inSubscribe: value));
                            },
                          ))
                              .whenComplete(() {
                            stop = false;
                            BlocProvider.of<tapeCubit.TapeCubit>(context).toLoadedState();
                            setState(() {});
                          });
                          stop = true;
                        },
                        child: Text(
                          '${state.tapeModel[currentIndex].blogger?.nickName}',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                        ))
                    : const SizedBox();
              }
              return const SizedBox();
            },
          ),

          // ? Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       PopupMenuButton(
          //         color: const Color.fromRGBO(230, 231, 232, 1),
          //         shape: const RoundedRectangleBorder(
          //             borderRadius:
          //                 BorderRadius.all(Radius.circular(15.0))),
          //         position: PopupMenuPosition.under,
          //         offset: const Offset(0, 25),
          //         itemBuilder: (BuildContext bc) {
          //           return [
          //             PopupMenuItem(
          //               onTap: () {
          //                 title = 'Подписки';
          //                 BlocProvider.of<tapeCubit.TapeCubit>(context)
          //                     .tapes(true, false, null);
          //                 setState(() {});
          //               },
          //               value: 0,
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   const Text(
          //                     "Подписки",
          //                     style: TextStyle(color: Colors.black),
          //                   ),
          //                   SvgPicture.asset('assets/icons/lenta1.svg'),
          //                 ],
          //               ),
          //             ),
          //             PopupMenuItem(
          //               onTap: () {
          //                 BlocProvider.of<tapeCubit.TapeCubit>(context)
          //                     .tapes(false, true, null);

          //                 title = 'Избранное';
          //                 setState(() {});
          //               },
          //               value: 1,
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   const Text("Избранное"),
          //                   SvgPicture.asset('assets/icons/lenta2.svg'),
          //                 ],
          //               ),
          //             ),
          //           ];
          //         },
          //         child: Row(
          //           children: [
          //             Text(
          //               '${title}',
          //               textAlign: TextAlign.center,
          //               style: const TextStyle(
          //                   color: AppColors.kGray900,
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //             const SizedBox(width: 5),
          //             Image.asset(
          //               'assets/icons/down.png',
          //               height: 16.5,
          //               width: 9.5,
          //             )
          //           ],
          //         ), // Icon(Icons.done,color: AppColors.kPrimaryColor,size: 16,)
          //       ),
          //     ],
          //   )
          // : null,
        ),
        body: BlocConsumer<tapeCubit.TapeCubit, tapeState.TapeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is tapeState.ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is tapeState.LoadingState) {
                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
              }

              if (state is tapeState.LoadedState) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  itemCount: state.tapeModel.length,
                  onPageChanged: (value) {
                    currentIndex = value;
                    if (state.tapeModel[value].tapeId != null) {
                      BlocProvider.of<TapeCheckCubit>(context).tapeCheck(tapeId: state.tapeModel[value].tapeId!);
                    }
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    // inFavorite = state.tapeModel[index].inFavorite;
                    // inBasket = state.tapeModel[index].inBasket;
                    return Stack(
                      children: [
                        //VideoPlayer(_controller!)5,
                        Videos(tape: state.tapeModel[index]),
                        // Image.network(
                        //   'http://80.87.202.73:8001/storage/${widget.tape.image}',
                        //   fit: BoxFit.cover,
                        //   height: double.infinity,
                        //   width: double.infinity,
                        //   alignment: Alignment.center,
                        // ),

                        Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Column(
                              //   children: [
                              Container(
                                width: 61,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(6)),
                                margin: const EdgeInsets.only(top: 105),
                                alignment: Alignment.center,
                                child: const Text(
                                  '0·0·12',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                                ),
                              ),
                              state.tapeModel[index].point != 0
                                  ? Container(
                                      decoration:
                                          BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6)),
                                      // padding: const EdgeInsets.only(
                                      //     left: 4, right: 4, bottom: 2, top: 2),
                                      // margin: const EdgeInsets.only(top: 370),
                                      width: 56,
                                      height: 28,
                                      margin: const EdgeInsets.only(top: 4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${state.tapeModel[index].point}% Б',
                                        style: const TextStyle(
                                            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 28,
                                    ),

                              state.tapeModel[index].compound != 0
                                  ? Container(
                                      decoration:
                                          BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                                      // padding: const EdgeInsets.only(
                                      //     left: 4, right: 4, bottom: 2, top: 2),
                                      // margin: const EdgeInsets.only(top: 370),
                                      width: 48,
                                      height: 28,
                                      margin: const EdgeInsets.only(top: 4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '-${state.tapeModel[index].compound}%',
                                        style: const TextStyle(
                                            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 28,
                                    ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Column(
                                  //   children: [
                                  // Container(
                                  //   width: 61,
                                  //   height: 28,
                                  //   decoration: BoxDecoration(
                                  //       color: AppColors.kPrimaryColor,
                                  //       borderRadius:
                                  //           BorderRadius.circular(6)),
                                  //   margin: const EdgeInsets.only(top: 370),
                                  //   alignment: Alignment.center,
                                  //   child: const Text(
                                  //     '0·0·12',
                                  //     style: TextStyle(
                                  //         fontSize: 14,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: Colors.white),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.black,
                                  //       borderRadius:
                                  //           BorderRadius.circular(6)),
                                  //   // padding: const EdgeInsets.only(
                                  //   //     left: 4, right: 4, bottom: 2, top: 2),
                                  //   margin: const EdgeInsets.only(top: 370),
                                  //   width: 56,
                                  //   height: 28,
                                  //   // margin: const EdgeInsets.only(top: 4),
                                  //   alignment: Alignment.center,
                                  //   child: const Text(
                                  //     '10% Б',
                                  //     style: TextStyle(
                                  //         fontSize: 12,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: Colors.white),
                                  //   ),
                                  // ),
                                  //   ],
                                  // ),
                                  Container(
                                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.32),
                                    child: Column(
                                      children: [
                                        inReport(
                                          tape: state.tapeModel[index],
                                          index: index,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        inBaskets(
                                          tape: state.tapeModel[index],
                                          index: index,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        inFavorites(
                                          tape: state.tapeModel[index],
                                          index: index,
                                          isBlogger: false,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Share.share(
                                                "$kDeepLinkUrl/?index\u003d${widget.index}&shop_name\u003d${widget.shopName}");
                                          },
                                          child: SvgPicture.asset(
                                            'assets/icons/share.svg',
                                            height: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                //width: 358,
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // if (state.tapeModel[index].blogger != null)
                                    //   GestureDetector(
                                    //     onTap: () {
                                    //       BlocProvider.of<NavigationCubit>(context).emit(DetailBloggerTapeState(
                                    //           state.tapeModel[index].blogger!.id!,
                                    //           state.tapeModel[index].blogger?.nickName ?? '',
                                    //           state.tapeModel[index].blogger?.image ?? ''));
                                    //     },
                                    //     child: Row(
                                    //       children: [
                                    //         ClipRRect(
                                    //           borderRadius: BorderRadius.circular(5),
                                    //           child: state.tapeModel[index].blogger?.image != null
                                    //               ? Image.network(
                                    //                   'http://185.116.193.73/storage/${state.tapeModel[index].blogger?.image}',
                                    //                   height: 30.6,
                                    //                   width: 30.6,
                                    //                 )
                                    //               : const Icon(Icons.person),
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 8,
                                    //         ),
                                    //         Text(
                                    //           '${state.tapeModel[index].blogger?.nickName}',
                                    //           style: const TextStyle(
                                    //               color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   )
                                    // else
                                    GestureDetector(
                                      onTap: (() {
                                        final List<int> selectedListSort = [];

                                        selectedListSort.add(state.tapeModel[index].shop!.id!);
                                        GetStorage().write('shopFilterId', selectedListSort.toString());

                                        context.router.push(ProductsRoute(
                                          cats: Cats(id: 0, name: ''),
                                          shopId: state.tapeModel[index].shop!.id.toString(),
                                        ));
                                      }),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.network(
                                              'http://185.116.193.73/storage/${state.tapeModel[index].shop!.image}',
                                              height: 30.6,
                                              width: 30.6,
                                              errorBuilder: (context, error, stackTrace) => const ErrorImageWidget(
                                                height: 30.6,
                                                width: 30.6,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${state.tapeModel[index].shop!.name}',
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // inSubs(
                                        //   tape: state.tapeModel[index],
                                        //   index: index,
                                        // ),
                                        // SvgPicture.asset(
                                        //   'assets/icons/notification.svg',
                                        //   color: Colors.white,
                                        // ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print(' chat:::${state.tapeModel[index].chatId}');
                                            // Get.off(ChatPage);
                                            GetStorage().write('video_stop', true);

                                            // if (state.tapeModel[index].chatId ==
                                            //     null) {
                                            Get.to(MessagePage(
                                                userId: state.tapeModel[index].shop!.id,
                                                name: state.tapeModel[index].shop!.name,
                                                avatar: state.tapeModel[index].shop!.image,
                                                chatId: state.tapeModel[index].chatId));
                                            // } else {
                                            //   Get.to(() => const ChatPage());
                                            // }

                                            // Get.to(ProductsPage(
                                            //   cats: Cats(id: 0, name: ''),
                                            // ));
                                            // GetStorage()
                                            //     .write('shopFilterId', 1);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 108,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.circular(8)),
                                            // padding: const EdgeInsets.only(
                                            //     left: 8,
                                            //     right: 8,
                                            //     top: 4,
                                            //     bottom: 4),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Написать',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 7.4,
                              ),
                              SizedBox(
                                width: 358,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      '${state.tapeModel[index].name}',
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     inBaskets(
                                    //       tape: state.tapeModel[index],
                                    //       index: index,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     inFavorites(
                                    //       tape: state.tapeModel[index],
                                    //       index: index,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     SvgPicture.asset(
                                    //       'assets/icons/share.svg',
                                    //       color: Colors.white,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              // Text(
                              //   'Артикул: ${state.tapeModel[index].id}',
                              //   style: const TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w500,
                              //       color: Colors.white),
                              // ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                // width: 358,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${(state.tapeModel[index].price!.toInt() - ((state.tapeModel[index].price! / 100) * state.tapeModel[index].compound!).toInt())} ₽ ',
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${state.tapeModel[index].price} ₽',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              decoration: TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'в рассрочку',
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                4,
                                              ),
                                              color: const Color(
                                                0x30FFFFFF,
                                              )),
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            '${(state.tapeModel[index].price!.toInt() - ((state.tapeModel[index].price! / 100) * state.tapeModel[index].compound!).toInt()) ~/ 3}',
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Text(
                                          'х3',
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              }
              if (state is tapeState.BloggerLoadedState) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  itemCount: state.tapeModel.length,
                  onPageChanged: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    // inFavorite = state.tapeModel[index].inFavorite;
                    // inBasket = state.tapeModel[index].inBasket;
                    return Stack(
                      children: [
                        //VideoPlayer(_controller!)5,
                        Videos(
                          tape: state.tapeModel[index],
                          stop: stop,
                        ),
                        // Image.network(
                        //   'http://80.87.202.73:8001/storage/${widget.tape.image}',
                        //   fit: BoxFit.cover,
                        //   height: double.infinity,
                        //   width: double.infinity,
                        //   alignment: Alignment.center,
                        // ),

                        Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 61,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(6)),
                                margin: const EdgeInsets.only(top: 130),
                                alignment: Alignment.center,
                                child: const Text(
                                  '0·0·12',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                                ),
                              ),
                              state.tapeModel[index].point != 0
                                  ? Container(
                                      decoration:
                                          BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6)),
                                      // padding: const EdgeInsets.only(
                                      //     left: 4, right: 4, bottom: 2, top: 2),
                                      margin: const EdgeInsets.only(top: 10),
                                      width: 56,
                                      height: 28,
                                      // margin: const EdgeInsets.only(top: 4),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '10% Б',
                                        style:
                                            TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 28,
                                    ),

                              state.tapeModel[index].compound != 0
                                  ? Container(
                                      decoration:
                                          BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                                      // padding: const EdgeInsets.only(
                                      //     left: 4, right: 4, bottom: 2, top: 2),
                                      // margin: const EdgeInsets.only(top: 370),
                                      width: 48,
                                      height: 28,
                                      margin: const EdgeInsets.only(top: 4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '-${state.tapeModel[index].compound}%',
                                        style: const TextStyle(
                                            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 28,
                                    ),

                              // Container(
                              //   width: 49,
                              //   height: 28,
                              //   decoration: BoxDecoration(
                              //       color: const Color(0xFFFF3347), borderRadius: BorderRadius.circular(6)),
                              //   margin: EdgeInsets.only(
                              //     top: MediaQuery.of(context).size.height * 0.15,
                              //   ),
                              //   alignment: Alignment.center,
                              //   child: Text(
                              //     '-${state.tapeModel[index].compound}%',
                              //     style:
                              //         const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.26),
                                    child: Column(
                                      children: [
                                        inReport(
                                          tape: state.tapeModel[index],
                                          index: index,
                                          isBlogger: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        inBaskets(
                                          tape: state.tapeModel[index],
                                          index: index,
                                          isBlogger: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        inFavorites(
                                          tape: state.tapeModel[index],
                                          index: index,
                                          isBlogger: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Share.share(
                                                "$kDeepLinkUrl/?index\u003d${widget.index}&shop_name\u003d${widget.shopName}");
                                          },
                                          child: SvgPicture.asset(
                                            'assets/icons/share.svg',
                                            height: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                //width: 358,
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // if (state.tapeModel[index].blogger != null)
                                    //   GestureDetector(
                                    //     onTap: () {
                                    //       BlocProvider.of<NavigationCubit>(context).emit(DetailBloggerTapeState(
                                    //           state.tapeModel[index].blogger!.id!,
                                    //           state.tapeModel[index].blogger?.nickName ?? '',
                                    //           state.tapeModel[index].blogger?.image ?? ''));
                                    //     },
                                    //     child: Row(
                                    //       children: [
                                    //         ClipRRect(
                                    //           borderRadius: BorderRadius.circular(5),
                                    //           child: state.tapeModel[index].blogger?.image != null
                                    //               ? Image.network(
                                    //                   'http://185.116.193.73/storage/${state.tapeModel[index].blogger?.image}',
                                    //                   height: 30.6,
                                    //                   width: 30.6,
                                    //                 )
                                    //               : const Icon(Icons.person),
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 8,
                                    //         ),
                                    //         Text(
                                    //           '${state.tapeModel[index].blogger?.nickName}',
                                    //           style: const TextStyle(
                                    //               color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   )
                                    // else
                                    GestureDetector(
                                      onTap: (() {
                                        final List<int> selectedListSort = [];

                                        selectedListSort.add(state.tapeModel[index].shop!.id!);
                                        GetStorage().write('shopFilterId', selectedListSort.toString());

                                        context.router.push(ProductsRoute(
                                          cats: Cats(id: 0, name: ''),
                                          shopId: state.tapeModel[index].shop!.id.toString(),
                                        ));
                                      }),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.network(
                                              'http://185.116.193.73/storage/${state.tapeModel[index].shop!.image}',
                                              height: 30.6,
                                              width: 30.6,
                                              errorBuilder: (context, error, stackTrace) => const ErrorImageWidget(
                                                height: 30.6,
                                                width: 30.6,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${state.tapeModel[index].shop!.name}',
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // inSubs(
                                        //   tape: state.tapeModel[index],
                                        //   index: index,
                                        // ),
                                        // SvgPicture.asset(
                                        //   'assets/icons/notification.svg',
                                        //   color: Colors.white,
                                        // ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Get.off(ChatPage);
                                            GetStorage().write('video_stop', true);

                                            // if (state.tapeModel[index].chatId ==
                                            //     null) {
                                            Get.to(MessagePage(
                                                userId: state.tapeModel[index].shop!.id,
                                                name: state.tapeModel[index].shop!.name,
                                                avatar: state.tapeModel[index].shop!.image,
                                                chatId: state.tapeModel[index].chatId));
                                            // } else {
                                            //   Get.to(() => const ChatPage());
                                            // }

                                            // Get.to(ProductsPage(
                                            //   cats: Cats(id: 0, name: ''),
                                            // ));
                                            // GetStorage()
                                            //     .write('shopFilterId', 1);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 108,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.circular(8)),
                                            // padding: const EdgeInsets.only(
                                            //     left: 8,
                                            //     right: 8,
                                            //     top: 4,
                                            //     bottom: 4),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Написать',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 7.4,
                              ),
                              SizedBox(
                                width: 358,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      '${state.tapeModel[index].name}',
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     inBaskets(
                                    //       tape: state.tapeModel[index],
                                    //       index: index,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     inFavorites(
                                    //       tape: state.tapeModel[index],
                                    //       index: index,
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     SvgPicture.asset(
                                    //       'assets/icons/share.svg',
                                    //       color: Colors.white,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              // Text(
                              //   'Артикул: ${state.tapeModel[index].id}',
                              //   style: const TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w500,
                              //       color: Colors.white),
                              // ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                // width: 358,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${(state.tapeModel[index].price!.toInt() - ((state.tapeModel[index].price! / 100) * state.tapeModel[index].compound!).toInt())} ₽ ',
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${state.tapeModel[index].price} ₽',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              decoration: TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'в рассрочку',
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                4,
                                              ),
                                              color: const Color(
                                                0x30FFFFFF,
                                              )),
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            '${(state.tapeModel[index].price!.toInt() - ((state.tapeModel[index].price! / 100) * state.tapeModel[index].compound!).toInt()) ~/ 3}',
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Text(
                                          'х3',
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}

class Videos extends StatefulWidget {
  final TapeModel tape;
  final bool? stop;
  const Videos({required this.tape, super.key, this.stop});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  VideoPlayerController? _controller;
  bool icon = true;

  Function? videoStop;

  @override
  void initState() {
    _controller = VideoPlayerController.network("http://185.116.193.73/storage/${widget.tape.video}")
      ..initialize().then((_) {
        if (widget.stop == true) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
        setState(() {});
      });

    _controller!.addListener(() {
      _controller!.value.isPlaying == true ? icon = false : icon = true;

      setState(() {});
    });

    videoStop = GetStorage().listenKey('video_stop', (value) {
      if (value == true) {
        _controller!.pause();
      }
    });

    BlocProvider.of<tapeCubit.TapeCubit>(context).view(widget.tape.tapeId!);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    videoStop?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller!.value.isInitialized
        ? Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  child: GestureDetector(
                      onTap: () {
                        _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                      },
                      child: SizedBox(
                          height: _controller?.value.size.height,
                          width: _controller?.value.size.width,
                          child: AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VisibilityDetector(
                                  key: ObjectKey(_controller),
                                  onVisibilityChanged: (info) {
                                    if (!mounted) return;
                                    if (info.visibleFraction == 0) {
                                      _controller?.pause(); //pausing  functionality
                                    } else {
                                      _controller?.play();
                                    }
                                  },
                                  child: VideoPlayer(_controller!))))),
                ),
              ),
              icon
                  ? GestureDetector(
                      onTap: () {
                        _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                      },
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/icons/play_tape.svg',
                        color: const Color.fromRGBO(29, 196, 207, 1),
                      )),
                    )
                  : Container(),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.11),
                child: VideoProgressIndicator(_controller!, allowScrubbing: true),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
  }
}

class inSubs extends StatefulWidget {
  final TapeModel tape;
  final int index;
  const inSubs({required this.tape, required this.index, super.key});

  @override
  State<inSubs> createState() => _inSubsState();
}

class _inSubsState extends State<inSubs> {
  bool? inSub;

  @override
  void initState() {
    inSub = widget.tape.inSubscribe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        BlocProvider.of<SubsCubit>(context).sub(widget.tape.shop!.id.toString());

        //widget.tape.inSubscribe = false;
        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
          widget.tape,
          widget.index,
          !inSub!,
          widget.tape.inBasket,
          widget.tape.inFavorite,
          widget.tape.inReport,
        );

        setState(() {
          inSub = !inSub!;
        });
      },
      child: SvgPicture.asset(
        inSub != true ? 'assets/icons/notification.svg' : 'assets/icons/notification2.svg',
        height: 20,
        width: 20,
        color: Colors.white,
      ),
    );
  }
}

class inFavorites extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inFavorites({required this.tape, required this.index, super.key, required this.isBlogger});

  @override
  State<inFavorites> createState() => _inFavoritesState();
}

class _inFavoritesState extends State<inFavorites> {
  bool? inFavorite;

  @override
  void initState() {
    inFavorite = widget.tape.inFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final favorite = BlocProvider.of<favCubit.FavoriteCubit>(context);
        await favorite.favoriteTape(widget.tape.tapeId.toString());
        BlocProvider.of<tapeCubit.TapeCubit>(context).update(widget.tape, widget.index, widget.tape.inSubscribe,
            widget.tape.inBasket, !inFavorite!, widget.tape.inReport,
            isBlogger: widget.isBlogger);

        inFavorite = !inFavorite!;

        setState(() {});
      },
      child: SvgPicture.asset(
        inFavorite == false ? 'assets/icons/save_tape.svg' : 'assets/icons/save_tape_full.svg',
        height: 30,
        colorBlendMode: BlendMode.colorDodge,
      ),
    );
  }
}

class inBaskets extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inBaskets({required this.tape, required this.index, super.key, this.isBlogger = false});

  @override
  State<inBaskets> createState() => _inBasketsState();
}

class _inBasketsState extends State<inBaskets> {
  bool? inBasket;

  @override
  void initState() {
    inBasket = widget.tape.inBasket;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<tapeCubit.TapeCubit, tapeState.TapeState>(
      builder: (context, state) {
        if (state is tapeState.LoadedState) {
          return GestureDetector(
            onTap: () {
              if (widget.tape.count == 0 && widget.tape.preOrder == 1) {
                showCupertinoModalPopup<void>(
                    context: context,
                    builder: (context) => PreOrderDialog(onYesTap: () {
                          state.tapeModel[widget.index].inBasket == false
                              ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                                  widget.tape.id.toString(), '1', 0, '', '',
                                  blogger_id: widget.tape.blogger?.id.toString() ?? '0')
                              : BlocProvider.of<basCubit.BasketCubit>(context)
                                  .basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

                          BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                              widget.tape,
                              widget.index,
                              widget.tape.inSubscribe,
                              !state.tapeModel[widget.index].inBasket!,
                              widget.tape.inFavorite,
                              widget.tape.inReport,
                              isBlogger: widget.isBlogger);
                          setState(
                            () {
                              inBasket = !inBasket!;
                            },
                          );

                          Get.back();
                        }));
              } else if (widget.tape.count == 0) {
                showCupertinoModalPopup<void>(
                    context: context,
                    builder: (context) => CountZeroDialog(onYesTap: () {
                          state.tapeModel[widget.index].inBasket == false
                              ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                                  widget.tape.id.toString(), '1', 0, '', '',
                                  blogger_id: widget.tape.blogger?.id.toString() ?? '0')
                              : BlocProvider.of<basCubit.BasketCubit>(context)
                                  .basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

                          BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                              widget.tape,
                              widget.index,
                              widget.tape.inSubscribe,
                              !state.tapeModel[widget.index].inBasket!,
                              widget.tape.inFavorite,
                              widget.tape.inReport,
                              isBlogger: widget.isBlogger);
                          setState(
                            () {
                              inBasket = !inBasket!;
                            },
                          );
                        }));
              } else {
                state.tapeModel[widget.index].inBasket == false
                    ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                        widget.tape.id.toString(), '1', 0, '', '',
                        blogger_id: widget.tape.blogger?.id.toString() ?? '0')
                    : BlocProvider.of<basCubit.BasketCubit>(context)
                        .basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

                BlocProvider.of<tapeCubit.TapeCubit>(context).update(widget.tape, widget.index, widget.tape.inSubscribe,
                    !state.tapeModel[widget.index].inBasket!, widget.tape.inFavorite, widget.tape.inReport,
                    isBlogger: widget.isBlogger);
                setState(
                  () {
                    inBasket = !inBasket!;
                  },
                );
                Get.back();

                // this.context.router.pushAndPopUntil(
                //       const LauncherRoute(children: [BasketRoute()]),
                //       predicate: (route) => false,
                //     );
              }
            },
            child: SvgPicture.asset(
              state.tapeModel[widget.index].inBasket != true
                  ? 'assets/icons/shop_cart.svg'
                  : 'assets/icons/shop_cart_white.svg',

              height: state.tapeModel[widget.index].inBasket != true ? 30 : 25,
              //  color: inBasket == true ? const Color.fromRGBO(255, 50, 72, 1) : null,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              inBasket == false
                  ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(widget.tape.id.toString(), '1', 0, '', '',
                      blogger_id: widget.tape.blogger?.id.toString() ?? '0')
                  : BlocProvider.of<basCubit.BasketCubit>(context)
                      .basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

              BlocProvider.of<tapeCubit.TapeCubit>(context).update(widget.tape, widget.index, widget.tape.inSubscribe,
                  !inBasket!, widget.tape.inFavorite, widget.tape.inReport,
                  isBlogger: widget.isBlogger);
              setState(
                () {
                  inBasket = !inBasket!;
                },
              );
            },
            child: SvgPicture.asset(
              inBasket != true ? 'assets/icons/shop_cart.svg' : 'assets/icons/shop_cart_white.svg',
              height: inBasket != true ? 30 : 25,
              //  color: inBasket == true ? const Color.fromRGBO(255, 50, 72, 1) : null,
            ),
          );
        }
      },
    );
  }
}

class inReport extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inReport({required this.tape, required this.index, super.key, this.isBlogger = false});

  @override
  State<inReport> createState() => _inReportState();
}

class _inReportState extends State<inReport> {
  bool? inReport;

  @override
  void initState() {
    inReport = widget.tape.inBasket;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // inReport == false
        //     ? BlocProvider.of<basCubit.BasketCubit>(context)
        //         .basketAdd(widget.tape.id.toString(), '1')
        //     : BlocProvider.of<basCubit.BasketCubit>(context)
        //         .basketMinus(widget.tape.id.toString(), '1');

        showAlertTapeWidget(context);

        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
          widget.tape,
          widget.index,
          widget.tape.inSubscribe,
          widget.tape.inBasket,
          widget.tape.inFavorite,
          !inReport!,
          isBlogger: widget.isBlogger,
        );
        setState(() {
          inReport = !inReport!;
        });
      },
      child: SvgPicture.asset(
        'assets/icons/report.svg',
        color: inReport != true ? AppColors.kPrimaryColor : null,
        height: 30,
        //  color: inBasket == true ? const Color.fromRGBO(255, 50, 72, 1) : null,
      ),
    );
  }
}

Future<dynamic> showAlertTapeWidget(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Жестокое обращение с детьми',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Жестокое обращение с детьми", backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Спам',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Спам", backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Вредные или опасные действия',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Вредные или опасные действия", backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Жестокое или отталкивающее содержание',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Жестокое или отталкивающее содержание",
                backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Дискриминационные высказывание и оскорбления',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Дискриминационные высказывание и оскорбления",
                backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        // CupertinoActionSheetAction(
        //   child: const Text(
        //     'Пожаловаться',
        //     style: TextStyle(color: Colors.red),
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context, 'Two');
        //   },
        // ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Отмена',
          style: TextStyle(
            color: AppColors.kPrimaryColor,
          ),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
