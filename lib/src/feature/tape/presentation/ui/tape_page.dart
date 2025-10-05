import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:haji_market/src/feature/tape/presentation/widgets/tape_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../bloc/tape_state.dart';

@RoutePage()
class TapePage extends StatefulWidget {
  const TapePage({Key? key}) : super(key: key);

  @override
  State<TapePage> createState() => _TapePageState();
}

class _TapePageState extends State<TapePage> with TickerProviderStateMixin {
  late final TabController _tabs =
      TabController(length: 3, vsync: this, initialIndex: 0);

  final RefreshController refreshController = RefreshController();
  final TextEditingController searchController = TextEditingController();

  // Для контроля частоты перезагрузок при смене таба/поиске
  Timer? _debounce;
  int _lastTabIndex = 0;

  int random(int min, int max) => min + Random().nextInt(max - min);

  List<String> get noDataText => const [
        'Загляните позже — мы готовим подборку \nдля вас',
        'Пока здесь пусто \nЗдесь будут обзоры от тех, на кого \nвы подписаны',
        'Пока здесь пусто \nВаши избранные видеообзоры \nпоявятся здесь',
      ];

  bool get _isSubs => _tabs.index == 1;
  bool get _isFavs => _tabs.index == 2;

  Future<void> _refresh() async {
    await context
        .read<TapeCubit>()
        .tapes(_isSubs, _isFavs, searchController.text, 0);
    refreshController.refreshCompleted();
  }

  Future<void> _loadMore() async {
    // Если у тебя в Cubit есть номер следующей страницы — подставь его вместо 0
    await context
        .read<TapeCubit>()
        .tapePagination(_isSubs, _isFavs, searchController.text, 0);
    refreshController.loadComplete();
  }

  void _onTabChanged() {
    // Дёргать загрузку только при завершённой смене и смене индекса
    if (!_tabs.indexIsChanging && _lastTabIndex != _tabs.index) {
      _lastTabIndex = _tabs.index;
      context
          .read<TapeCubit>()
          .tapes(_isSubs, _isFavs, searchController.text, 0);
    }
  }

  @override
  void initState() {
    super.initState();

    final cubit = context.read<TapeCubit>();
    if (cubit.state is! LoadedState) {
      cubit.tapes(false, false, '', 0);
    }

    _tabs.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    refreshController.dispose();
    _tabs.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        toolbarHeight: 20,
        surfaceTintColor: AppColors.kWhite,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.kGray1,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 18),
                    Image.asset(
                      Assets.icons.defaultSearchIcon.path,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          _debounce?.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 350), () {
                            context
                                .read<TapeCubit>()
                                .tapes(_isSubs, _isFavs, value, 0);
                          });
                          // setState() не нужен — Cubit сам обновит UI
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Поиск',
                          hintStyle: AppTextStyles.size16Weight400
                              .copyWith(color: AppColors.kGray300),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              TabBar(
                indicatorWeight: 0,
                automaticIndicatorColorAdjustment: true,
                indicatorPadding: EdgeInsets.zero,
                labelStyle: AppTextStyles.size15Weight600
                    .copyWith(color: const Color(0xFF3A3A3C)),
                indicatorColor: AppColors.kWhite,
                labelColor: const Color(0xFF3A3A3C),
                unselectedLabelColor: const Color(0xFF3A3A3C),
                indicator: FixedWidthIndicator(
                  width: MediaQuery.of(context).size.width / 3,
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF3A3A3C)),
                ),
                controller: _tabs,
                tabs: const <Widget>[
                  Tab(text: 'Для вас'),
                  Tab(text: 'Подписки'),
                  Tab(text: 'Избранное'),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          BlocConsumer<TapeCubit, TapeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ErrorState) {
                return Expanded(
                  child: Center(
                    child: Text(
                      state.message,
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (state is LoadingState) {
                return SizedBox.shrink();
              }

              if (state is NoDataState) {
                return Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: _refresh,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 209),
                              child: Image.asset(
                                Assets.icons.defaultNoDataIcon.path,
                                height: 72,
                                width: 72,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              noDataText[_tabs.index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff8E8E93),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (state is LoadedState) {
                return Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: _refresh,
                    onLoading: _loadMore,
                    child: GridView.builder(
                      cacheExtent: 10000,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1 / 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                      ),
                      itemCount: state.tapeModel.length,
                      itemBuilder: (context, index) {
                        return Shimmer(
                          duration: const Duration(seconds: 3),
                          interval: const Duration(microseconds: 1),
                          color: AppColors.kGray300,
                          colorOpacity: 0,
                          enabled: true,
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: TapeCardWidget(
                              tape: state.tapeModel[index],
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }

              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FixedWidthIndicator extends Decoration {
  final double width;
  final BorderSide borderSide;

  const FixedWidthIndicator({
    required this.width,
    required this.borderSide,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FixedWidthPainter(this, onChanged);
  }
}

class _FixedWidthPainter extends BoxPainter {
  final FixedWidthIndicator decoration;

  _FixedWidthPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = decoration.borderSide.color
      ..strokeWidth = decoration.borderSide.width
      ..style = PaintingStyle.stroke;

    final double tabCenter = offset.dx + configuration.size!.width / 2;
    final double y = offset.dy +
        configuration.size!.height -
        decoration.borderSide.width / 2;

    final double startX = tabCenter - decoration.width / 2;
    final double endX = tabCenter + decoration.width / 2;

    canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
  }
}
