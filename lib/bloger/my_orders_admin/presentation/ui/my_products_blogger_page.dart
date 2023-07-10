import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../features/tape/presentation/widgets/anim_search_widget.dart';
import '../../data/bloc/blogger_video_products_cubit.dart';
import '../../data/bloc/blogger_video_products_state.dart';
import '../widgets/show_alert_statictics_widget.dart';
import '../widgets/tape_card_widget.dart';
import 'banner_watch_recently_blogger_page.dart';

class MyProductsBloggerPage extends StatefulWidget {
  const MyProductsBloggerPage({Key? key}) : super(key: key);

  @override
  State<MyProductsBloggerPage> createState() => _MyProductsBloggerPageState();
}

class _MyProductsBloggerPageState extends State<MyProductsBloggerPage> {
  @override
  void initState() {
    BlocProvider.of<BloggerVideoProductsCubit>(context).products('', 4);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool visible0 = false;
    String? title;
    final TextEditingController searchController = TextEditingController();
    bool visible = true;

    TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        actions: [
          AnimSearchBar(
            helpText: 'Поиск..',
            onChanged: (String? value) {
              // BlocProvider.of<TapeCubit>(context)
              //     .tapes(false, false, searchController.text);
            },
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(153, 162, 173, 1)),
            textController: searchController,
            onSuffixTap: () {
              searchController.clear();
            },
            onArrowTap: () {
              visible = !visible;
              // print(visible.toString());
              setState(() {
                visible;
              });
              searchController.clear();
            },
            width: MediaQuery.of(context).size.width,
          ),
        ],
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Мои видео обзоры',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        // shrinkWrap: true,
        children: [
          Container(
            height: 14,
            color: AppColors.kBackgroundColor,
          ),
          BlocConsumer<BloggerVideoProductsCubit, BloggerVideoProductsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ErrorState) {
                  return Center(
                    child: Text(
                      state.message,
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.grey),
                    ),
                  );
                }
                if (state is LoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }

                if (state is LoadedState) {
                  return Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: GridView.builder(
                          padding: const EdgeInsets.only(
                              top: 16, left: 0, right: 0, bottom: 0),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 175,
                                  childAspectRatio: 2 / 3.2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 16),
                          itemCount: state.productModel.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Stack(
                              children: [
                                BannerWatcehRecentlyBloggerPage(
                                    product: state.productModel[index]),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                InkWell(
                                  onTap: () {
                                    showAlertBloggerWidget(
                                        context, state.productModel[index]);
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    margin: const EdgeInsets.only(
                                        top: 8.0, right: 8.0, left: 135),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(
                                      Icons.more_vert_rounded,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }
              })
        ],
      ),
    );
  }
}
