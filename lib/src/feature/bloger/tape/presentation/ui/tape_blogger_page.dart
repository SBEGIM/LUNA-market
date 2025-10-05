import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/detail_tape_card_page.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/tape_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../bloc/tape_blogger_cubit.dart';
import '../../bloc/tape_blogger_state.dart';

@RoutePage()
class TapeBloggerPage extends StatefulWidget {
  const TapeBloggerPage({super.key});

  @override
  State<TapeBloggerPage> createState() => _TapeBloggerPageState();
}

class _TapeBloggerPageState extends State<TapeBloggerPage> {
  final List<Map> myProducts =
      List.generate(6, (index) => {"id": index, "name": "Product "}).toList();

  TextEditingController searchController = TextEditingController();
  final int _value = 1;

  @override
  void initState() {
    BlocProvider.of<TapeBloggerCubit>(context).tapes(false, false, '');
    super.initState();
  }

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        title: const Text("Мои обзоры",
            style: AppTextStyles.defaultAppBarTextStyle),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () {
          context.read<TapeBloggerCubit>().tapes(false, false, '');
          refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            // Поисковая строка
            SliverToBoxAdapter(
              child: Container(
                height: 44,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xffEAECED),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Assets.icons.defaultSearchIcon.path,
                        height: 20, width: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        style: AppTextStyles.size16Weight400,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Поиск',
                          hintStyle: AppTextStyles.size16Weight400
                              .copyWith(color: const Color(0xFF8E8E93)),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Контент состояний
            BlocConsumer<TapeBloggerCubit, TapeBloggerState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadingState) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent)),
                  );
                }

                if (state is ErrorState) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                        child: Text('Ошибка загрузки',
                            style: TextStyle(fontSize: 18))),
                  );
                }

                if (state is NoDataState) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 16),
                        Text('В ленте нет данных',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center),
                        SizedBox(height: 8),
                        Text('По вашему запросу ничего не найдено',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff717171)),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  );
                }

                if (state is LoadedState) {
                  return SliverPadding(
                    padding: EdgeInsets.only(
                      left: 0,
                      right: 0,
                      bottom: 16 +
                          MediaQuery.of(context)
                              .padding
                              .bottom, // чтобы последняя карточка была видна
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1 / 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = state.tapeModel[index];
                          return Shimmer(
                            duration: const Duration(seconds: 3),
                            interval: const Duration(microseconds: 1),
                            color: Colors.white,
                            colorOpacity: 0,
                            enabled: true,
                            direction: const ShimmerDirection.fromLTRB(),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black.withOpacity(1.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  context.router.push(
                                      DetailTapeBloggerCardRoute(
                                          index: index,
                                          tapeId: item.tapeId,
                                          tape: item,
                                          tapeBloc:
                                              context.read<TapeBloggerCubit>(),
                                          shopName: item.shop!.name));
                                },
                                child: BloggerTapeCardPage(
                                    tape: item, index: index),
                              ),
                            ),
                          );
                        },
                        childCount: state.tapeModel.length,
                      ),
                    ),
                  );
                }

                // fallback
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
