import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haji_market/features/chat/data/cubit/chat_cubit.dart';
import 'package:haji_market/features/chat/data/cubit/chat_state.dart';
import 'package:haji_market/features/chat/presentation/message.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:web_socket_channel/io.dart';

import '../../../core/common/constants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  TextEditingController searchController = TextEditingController();

  TextEditingController _chatTextController = TextEditingController();

  parseDate(date) {
    final dateTimeString = date;
    final dateTime = DateTime.parse(dateTimeString);

    //  final format = DateFormat('dd HH:mm');
    final clockString = DateFormat('H:mm / yy-M-dd').format(dateTime);
    return clockString;
  }

  Future<void> onRefresh() async {
    await BlocProvider.of<ChatCubit>(context).chat();
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await BlocProvider.of<ChatCubit>(context).pagination();
    await Future.delayed(Duration(milliseconds: 2000));

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).chat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
          ),
          title: const Text(
            'Сообщение',
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        body: BlocConsumer<ChatCubit, ChatState>(
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
                return ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.text,
                          controller: searchController,
                          onChanged: ((value) {
                            setState(() {});
                          }),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(width: 1)),

                            prefixIcon: searchController.text.isEmpty
                                ? Transform.translate(
                                    offset: const Offset(5, 0),
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  )
                                : null,
                            hintText: 'Поиск',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 0.3, color: Colors.grey)),
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
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: false,
                          enablePullUp: true,
                          onLoading: () {
                            onLoading();
                          },
                          onRefresh: () {
                            onRefresh();
                          },
                          child: ListView.builder(
                            itemCount: state.chat.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.to(MessagePage(
                                      userId: state.chat[index].userId,
                                      name: state.chat[index].name!,
                                      avatar: state.chat[index].avatar,
                                      chatId: state.chat[index].chatId,
                                    )),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      height: 80,
                                      //  width: 400,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: state.chat[index].avatar != null
                                                ? NetworkImage(
                                                    'http://185.116.193.73/storage/${state.chat[index].avatar}')
                                                : null,
                                            backgroundColor: Colors.grey.withOpacity(0.3),
                                            radius: 30,
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(top: 20.5),
                                                width: 275,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${state.chat[index].name}',
                                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                    ),
                                                    Text(
                                                      ' ${parseDate(state.chat[index].createdAt)}',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(top: 20.5, left: 0),
                                                // alignment: Alignment.bottomLeft,
                                                width: 275,
                                                child: Text(
                                                  '${state.chat[index].lastMessage != null ? state.chat[index].lastMessage!.text : ''}',
                                                  style: const TextStyle(
                                                      color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (state.chat.length - 1 != index)
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: const Divider(
                                        height: 5,
                                        color: AppColors.kGray400,
                                      ),
                                    )
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ]);
              } else {
                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}
