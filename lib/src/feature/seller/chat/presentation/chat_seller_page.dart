import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  TextEditingController searchController = TextEditingController();

  parseDate(date) {
    final dateTimeString = date;
    final dateTime = DateTime.parse(dateTimeString);

    // final clockString = DateFormat('H:mm / yy-M-dd').format(dateTime);
    final clockString = DateFormat('H:mm').format(dateTime);
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
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 28,
        title: const Text('Чат', style: AppTextStyles.size22Weight700),
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Container(
                    height: 44,
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffEAECED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        context.read<ChatSellerCubit>().searchChats(value);
                        setState(() {});
                      },
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
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 18 + 5,
                          minHeight: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 600,
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.chat.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12);
                      },
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageSellerPage(
                                chatId: state.chat[index].chatId,
                                userId: state.chat[index].userId,
                                userName: state.chat[index].name,
                                role: state.chat[index].role,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: state.chat[index].avatar != null
                                    ? NetworkImage(
                                        'https://lunamarket.ru/storage/${state.chat[index].avatar}',
                                      )
                                    : const AssetImage('assets/icons/profile2.png')
                                          as ImageProvider,
                                backgroundColor: Colors.grey[100],
                                radius: 30,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${state.chat[index].name}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${state.chat[index].lastMessage != null ? state.chat[index].lastMessage!.text : ''}',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        state.chat[index].countNewMessages != 0
                                            ? Container(
                                                width: 22,
                                                height: 22,
                                                margin: const EdgeInsets.only(top: 6),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: AppColors.mainRedColor,
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
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        },
      ),
    );
  }
}
