import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/sub_cats_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/sub_cats_state.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';

import '../../../home/data/model/Cats.dart';

class UnderCatalogPage extends StatefulWidget {
  final Cats cats;
  const UnderCatalogPage({required this.cats, Key? key}) : super(key: key);

  @override
  State<UnderCatalogPage> createState() => _UnderCatalogPageState();
}

class _UnderCatalogPageState extends State<UnderCatalogPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SubCatsCubit>(context).subCats(widget.cats.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
          // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),

          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/back_header.svg'),
          ),
          titleSpacing: 0,
          title: Container(
            width: 311,
            height: 40,
            margin: const EdgeInsets.only(right: 16),
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
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          )),
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

            if (state is LoadedState) {
              return ListView(shrinkWrap: true, children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.kBackgroundColor,
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: Text(
                    '${widget.cats.name}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kGray900),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                    onTap: () {
                      GetStorage().write('CatId', widget.cats.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductsPage(cats: widget.cats)),
                      );
                    },
                    child: const UnderCatalogListTile(
                      title: 'Все товары',
                    )),
                const Divider(
                  color: AppColors.kGray300,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.cats.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                              onTap: () {
                                GetStorage()
                                    .write('CatId', state.cats[index].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductsPage(
                                          cats: state.cats[index])),
                                );
                              },
                              child: UnderCatalogListTile(
                                title: state.cats[index].name.toString(),
                              )),
                          const Divider(
                            color: AppColors.kGray300,
                          )
                        ],
                      );
                    }),
              ]);
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          }),
    );
  }
}

class UnderCatalogListTile extends StatelessWidget {
  final String title;
  const UnderCatalogListTile({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: const EdgeInsets.only(left: 16, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.chanheLangTextStyle,
          ),
          SvgPicture.asset('assets/icons/back_menu.svg', width: 12, height: 14),
        ],
      ),
    );
  }
}
