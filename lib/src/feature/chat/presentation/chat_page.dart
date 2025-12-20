import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/chat/data/cubit/chat_cubit.dart';
import 'package:haji_market/src/feature/chat/data/cubit/chat_state.dart';
import 'package:haji_market/src/feature/chat/presentation/message.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../core/common/constants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  TextEditingController searchController = TextEditingController();


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
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 2.1),
        ),
        title: const Text('Сообщение', style: AppTextStyles.size18Weight600),
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
                  height: 44,
                  margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Поиск',
                      hintStyle: AppTextStyles.size16Weight400.copyWith(
                        color: const Color(0xff8E8E93),
                      ),
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Image.asset(
                          Assets.icons.defaultSearchIcon.path,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 18 + 5, minHeight: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 600,
                  padding: const EdgeInsets.only(left: 16, right: 0),
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessagePage(
                                    userId: state.chat[index].userId,
                                    name: state.chat[index].name!,
                                    avatar: state.chat[index].avatar,
                                    chatId: state.chat[index].chatId,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                height: 80,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: state.chat[index].avatar != null
                                          ? NetworkImage(
                                              'https://lunamarket.ru/storage/${state.chat[index].avatar}',
                                            )
                                          : const AssetImage('assets/icons/profile2.png')
                                                as ImageProvider,
                                      backgroundColor: Colors.grey.withOpacity(0.3),
                                      radius: 30,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 280,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${state.chat[index].name}',
                                                style: AppTextStyles.size16Weight500,
                                              ),
                                              Text(
                                                ' ${parseDate(state.chat[index].createdAt)}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Вы:${state.chat[index].lastMessage != null ? state.chat[index].lastMessage!.text : ''}',
                                              style: AppTextStyles.size14Weight400.copyWith(
                                                color: Color(0xff8E8E93),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            state.chat[index].countNewMessages != 0
                                                ? Container(
                                                    width: 22,
                                                    height: 22,
                                                    margin: const EdgeInsets.only(top: 6),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: AppColors.kPrimaryColor,
                                                    ),
                                                    child: Text(
                                                      '${state.chat[index].countNewMessages}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        },
      ),
    );
  }
}
