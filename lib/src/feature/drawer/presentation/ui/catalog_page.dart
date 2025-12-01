import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:haji_market/src/feature/drawer/bloc/brand_cubit.dart' as brand_cubit;
import 'package:haji_market/src/feature/drawer/bloc/brand_state.dart' as brand_state;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:haji_market/src/feature/home/bloc/cats_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/cats_state.dart';

@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  TextEditingController searchController = TextEditingController();
  List<CatsModel> brands = [];
  CatsModel? brand;

  @override
  void initState() {
    brand_cubit.BrandCubit brandInitCubit = BlocProvider.of<brand_cubit.BrandCubit>(context);

    if (brandInitCubit.state is! brand_state.LoadedState) {
      BlocProvider.of<brand_cubit.BrandCubit>(context).brands();
    }

    brandList();

    super.initState();
  }

  brandList() async {
    // widget.catChapters?.forEach((cat) {
    //   print(cat.name ?? '');
    // });

    final List<CatsModel> data = await BlocProvider.of<brand_cubit.BrandCubit>(
      context,
    ).brandsList();
    brands.addAll(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        //iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            BlocProvider.of<CatsCubit>(context).cats();
            context.read<FilterProvider>().resetAll();
            context.router.pop();
          },
          child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 2.1),
        ),
        titleSpacing: 0,
        // leadingWiadth: 1,
        title: Text('Все категории', style: AppTextStyles.size18Weight600),

        // Container(
        //   height: 34,
        //   width: 279,
        //   decoration: BoxDecoration(
        //       color: const Color(0xFFF8F8F8),
        //       borderRadius: BorderRadius.circular(10)),
        //   child: TextField(
        //       controller: searchController,
        //       onChanged: (value) {
        //         if (value.isEmpty) {
        //           BlocProvider.of<CatsCubit>(context).saveCats();
        //         } else {
        //           BlocProvider.of<CatsCubit>(context).searchCats(value);
        //         }

        //         // if (searchController.text.isEmpty)
        //         //   BlocProvider.of<CityCubit>(context)
        //         //       .cities(value);
        //       },
        //       decoration: const InputDecoration(
        //         prefixIcon: Icon(
        //           Icons.search,
        //           color: AppColors.kGray300,
        //         ),
        //         hintText: 'Поиск',
        //         hintStyle: TextStyle(
        //           color: AppColors.kGray300,
        //           fontSize: 16,
        //         ),
        //         border: InputBorder.none,
        //       ),
        //       style: const TextStyle(
        //         color: Colors.black,
        //       )),
        // ),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            // alignment: Alignment.center,
            color: AppColors.kWhite,
            alignment: Alignment.center,
            child: SizedBox(
              height: 64,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final filters = context.read<FilterProvider>();
                      filters.resetAll;
                      CatsModel allCats = CatsModel(
                        id: 0,
                        name: 'Все категории',
                        text: 'Для тех, кто хочет всё',
                        image: 'cat/36/image/8mWKc4Kk0ArxqBPnOCVtqhIqdmJicFzlPkMmLDvD.png',
                      );
                      context.router.push(
                        ProductsRoute(cats: allCats, subCats: null, brandId: brands[index].id),
                      );
                      // if (brands[index] == brand) {
                      //   brand = null;
                      //   BlocProvider.of<CatsCubit>(context).cats();
                      // } else {
                      //   brand = brands[index];
                      //   BlocProvider.of<CatsCubit>(context)
                      //       .catsByBrand(brand!.id!);
                      // }
                      // setState(() {});
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(right: 4, left: index == 0 ? 16 : 0),
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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFFF5F4FF),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: brands[index].icon != null
                                ? NetworkImage(
                                    "https://lunamarket.ru/storage/${brands[index].icon}",
                                  )
                                : const AssetImage('assets/icons/profile2.png') as ImageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<CatsCubit, CatsState>(
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
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }

                if (state is NoDataState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(Assets.icons.defaultNoDataIcon.path, height: 72, width: 72),
                      SizedBox(height: 12),
                      Text(
                        'Пока здесь пусто',
                        style: AppTextStyles.size16Weight500.copyWith(color: Color(0xFF8E8E93)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }

                if (state is LoadedState) {
                  return ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.only(top: 12, bottom: 12),
                        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 114 / 120,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: state.cats.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.router.push(
                                  SubCatalogRoute(
                                    cats: state.cats[index],
                                    catChapters: state.cats[index].catSections!,
                                  ),
                                );
                                // context.router.push(
                                //     UnderCatalogRoute(cats: state.cats[index]));
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           UnderCatalogPage(cats: state.cats[index])),
                                // );
                              },
                              child: CatalogListTile(
                                title: '${state.cats[index].name}',
                                credit: state.cats[index].credit!,
                                bonus: '${state.cats[index].bonus}',
                                url: "https://lunamarket.ru/storage/${state.cats[index].image!}",
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );

                  // ListView.builder(
                  //   itemCount: state.cats.length,
                  //   itemBuilder: (context, index) {
                  //     return
                  // return Column(
                  //   mainAxisSize: MainAxisSize.max,
                  //   children: [
                  // if (index == 0) const SizedBox(height: 5),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               UnderCatalogPage(cats: state.cats[index])),
                  //     );
                  //   },
                  //   child:
                  //     CatalogListTile(
                  //   title: '${state.cats[index].name}',
                  //   url:
                  //       "http://80.87.202.73:8001/storage/${state.cats[index].icon!}",
                  // );

                  //   const Divider(
                  //     color: AppColors.kGray400,
                  //   ),
                  // ],
                  // );
                  //},
                  // );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }
              },
            ),
          ),
        ],
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double imageSize = 80;
    final String imageUrl = url;

    final Future<void> precache = precacheImage(NetworkImage(imageUrl), context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.mainBackgroundPurpleColor,
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: const BoxConstraints(minHeight: 120),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Заголовок
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8, // если нужно не перекрывать картинку: right: imageSize + 16,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.size13Weight500,
                  ),
                ),

                // Картинка
                Positioned(
                  right: 8,
                  bottom: 4,
                  child: SizedBox(
                    height: imageSize,
                    width: imageSize,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      // Можно оставить свой локальный спиннер ИЛИ ничего — у нас есть фулл-оверлей сверху
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return child;
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[100],
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                // ФУЛЛ-ШАР ШИММЕР: поверх всей карточки, пока картинка не готова
                Positioned.fill(
                  child: FutureBuilder<void>(
                    future: precache,
                    builder: (context, snapshot) {
                      final bool loading = snapshot.connectionState != ConnectionState.done;
                      // если была ошибка загрузки — убираем оверлей, пусть покажется errorBuilder
                      final bool show = loading && !snapshot.hasError;

                      return IgnorePointer(
                        ignoring: true, // тапы проходят сквозь оверлей
                        child: AnimatedOpacity(
                          opacity: show ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          child: Shimmer(
                            // shimmer_animation: Shimmer(child: ...)
                            child: Container(
                              // лёгкая подложка, чтобы блик был заметен
                              color: Colors.white.withOpacity(0.06),
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
        ),
      ),
    );
  }
}
