import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/under_catalog_page.dart';

import '../../../home/data/model/Cats.dart';
import '../../data/bloc/sub_cats_cubit.dart';
import '../../data/bloc/sub_cats_state.dart';
@RoutePage()
class SubCatalogPage extends StatefulWidget {
  final Cats cats;

  const SubCatalogPage({Key? key, required this.cats}) : super(key: key);

  @override
  State<SubCatalogPage> createState() => _SubCatalogPageState();
}

class _SubCatalogPageState extends State<SubCatalogPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SubCatsCubit>(context).subCats(widget.cats.id);
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
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: SvgPicture.asset('assets/icons/share.svg'))
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
                      .searchSubCats(value, widget.cats.id);
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
              return Container(
                margin: const EdgeInsets.only(top: 12, left: 15, right: 15),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: state.cats.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          GetStorage().write('CatId', widget.cats.id);
                          GetStorage().write('subCatFilterId',
                              [state.cats[index].id].toString());
                          GetStorage().remove('shopFilterId');
                          context.router.push(ProductsRoute(cats: state.cats[index],));
                          // Get.to(() => ProductsPage(
                          //       cats: state.cats[index],
                          //     ));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ProductsPage(
                          //               cats: state.cats[index],
                          //             )));
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           UnderCatalogPage(cats: state.cats[index])),
                          // );
                        },
                        child: CatalogListTile(
                          title: '${state.cats[index].name}',
                          credit: 0,
                          bonus: '0',
                          url:
                              "http://185.116.193.73/storage/${state.cats[index].icon ?? ''}",
                        ),
                      );
                    }),
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
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(15, 227, 9, 9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, left: 10),
                alignment: Alignment.center,
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                        image: NetworkImage(
                          "${url}",
                        ),
                        fit: BoxFit.contain),
                    color: const Color(0xFFF0F5F5)),
                // child: Image.network(
                //   "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
                //   width: 70,
                // ),
              ),
              // Container(
              //   height: 154,
              //   width: 108,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       image: DecorationImage(
              //         image: NetworkImage(
              //             "http://80.87.202.73:8001/storage/${layout!.image!}"),
              //         fit: BoxFit.cover,
              //       )),

              //   // child: CircleAvatar(),
              // ),
              if (credit == 1)
                Container(
                  width: 46,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(31, 196, 207, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.only(top: 80, left: 4),
                  alignment: Alignment.center,
                  child: const Text(
                    "0·0·12",
                    style: AppTextStyles.bannerTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              // Container(
              //   width: 46,
              //   height: 22,
              //   decoration: BoxDecoration(
              //     color: Colors.black,
              //     borderRadius: BorderRadius.circular(6),
              //   ),
              //   margin: const EdgeInsets.only(top: 105, left: 4),
              //   alignment: Alignment.center,
              //   child: Text(
              //     "${layout!.bonus.toString()}% Б",
              //     style: AppTextStyles.bannerTextStyle,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 130, left: 4),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: AppTextStyles.categoryTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          // Center(
          //   child: Image.asset(
          //
          //   ),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // Flexible(
          //     child:
        ],
      ),
    );
    // ListTile(
    //   horizontalTitleGap: 0,
    //   leading: Container(
    //     height: 20.05,
    //     width: 20.05,
    //     decoration: BoxDecoration(
    //         image: DecorationImage(
    //       image: NetworkImage("${url}"),
    //       fit: BoxFit.cover,
    //     )),
    //   ),
    //   title: Text(
    //     title,
    //     style: AppTextStyles.catalogTextStyle,
    //   ),
    //   trailing:
    //       SvgPicture.asset('assets/icons/back_menu.svg', height: 12, width: 16),
    // );
  }
}
