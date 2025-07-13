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

@RoutePage()
class SubCatalogPage extends StatefulWidget {
  final CatsModel? cats;

  const SubCatalogPage({Key? key, this.cats}) : super(key: key);

  @override
  State<SubCatalogPage> createState() => _SubCatalogPageState();
}

class _SubCatalogPageState extends State<SubCatalogPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SubCatsCubit>(context).subCats(widget.cats?.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          icon: SvgPicture.asset('assets/icons/back_header.svg'),
        ),
        actions: [
          // Padding(padding: const EdgeInsets.only(right: 22.0), child: SvgPicture.asset('assets/icons/share.svg'))
        ],
        titleSpacing: 0,
        // leadingWidth: 1,
        title: Container(
          height: 34,
          width: 279,
          decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isEmpty) {
                  BlocProvider.of<SubCatsCubit>(context).subSave();
                } else {
                  BlocProvider.of<SubCatsCubit>(context)
                      .searchSubCats(value, widget.cats?.id ?? 0);
                }
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.kGray300,
                ),
                hintText: 'Поиск',
                hintStyle: TextStyle(
                  color: AppColors.kGray300,
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              )),
        ),
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
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12, left: 15, right: 15),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 114 / 120,
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
                ],
              );
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
                style: AppTextStyles.categoryTextStyle),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.network(
              "${url}",
              height: 80,
              width: 80,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 80,
                  width: 80,
                  child: Shimmer(
                    child: Image.asset(Assets.icons.loaderMain.path),
                  ),
                );
                ;
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[100],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
