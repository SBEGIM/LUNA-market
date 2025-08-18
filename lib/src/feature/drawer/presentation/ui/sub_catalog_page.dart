import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../home/data/model/cat_model.dart';
import '../../bloc/sub_cats_cubit.dart';
import '../../bloc/sub_cats_state.dart';
import '../../../drawer/bloc/brand_cubit.dart' as brandCubit;
import 'package:haji_market/src/feature/drawer/bloc/brand_state.dart'
    as brandState;

@RoutePage()
class SubCatalogPage extends StatefulWidget {
  final CatsModel? cats;

  const SubCatalogPage({Key? key, this.cats}) : super(key: key);

  @override
  State<SubCatalogPage> createState() => _SubCatalogPageState();
}

class _SubCatalogPageState extends State<SubCatalogPage> {
  TextEditingController searchController = TextEditingController();
  int _selectedChapter = -1;

  List<String> catChapters = ['Женская', 'Мусжская', 'Детская'];
  List<CatsModel> brands = [];
  CatsModel? brand;

  @override
  void initState() {
    BlocProvider.of<SubCatsCubit>(context).subCats(widget.cats?.id ?? 0);

    brandCubit.BrandCubit brandInitCubit =
        BlocProvider.of<brandCubit.BrandCubit>(context);

    if (brandInitCubit.state is! brandState.LoadedState) {
      BlocProvider.of<brandCubit.BrandCubit>(context)
          .brands(subCatId: widget.cats!.id);
    }
    brandList();

    super.initState();
  }

  brandList() async {
    final List<CatsModel> data =
        await BlocProvider.of<brandCubit.BrandCubit>(context).brandsList();
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
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          // Padding(padding: const EdgeInsets.only(right: 22.0), child: SvgPicture.asset('assets/icons/share.svg'))
        ],
        titleSpacing: 0,
        title: Text(
          '${widget.cats?.name ?? ''}',
          style: AppTextStyles.appBarTextStylea,
        ),
        // leadingWidth: 1,
        // title: Container(
        //   height: 34,
        //   width: 279,
        //   decoration: BoxDecoration(
        //       color: const Color(0xFFF8F8F8),
        //       borderRadius: BorderRadius.circular(10)),
        //   child: TextField(
        //       controller: searchController,
        //       onChanged: (value) {
        //         if (value.isEmpty) {
        //           BlocProvider.of<SubCatsCubit>(context).subSave();
        //         } else {
        //           BlocProvider.of<SubCatsCubit>(context)
        //               .searchSubCats(value, widget.cats?.id ?? 0);
        //         }
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
              return const Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
            // if (state is NoDataState) {
            //   return Container(
            //     width: MediaQuery.of(context).size.height,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         Container(
            //             margin: EdgeInsets.only(top: 146),
            //             child: Image.asset('assets/icons/no_data.png')),
            //         const Text(
            //           'В ленте нет данных',
            //           style:
            //               TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            //           textAlign: TextAlign.center,
            //         ),
            //         const Text(
            //           'По вашему запросу ничего не найдено',
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w400,
            //               color: Color(0xff717171)),
            //           textAlign: TextAlign.center,
            //         )
            //       ],
            //     ),
            //   );
            //   ;
            // }

            if (state is LoadedState) {
              return ListView(children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 36,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: catChapters.length,
                          itemBuilder: (context, index) {
                            bool isEvenIndex = index % 2 == 0;
                            return InkWell(
                              onTap: () {
                                if (_selectedChapter == index) {
                                  _selectedChapter = -1;
                                  setState(() {});
                                  return;
                                }

                                _selectedChapter = index;
                                setState(() {});
                              },
                              child: Container(
                                width: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _selectedChapter == index
                                      ? AppColors.mainPurpleColor
                                      : AppColors.kWhite,
                                  border: Border(
                                    top: BorderSide(
                                        color: AppColors.mainPurpleColor,
                                        width: 1),
                                    bottom: BorderSide(
                                        color: AppColors.mainPurpleColor,
                                        width: 1),
                                    left: isEvenIndex
                                        ? BorderSide(
                                            color: AppColors.mainPurpleColor,
                                            width: 1)
                                        : BorderSide.none,
                                    right: isEvenIndex
                                        ? BorderSide(
                                            color: AppColors.mainPurpleColor,
                                            width: 1)
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Text(
                                  catChapters[index],
                                  style: AppTextStyles.categoryTextStyle
                                      .copyWith(
                                          color: _selectedChapter == index
                                              ? Colors.white
                                              : AppColors.mainPurpleColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Популярные бренды',
                        style: AppTextStyles.defaultButtonTextStyle,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 64,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: brands.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                brand = brands[index];
                                setState(() {});
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
                                          colors: [
                                            Color(0xFF7D2DFF),
                                            Color(0xFF41DDFF)
                                          ],
                                        )
                                      : null,
                                ),
                                padding: const EdgeInsets.all(
                                    2.2), // толщина границы
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color:
                                        const Color(0xFFF5F4FF), // светлый фон
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image(
                                      image: brands[index].icon != null
                                          ? NetworkImage(
                                              "https://lunamarket.ru/storage/${brands[index].icon}")
                                          : const AssetImage(
                                                  'assets/icons/profile2.png')
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
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 175 / 120,
                      ),
                      itemCount: state.cats.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            GetStorage().write('CatId', widget.cats?.id ?? 0);
                            GetStorage().write('catId', widget.cats?.id ?? 0);

                            GetStorage().write('subCatFilterId',
                                [state.cats[index].id].toString());
                            GetStorage().remove('shopFilterId');

                            context.router.push(ProductsRoute(
                                cats: widget.cats ??
                                    CatsModel(
                                        id: widget.cats?.id ?? 0,
                                        name: widget.cats?.name ?? ''),
                                subCats: state.cats[index]));
                          },
                          child: CatalogListTile(
                            title: '${state.cats[index].name}',
                            credit: 0,
                            bonus: '0',
                            url:
                                "https://lunamarket.ru/storage/${state.cats[index].icon ?? ''}",
                          ),
                        );
                      }),
                ),
              ]);
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          }),
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainBackgroundPurpleColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, left: 8),
            height: 32,
            child: Text(title,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppTextStyles.size13Weight500),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(2), // Толщина градиентной рамки
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mainBackgroundPurpleColor,
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.contain,
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // Чуть меньше внешнего
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
