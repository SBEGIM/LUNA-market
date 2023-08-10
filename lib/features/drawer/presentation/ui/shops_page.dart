import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';

import '../../../home/data/bloc/popular_shops_cubit.dart';
import '../../../home/data/bloc/popular_shops_state.dart';

@RoutePage()
class ShopsPage extends StatefulWidget {
  const ShopsPage({Key? key}) : super(key: key);

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomBackButton(onTap: () {
            context.router.pop();
          }),
        ),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 22.0), child: SvgPicture.asset('assets/icons/share.svg'))
        ],
        // leadingWidth: 1,
        title: Container(
          height: 34,
          width: 279,
          decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
          child: TextField(
              controller: searchController,
              onChanged: (value) {
                BlocProvider.of<PopularShopsCubit>(context).searchShops(value);

                // if (searchController.text.isEmpty)
                //   BlocProvider.of<CityCubit>(context)
                //       .cities(value);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.kGray300,
                ),
                hintText: 'Поиск',
                hintStyle: TextStyle(
                  color: AppColors.kGray300,
                  fontSize: 18,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              )),
        ),
      ),
      body: BlocConsumer<PopularShopsCubit, PopularShopsState>(
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

            if (state is LoadedState) {
              return Container(
                margin: const EdgeInsets.only(top: 12, left: 15, right: 15),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 0.65, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    itemCount: state.popularShops.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.router.push(ProductsRoute(cats: Cats(id: 0, name: '')));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           ProductsPage(cats: Cats(id: 0, name: '')),
                          //     ));
                        },
                        child: ShopsListTile(
                          title: '${state.popularShops[index].name}',
                          credit: state.popularShops[index].credit ?? false,
                          bonus: '${state.popularShops[index].bonus}',
                          url: "http://185.116.193.73/storage/${state.popularShops[index].image ?? ''}",
                        ),
                      );
                    }),
              );
              // return ListView.builder(
              //   itemCount: state.popularShops.length,
              //   itemBuilder: (context, index) {
              //     return Column(
              //       children: [
              //         InkWell(
              //           onTap: () {

              //           },
              //           child: (
              //             title: '${state.popularShops[index].name}',
              //             url:
              //                 "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
              //           ),
              //         ),
              //         const Divider(
              //           color: AppColors.kGray400,
              //         ),
              //       ],
              //     );
              //   },
              // );
            } else {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          }),
    );
  }
}

class ShopsListTile extends StatelessWidget {
  final String title;
  final String url;
  final String bonus;
  final bool credit;

  const ShopsListTile({
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
        color: const Color.fromARGB(15, 227, 9, 9),
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
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: NetworkImage(
                          url,
                        ),
                        fit: BoxFit.contain),
                    color: const Color(0xFFF0F5F5)),
                // child: Image.network(
                //   "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
                //   width: 70,
                // ),
              ),
              // Container(
              //   height: 90,
              //   width: 90,
              //   decoration: BoxDecoration(
              //       borderRadius:
              //           BorderRadius.circular(8),
              //       image: DecorationImage(
              //         image: NetworkImage(
              //             "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}"),
              //         fit: BoxFit.cover,
              //       )),
              // ),
              if (credit == true)
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
              Container(
                width: 46,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                margin: const EdgeInsets.only(top: 105, left: 4),
                alignment: Alignment.center,
                child: const Text(
                  "10% Б",
                  style: AppTextStyles.bannerTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 130, left: 4),
                alignment: Alignment.center,
                child: Text(title, style: AppTextStyles.categoryTextStyle),
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
          // Text(state.popularShops[index].name!,
          //     style: AppTextStyles.categoryTextStyle),
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
