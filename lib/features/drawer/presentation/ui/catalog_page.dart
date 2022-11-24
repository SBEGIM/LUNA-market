import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/drawer/presentation/widgets/under_catalog_page.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';

import '../../../home/data/bloc/cats_cubit.dart';
import '../../../home/data/bloc/cats_state.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  TextEditingController searchController = TextEditingController();

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
            Navigator.pop(context);
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
                  BlocProvider.of<CatsCubit>(context).saveCats();
                } else {
                  BlocProvider.of<CatsCubit>(context).searchCats(value);
                }

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
      body: BlocConsumer<CatsCubit, CatsState>(
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
                itemCount: state.cats.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (index == 0) const SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UnderCatalogPage(cats: state.cats[index])),
                          );
                        },
                        child: CatalogListTile(
                          title: '${state.cats[index].name}',
                          url:
                              "http://80.87.202.73:8001/storage/${state.cats[index].icon!}",
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
