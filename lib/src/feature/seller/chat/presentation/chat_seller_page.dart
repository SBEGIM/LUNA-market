import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/chat/presentation/message_seller_page.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/common/constants.dart';
import '../cubit/chat_seller_cubit.dart';
import '../cubit/chat_seller_state.dart';

@RoutePage()
class ChatSellerPage extends StatefulWidget {
  const ChatSellerPage({super.key});

  @override
  State<ChatSellerPage> createState() => _ChatSellerPageState();
}

class _ChatSellerPageState extends State<ChatSellerPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController searchController = TextEditingController();

  parseDate(date) {
    final dateTimeString = date;
    final dateTime = DateTime.parse(dateTimeString);

    //  final format = DateFormat('dd HH:mm');
    final clockString = DateFormat('H:mm / yy-M-dd').format(dateTime);
    return clockString;
  }

  Future<void> onRefresh() async {
    await BlocProvider.of<ChatSellerCubit>(context).chat();
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await BlocProvider.of<ChatSellerCubit>(context).pagination();
    await Future.delayed(const Duration(milliseconds: 2000));

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    BlocProvider.of<ChatSellerCubit>(context).chat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          // leading: GestureDetector(
          //   onTap: () {
          //     Get.back();
          //   },
          //   child: const Icon(
          //     Icons.arrow_back_ios,
          //     color: AppColors.kPrimaryColor,
          //   ),
          // ),
          title: const Text(
            'Чат',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        body: BlocConsumer<ChatSellerCubit, ChatSellerState>(
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

              if (state is LoadedState) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onLoading: () {
                    onLoading();
                  },
                  onRefresh: () {
                    onRefresh();
                  },
                  child: ListView(
                      // physics: const NeverScrollableScrollPhysics(),
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 46,
                          margin: const EdgeInsets.only(
                              top: 10, left: 16, right: 16),
                          // padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.kBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: searchController,
                            textAlign: TextAlign.start,
                            onChanged: ((value) {
                              BlocProvider.of<ChatSellerCubit>(context)
                                  .searchChats(searchController.text);

                              setState(() {});
                            }),
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(8),
                              //     borderSide: const BorderSide(width: 1)),

                              // prefixIcon: searchController.text.isEmpty
                              //     ? Transform.translate(
                              //         offset: const Offset(0, 0),
                              //         child: const Icon(
                              //           Icons.search,
                              //           color: Colors.grey,
                              //         ),
                              //       )
                              //     : null,

                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8), // регулируем вручную
                                child: Image.asset(
                                  Assets.icons.defaultSearchIcon.path,
                                  scale: 1.9,
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 24,
                                minHeight: 24,
                              ),
                              border:
                                  InputBorder.none, // Remove default underline
                              hintText: 'Поиск',
                              hintStyle: AppTextStyles.size16Weight400
                                  .copyWith(color: AppColors.kGray300),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 11, horizontal: 0),

                              // enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(8),
                              //     borderSide: const BorderSide(
                              //         width: 0.1, color: AppColors.kGray300)),
                              // suffixIcon: IconButton(
                              //     onPressed: () {},
                              //     icon: SvgPicture.asset('assets/icons/back_menu.svg ',
                              //         color: Colors.grey)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 600,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.chat.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.to(MessageSeller(
                                        chatId: state.chat[index].chatId,
                                        userId: state.chat[index].userId,
                                        userName: state.chat[index].name)),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      height: 100,
                                      //  width: 400,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: state
                                                        .chat[index].avatar !=
                                                    null
                                                ? NetworkImage(
                                                    'https://lunamarket.ru/storage/${state.chat[index].avatar}')
                                                : const AssetImage(
                                                        'assets/icons/profile2.png')
                                                    as ImageProvider,
                                            backgroundColor: Colors.grey[100],
                                            radius: 30,
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 20.5),
                                                width: 260,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${state.chat[index].name}',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          ' ${parseDate(state.chat[index].createdAt)}',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        state.chat[index]
                                                                    .countNewMessages !=
                                                                0
                                                            ? Container(
                                                                width: 22,
                                                                height: 22,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 6),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: AppColors
                                                                        .kPrimaryColor),
                                                                child: Text(
                                                                  '${state.chat[index].countNewMessages}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ))
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0, left: 0),
                                                // alignment: Alignment.bottomLeft,
                                                width: 260,
                                                child: Text(
                                                  '${state.chat[index].lastMessage != null ? state.chat[index].lastMessage!.text : ''}',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ]),
                );
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}
