import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/under_catalog_page.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';

import '../../../home/data/bloc/popular_shops_cubit.dart';
import '../../../home/data/bloc/popular_shops_state.dart';

class ShopsPage extends StatefulWidget {
  ShopsPage({Key? key}) : super(key: key);

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
            Navigator.pop(context);
          }),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: SvgPicture.asset('assets/icons/share.svg'))
        ],
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
              style: TextStyle(
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
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              );
            }
            if (state is LoadingState) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent));
            }

            if (state is LoadedState) {
              return ListView.builder(
                itemCount: state.popularShops.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductsPage(cats: Cats(id: 0, name: '')),
                              ));
                        },
                        child: CatalogListTile(
                          title: '${state.popularShops[index].name}',
                          url:
                              "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
                        ),
                      ),
                      const Divider(
                        color: AppColors.kGray400,
                      ),
                    ],
                  );
                },
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
  const CatalogListTile({
    required this.url,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 20.05,
        width: 20.05,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage("${url}"),
          fit: BoxFit.cover,
        )),
      ),
      title: Text(
        title,
        style: AppTextStyles.catalogTextStyle,
      ),
      trailing:
          SvgPicture.asset('assets/icons/back_menu.svg', height: 12, width: 16),
    );
  }
}
