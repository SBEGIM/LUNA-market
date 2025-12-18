import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/chat/data/DTO/message_dto.dart';
import 'package:haji_market/src/feature/chat/data/cubit/chat_cubit.dart';
import 'package:haji_market/src/feature/chat/data/cubit/message_cubit.dart';
import 'package:haji_market/src/feature/chat/data/cubit/message_state.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../data/DTO/messageDto.dart';

class MessagePage extends StatefulWidget {
  int? userId;
  String? avatar;
  int? chatId;
  String? name;
  String? role;

  MessagePage({
    required this.userId,
    this.name,
    required this.avatar,
    this.chatId,
    required this.role,
    super.key,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;

  late WebSocketChannel channel;

  final TextEditingController _chatTextController = TextEditingController();
  final RefreshController _refreshController = RefreshController();

  void sendData() async {
    if (_chatTextController.text.isNotEmpty) {
      String text = jsonEncode({
        'action': 'message',
        'text': _chatTextController.text.toString(),
        'to': widget.userId,
        'from_role': 'user',
        'to_role': widget.role,
        'chat_id': widget.chatId,
      });
      channel.sink.add(text);
      _chatTextController.clear();
    }

    if (_image != null) {
      final chat = BlocProvider.of<MessageCubit>(context);

      String? data = await chat.imageStore(_image != null ? _image?.path ?? '' : "");

      String text = jsonEncode({
        'action': 'file',
        'text': null,
        'path': data,
        'type': 'image',
        'to': widget.userId,
        'from_role': 'user',
        'to_role': widget.role,
        'chat_id': widget.chatId,
      });
      channel.sink.add(text);
      _image = null;
      setState(() {});
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
    _chatTextController.clear();
    _chatTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<MessageCubit>(context).getMessage(widget.chatId ?? 0, widget.userId ?? 0);
    channel = IOWebSocketChannel.connect("ws://lunamarket.ru:1995/?user_id=$myId&role=user");

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

  void _openFullScreenImage(String path) {
    final p = path.trim();
    if (p.isEmpty) return;

    final imageUrl = "https://lunamarket.ru/storage/$p";
    final tc = TransformationController();

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (dialogContext) {
        return Stack(
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.92, // было 1.0 (почти на весь экран) → 92% ширины
                heightFactor: 0.78, // 78% высоты
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 1,
                  maxScale: 3, // чуть меньше зум
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 40,
              right: 24,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(dialogContext),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.kWhite,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () async {
              await context.read<ChatCubit>().chat();
              if (!context.mounted) return;
              Get.back();
            },
            icon: Image.asset(Assets.icons.defaultBackIcon.path, fit: BoxFit.contain, scale: 2.1),
            tooltip: 'Back',
          ),
          centerTitle: true,
          title: Text(widget.name ?? 'Чат', style: AppTextStyles.size18Weight600),
        ),

        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
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
                            sendData();
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
        ),

        body: SafeArea(
          child: BlocConsumer<MessageCubit, MessageState>(
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
                  return SmartRefresher(
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
                              ? Color(0xffF1EBFE)
                              : AppColors.kPrimaryColor,
                          child: element.type == 'message'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    element.text ?? '2',

                                    style: AppTextStyles.size16Weight400.copyWith(
                                      color: element.userId == int.parse(myId)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    final p = element.path ?? '';
                                    if (p.isEmpty) return;
                                    _openFullScreenImage(p);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      "https://lunamarket.ru/storage/${element.path ?? ''}",
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey.shade200,
                                          alignment: Alignment.center,
                                          child: const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey.shade200,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.broken_image_outlined,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // optional
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
                }
              } else {
                return const Center(child: CircularProgressIndicator(color: Colors.red));
              }
            },
          ),
        ),
      ),
    );
  }
}
