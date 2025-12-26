import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_state.dart';
import 'package:haji_market/src/feature/drawer/bloc/brand_cubit.dart';

@RoutePage()
class SubCatalogPage extends StatefulWidget {
  final CatsModel? cats;
  final List<CatSections>? catChapters;

  const SubCatalogPage({super.key, this.cats, required this.catChapters});

  @override
  State<SubCatalogPage> createState() => _SubCatalogPageState();
}

class _SubCatalogPageState extends State<SubCatalogPage> {
  TextEditingController searchController = TextEditingController();
  int _selectedChapter = -1;

  // List<String> catChapters = ['Женская', 'Мужская', 'Детская'];
  List<CatsModel> brands = [];
  CatsModel? brand;

  @override
  void initState() {
    BlocProvider.of<SubCatsCubit>(context).subCats(widget.cats?.id ?? 0);

    BrandCubit brandInitCubit = BlocProvider.of<BrandCubit>(context);

    if (brandInitCubit.state is! BrandStateLoaded) {
      BlocProvider.of<BrandCubit>(context).brands(subCatId: widget.cats!.id);
    }

    brandList();

    super.initState();
  }

  Future<void> brandList() async {
    final List<CatsModel> data = await BlocProvider.of<BrandCubit>(context).brandsList();
    brands.addAll(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray1,
      appBar: AppBar(
        //iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,

        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.router.pop();
            // Get.to(Base(index: 1));
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [],
        titleSpacing: 0,
        title: Text(widget.cats?.name ?? '', style: AppTextStyles.size18Weight600),
      ),
      body: BlocConsumer<SubCatsCubit, SubCatsState>(
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
          if (state is LoadingState) {
            return const _SubCatalogShimmer();
          }

          if (state is LoadedState) {
            return ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ((widget.catChapters?.length ?? 0) != 0)
                          ? SizedBox(
                              height: 36,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.catChapters?.length,
                                itemBuilder: (context, index) {
                                  bool isEvenIndex = index % 2 == 0;
                                  return InkWell(
                                    onTap: () {
                                      if (_selectedChapter == index) {
                                        _selectedChapter = -1;
                                        setState(() {});
                                        BlocProvider.of<SubCatsCubit>(
                                          context,
                                        ).subCats(widget.cats!.id);
                                        return;
                                      } else {
                                        _selectedChapter = index;
                                        BlocProvider.of<SubCatsCubit>(context).subCatsBrandOptions(
                                          widget.cats!.id,
                                          brand?.id ?? 0,
                                          widget.catChapters?[_selectedChapter].section?.id ?? 0,
                                        );
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width - 32) /
                                          (widget.catChapters?.length ?? 1),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedChapter == index
                                            ? AppColors.mainPurpleColor
                                            : AppColors.kWhite,
                                        border: Border(
                                          top: BorderSide(
                                            color: AppColors.mainPurpleColor,
                                            width: 1,
                                          ),
                                          bottom: BorderSide(
                                            color: AppColors.mainPurpleColor,
                                            width: 1,
                                          ),
                                          left: isEvenIndex
                                              ? BorderSide(
                                                  color: AppColors.mainPurpleColor,
                                                  width: 1,
                                                )
                                              : BorderSide.none,
                                          right: isEvenIndex
                                              ? BorderSide(
                                                  color: AppColors.mainPurpleColor,
                                                  width: 1,
                                                )
                                              : BorderSide.none,
                                        ),
                                      ),
                                      child: Text(
                                        widget.catChapters?[index].section?.name ?? '',
                                        style: AppTextStyles.categoryTextStyle.copyWith(
                                          color: _selectedChapter == index
                                              ? Colors.white
                                              : AppColors.mainPurpleColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox.shrink(),
                      ((widget.catChapters?.length ?? 0) != 0)
                          ? SizedBox(height: 24)
                          : SizedBox.shrink(),
                      Text('Популярные бренды', style: AppTextStyles.defaultButtonTextStyle),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 64,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: brands.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final filters = context.read<FilterProvider>();
                                filters.resetAll;
                                filters.setBrands([]);
                                filters.setCategory(widget.cats?.id ?? 0);
                                filters.setSubCats([state.cats[index].id ?? 0]);

                                context.router.push(
                                  ProductsRoute(
                                    cats:
                                        widget.cats ??
                                        CatsModel(
                                          id: widget.cats?.id ?? 0,
                                          name: widget.cats?.name ?? '',
                                        ),
                                    subCats: state.cats[index],
                                    brandId: brands[index].id,
                                  ),
                                );
                              },
                              child: Container(
                                width: 64,
                                height: 64,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: brand?.id == brands[index].id
                                      ? const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                                        )
                                      : null,
                                ),
                                padding: const EdgeInsets.all(2.2), // толщина границы
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xFFF5F4FF), // светлый фон
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image(
                                      image: brands[index].icon != null
                                          ? NetworkImage(
                                              "https://lunamarket.ru/storage/${brands[index].icon}",
                                            )
                                          : const AssetImage('assets/icons/profile2.png')
                                                as ImageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 175 / 120,
                    ),
                    itemCount: state.cats.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          final filters = context.read<FilterProvider>();
                          filters.resetAll;
                          filters.setBrands([]);
                          filters.setCategory(widget.cats?.id ?? 0);
                          filters.setSubCats([state.cats[index].id ?? 0]);

                          context.router.push(
                            ProductsRoute(
                              cats:
                                  widget.cats ??
                                  CatsModel(
                                    id: widget.cats?.id ?? 0,
                                    name: widget.cats?.name ?? '',
                                  ),
                              subCats: state.cats[index],
                            ),
                          );
                        },
                        child: CatalogListTile(
                          title: '${state.cats[index].name}',
                          credit: 0,
                          bonus: '0',
                          url: "https://lunamarket.ru/storage/${state.cats[index].icon ?? ''}",
                        ),
                      );
                    },
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

class CatalogListTile extends StatelessWidget {
  final String title;
  final String url;
  final String bonus;
  final int credit;

  const CatalogListTile({
    required this.url,
    required this.title,
    required this.bonus,
    required this.credit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainBackgroundPurpleColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(right: 8, bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.mainBackgroundPurpleColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.contain,
                  placeholder: (context, _) => Shimmer.fromColors(
                    baseColor: const Color(0xFFF7F7F7),
                    highlightColor: const Color(0xFFF7F7F7),
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, _, _) => const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          Container(
            height: 34,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8, left: 8, bottom: 2),
            child: Text(
              title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: AppTextStyles.size13Weight500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubCatalogShimmer extends StatelessWidget {
  const _SubCatalogShimmer();

  @override
  Widget build(BuildContext context) {
    final base = const Color(0xFFF7F7F7);
    final highlight = const Color(0xFFF7F7F7);

    return ListView(
      children: [
        // Блок с главами + брендами (как у вас сверху)
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Чипы глав
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: base,
                    highlightColor: highlight,
                    child: Container(
                      width: 120,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: base),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Заголовок "Популярные бренды"
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Container(
                  width: 180,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Горизонтальный список брендов
              SizedBox(
                height: 64,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  separatorBuilder: (_, _) => const SizedBox(width: 4),
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: base,
                    highlightColor: highlight,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Сетка подкатегорий
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 175 / 120,
            ),
            itemBuilder: (context, index) =>
                _CatalogTileShimmer(baseColor: base, highlightColor: highlight),
          ),
        ),
      ],
    );
  }
}

class _CatalogTileShimmer extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;

  const _CatalogTileShimmer({required this.baseColor, required this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.mainBackgroundPurpleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // "текст" — две строки
            Positioned(
              left: 8,
              top: 8,
              right: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rect(width: 90, height: 12),
                  const SizedBox(height: 6),
                  _rect(width: 120, height: 12),
                ],
              ),
            ),
            // "картинка"
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rect({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    );
  }
}
