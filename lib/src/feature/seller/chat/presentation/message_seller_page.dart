import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/chat/data/DTO/messageDto.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:haji_market/src/feature/seller/chat/cubit/chat_seller_cubit.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/chat/data/DTO/message_dto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../chat/data/cubit/message_cubit.dart';
import '../data/DTO/message_seller_dto.dart';
import '../cubit/message_seller_cubit.dart';
import '../cubit/message_seller_state.dart';

class MessageSeller extends StatefulWidget {
  int? chatId;
  int? userId;
  String? userName;

  MessageSeller({this.chatId, this.userId, this.userName, super.key});

  @override
  State<MessageSeller> createState() => _MessageSellerState();
}

class _MessageSellerState extends State<MessageSeller> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;

  bool isFullScreen = false;

  late WebSocketChannel channel;

  final TextEditingController _chatTextController = TextEditingController();
  final RefreshController _refreshController = RefreshController();

  void SendData() async {
    if (_chatTextController.text.isNotEmpty) {
      String text = jsonEncode({
        'action': 'message',
        'text': _chatTextController.text.toString(),
        'to': widget.userId,
        'chat_id': widget.chatId,
      });

      channel.sink.add(text);
      _chatTextController.clear();
      // channel.sink.
    }

    if (_image != null) {
      final chat = BlocProvider.of<MessageCubit>(context);

      String? data = await chat.imageStore(_image != null ? _image!.path : "");

      String text = jsonEncode({
        'action': 'file',
        'text': null,
        'path': data,
        'type': 'image',
        'to': widget.userId,
        'chat_id': widget.chatId,
      });

      channel.sink.add(text);

      _image = null;
      setState(() {});
    }
  }

  messageDTO? messageText;
  String sellerId = GetStorage().read('seller_id');
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
    await BlocProvider.of<MessageSellerCubit>(
      context,
    ).paginationMessage(widget.chatId ?? 0, widget.userId ?? 0);
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.loadComplete();
  }

  // void scrollDown() {
  //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
  // }

  Future<void> _handleImageSelection(bool fromCamera) async {
    final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
    final image = await _picker.pickImage(source: source);

    if (image != null) {
      debugPrint('Selected image: ${image.path}');
      setState(() {
        _image = image;
      });
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _chatTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<MessageSellerCubit>(context).getMessage(widget.chatId ?? 0, widget.userId ?? 0);
    channel = IOWebSocketChannel.connect("ws://lunamarket.ru:1995/?user_id=$sellerId");

    channel.ready.then((value) {
      ready = true;
      String text = jsonEncode({'action': 'read', 'chat_id': widget.chatId});
      channel.sink.add(text);
      setState(() {});
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
        BlocProvider.of<MessageSellerCubit>(context).newMessage(MessageSellerDTO.fromJson(data));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        leading: IconButton(
          onPressed: () async {
            // await context.read<ChatCubit>().chat();
            // if (!context.mounted) return;
            Get.back();
          },
          icon: Image.asset(Assets.icons.defaultBackIcon.path, fit: BoxFit.contain, scale: 2.1),
          tooltip: 'Back',
        ),
        centerTitle: true,
        title: Text(widget.userName ?? 'Чат', style: AppTextStyles.size18Weight600),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Container(
            // height: 56,
            decoration: BoxDecoration(
              color: const Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: _chatTextController.text.length >= 20
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.center, // важно
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // if (_image == null) {
                        final bool? isCamera = await showAccountAlert(
                          context,
                          title: 'Изменить фото',
                          message: 'Выберите источник',
                          mode: AccountAlertMode.confirm,
                          cancelText: 'Галерея',
                          primaryText: 'Камера',
                          primaryColor: Colors.red,
                        );

                        if (!mounted || isCamera == null) return;
                        _handleImageSelection(isCamera);

                        // showClientImageOptions(context, false, 'Изменить фото профиля', (
                        //   value,
                        // ) async {
                        //   if (value == 'image') {

                        //   } else {
                        //     Navigator.of(context).pop();
                        //   }
                        // });
                        //   Get.defaultDialog(
                        //     title: "Отправить фото",
                        //     middleText: '',
                        //     textConfirm: 'Камера',
                        //     textCancel: 'Фото',
                        //     titlePadding: const EdgeInsets.only(top: 40),
                        //     onConfirm: () async {
                        //       Get.back();
                        //       change = true;
                        //       await _getImage();
                        //       if (!mounted) return;
                        //       setState(() {});
                        //     },
                        //     onCancel: () async {
                        //       Get.back();
                        //       change = false;
                        //       await _getImage();
                        //       if (!mounted) return;
                        //       setState(() {});
                        //     },
                        //   );
                        // }
                        // }
                      },
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(Assets.icons.attachIcon.path, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _chatTextController,
                          onChanged: (value) {
                            if (_chatTextController.text.length >= 20) {
                              setState(() {});
                            }
                          },
                          autocorrect: false,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          style: AppTextStyles.size16Weight400.copyWith(
                            color: const Color(0xff1C1C1E),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Напишите сообщение',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 9),
                    GestureDetector(
                      onTap: () {
                        SendData();
                      },
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(
                          Assets.icons.sendIcon.path,
                          fit: BoxFit.contain,
                          color: const Color(0xffAEAEB2),
                        ),
                      ),
                    ),
                  ],

                  //   if (value == 'image') {
                ),

                if (_image != null)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        margin: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.hardEdge,
                        child: Image.file(File(_image!.path), fit: BoxFit.cover),
                      ),
                      Positioned(
                        right: -4,
                        top: 4,
                        child: InkWell(
                          onTap: () {
                            setState(() => _image = null);
                          },
                          child: Image.asset(
                            Assets.icons.defaultCloseIcon.path,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),

      body: BlocConsumer<MessageSellerCubit, MessageSellerState>(
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
            return ready
                ? SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    reverse: false,
                    onLoading: () {
                      onLoading();
                    },
                    // onRefresh: () {
                    //   onRefresh();
                    // },
                    child: GroupedListView<MessageSellerDTO, DateTime>(
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
                        alignment: element.userId != int.parse(sellerId)
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
                          color: element.userId == int.parse(sellerId)
                              ? Color(0xffF1EBFE)
                              : AppColors.kPrimaryColor,
                          child: element.type == 'message'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    element.text ?? '2',

                                    style: AppTextStyles.size16Weight400.copyWith(
                                      color: element.userId == int.parse(sellerId)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://lunamarket.ru/storage/${element.path ?? ''}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                        ),
                      ),

                      // optional
                    ),
                  )
                : const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
        },
      ),

      // SizedBox(height: 20, child: Text(message)),
      // bottomSheet: // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   child: Icon(
      //     Icons.send,
      //     color: Colors.black,
      //   ),
      //   onPressed: () {
      //     SendData();
      //     //_scrollController.position.maxScrollExtent;

      //     // _scrollController.animateTo(
      //     //   10 * 2.63 * (text.length).toDouble(),
      //     //   curve: Curves.linear,
      //     //   duration: const Duration(milliseconds: 20),
      //     // );
      //   },
      // ),
    );
  }

  Widget _buildThumbnailImage(String imagePath) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage("https://lunamarket.ru/storage/$imagePath"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  // Helper method for full-screen image
  Widget _buildFullScreenImage(String imagePath) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isFullScreen = false; // Close full-screen on tap
          });
        },
        child: InteractiveViewer(
          // Allows pinch-to-zoom
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://lunamarket.ru/storage/$imagePath"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
