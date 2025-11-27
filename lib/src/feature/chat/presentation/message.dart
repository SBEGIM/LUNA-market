import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/chat/data/DTO/message_dto.dart';
import 'package:haji_market/src/feature/chat/data/cubit/chat_cubit.dart';
import 'package:haji_market/src/feature/chat/data/cubit/message_cubit.dart';
import 'package:haji_market/src/feature/chat/data/cubit/message_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../data/DTO/messageDto.dart';

class MessagePage extends StatefulWidget {
  String? name;
  int? userId;
  String? avatar;
  int? chatId;

  MessagePage({required this.userId, this.name, required this.avatar, this.chatId, super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;

  Future<void> _getImage() async {
    _image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   _image = image;
    // })

    //_image = image;

    final chat = BlocProvider.of<MessageCubit>(context);

    String? data = await chat.imageStore(_image != null ? _image?.path ?? '' : "");

    String text = jsonEncode({
      'action': 'file',
      'text': null,
      'path': data,
      'type': 'image',
      'to': widget.userId,
      'chat_id': widget.chatId,
    });

    channel.sink.add(text);
  }

  late WebSocketChannel channel;

  final TextEditingController _chatTextController = TextEditingController();
  final RefreshController _refreshController = RefreshController();

  void SendData() {
    if (_chatTextController.text.isNotEmpty) {
      String text = jsonEncode({
        'action': 'message',
        'text': _chatTextController.text.toString(),
        'to': widget.userId,
        'chat_id': widget.chatId,
      });

      channel.sink.add(text);
      // BlocProvider.of<MessageCubit>(context)
      //       .newMessage(MessageDto.fromJson(data));
      _chatTextController.clear();
      // channel.sink.
    }
  }

  messageDTO? messageText;
  String myId = GetStorage().read('user_id');

  bool ready = false;

  final GroupedItemScrollController itemScrollController = GroupedItemScrollController();

  // Future<void> onRefresh() async {
  //   channel.sink.close();
  //   print('oksss');
  //   await BlocProvider.of<MessageCubit>(context).getMessage();
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   //  channel.sink.close();

  //   _refreshController.refreshCompleted();
  // }

  Future<void> onLoading() async {
    await BlocProvider.of<MessageCubit>(
      context,
    ).paginationMessage(widget.chatId ?? 0, widget.userId ?? 0);
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.loadComplete();
  }
  // void scrollDown() {
  //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
  // }

  @override
  void dispose() {
    channel.sink.close();
    _chatTextController.clear();
    _chatTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<MessageCubit>(context).getMessage(widget.chatId ?? 0, widget.userId ?? 0);
    channel = IOWebSocketChannel.connect("ws://lunamarket.ru:1995/?user_id=$myId");

    channel.ready.then((value) {
      ready = true;
      setState(() {});

      String text = jsonEncode({'action': 'read', 'chat_id': widget.chatId});
      channel.sink.add(text);
    });

    channel.stream.listen((event) {
      final data = jsonDecode(event);
      if (data['action'] == 'ping') {
        String text = jsonEncode({'action': 'pong'});
        channel.sink.add(text);

        text = jsonEncode({'action': 'read', 'chat_id': widget.chatId});
        channel.sink.add(text);
      }

      if (data['action'] == 'message' || data['action'] == 'file') {
        log(data.toString());
        BlocProvider.of<MessageCubit>(context).newMessage(MessageDto.fromJson(data));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            BlocProvider.of<ChatCubit>(context).chat();

            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios, color: AppColors.kPrimaryColor),
        ),
        centerTitle: false,
        title: Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: widget.avatar != null
                    ? NetworkImage('https://lunamarket.ru/storage/${widget.avatar}')
                    : null,
                backgroundColor: Colors.grey,
                radius: 16,
              ),
              const SizedBox(width: 8),
              Text(widget.name ?? 'Чат', style: const TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
      body: BlocConsumer<MessageCubit, MessageState>(
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
            // state.chat.forEach((element) {
            //   return chat.add(element);
            // });
            if (ready) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: false,
                      enablePullUp: true,
                      reverse: false,
                      onLoading: () {
                        onLoading();
                      },
                      // onRefresh: () {
                      //   onRefresh();
                      // },
                      child: GroupedListView<MessageDto, DateTime>(
                        elements: state.chat,
                        groupBy: (message) => DateTime(
                          (message.createdAt ?? DateTime.now()).year,
                          (message.createdAt ?? DateTime.now()).month,
                          (message.createdAt ?? DateTime.now()).day,
                        ),
                        reverse: true,
                        sort: false,
                        floatingHeader: true,
                        // itemScrollController: itemScrollController,
                        // sort: false,

                        // initialScrollIndex: 1,
                        // elementIdentifier: (element) => element.
                        //     , // optional - see below for usage
                        // optional
                        // order: StickyGroupedListOrder.DESC, // optional
                        // reverse: true,
                        groupSeparatorBuilder: (DateTime element) => Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          alignment: Alignment.center,
                          height: 20,
                          child: Text(
                            DateFormat("dd.MM.yyyy").format(element),
                            // element.createdAt ?? '01.01.2023 00:00:00',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        itemBuilder: (context, dynamic element) => Align(
                          alignment: element.userId != int.parse(myId)
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
                            color: element.userId == int.parse(myId)
                                ? Colors.white
                                : AppColors.kPrimaryColor,
                            child: element.type == 'message'
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      element.text ?? '2',
                                      style: TextStyle(
                                        color: element.userId == int.parse(myId)
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  )
                                : Container(
                                    // margin: const EdgeInsets.only(
                                    //     top: 12, left: 10),
                                    // alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    height: 320,
                                    width: 210,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "https://lunamarket.ru/storage/${element.path ?? ''}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(12),

                                      //color: const Color(0xFFF0F5F5))),
                                    ),
                                  ),
                          ),
                        ),
                        // optional
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 36),
                    //  padding: EdgeInsets.only(left: 16, right: 16, bottom: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // SendData();123123121

                            if (_image == null) {
                              Get.defaultDialog(
                                title: "Отправить фото",
                                middleText: '',
                                textConfirm: 'Камера',
                                textCancel: 'Фото',
                                titlePadding: const EdgeInsets.only(top: 40),
                                onConfirm: () {
                                  change = true;
                                  setState(() {
                                    change;
                                  });
                                  _getImage();
                                },
                                onCancel: () {
                                  change = false;
                                  setState(() {
                                    change;
                                  });
                                  _getImage();
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Image.asset('assets/icons/file.png'),
                          ),

                          // const Icon(
                          //   Icons.link,
                          //   color: Colors.black,
                          // ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              padding: const EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 0.3, color: Colors.grey),
                              ),
                              width: 243,
                              child: TextField(
                                autocorrect: false,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Напишите продавцу',
                                ),
                                controller: _chatTextController,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            SendData();
                          },
                          child: const Icon(Icons.send, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
            }
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
        },
      ),
    );
  }
}
