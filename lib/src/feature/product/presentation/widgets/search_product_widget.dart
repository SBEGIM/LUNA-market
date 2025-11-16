import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart'
    as productCubit;
import 'package:haji_market/src/feature/product/presentation/widgets/product_widget.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';

@RoutePage()
class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final _focus = FocusNode();

  TextEditingController searchController = TextEditingController();

  bool _searchOpen = false;
  bool _hasText = false;
  void _openSearch() {
    setState(() => _searchOpen = true);
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  void _closeSearch() {
    searchController.clear();
    _focus.unfocus();
    setState(() => _searchOpen = false);

    final filters = context.read<FilterProvider>();
    filters.resetAll();

    BlocProvider.of<productCubit.ProductCubit>(context).products(filters);

    context.router.pop();
  }

  @override
  void initState() {
    _openSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: !_searchOpen,
          leadingWidth: _searchOpen ? 0 : null,
          titleSpacing: _searchOpen ? 0 : null,

          surfaceTintColor: AppColors.kWhite,

          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: _searchOpen
                ? Padding(
                    key: const ValueKey('search'),
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: searchController,
                        focusNode: _focus,
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          final filters = context.read<FilterProvider>();
                          filters.setSearch(searchController.text);
                          context
                              .read<productCubit.ProductCubit>()
                              .products(filters);
                        },
                        // onSubmitted: (q) {},
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '',
                          isDense: true,
                          filled: true,
                          fillColor: const Color(0xFFEDEDED),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: AppColors.mainPurpleColor, width: 1),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                            maxWidth: 40,
                            maxHeight: 40,
                          ),
                          prefixIcon: Center(
                            child: Image.asset(
                              Assets.icons.defaultSearchIcon.path,
                              height: 20,
                              width: 20,
                              color: AppColors.mainPurpleColor,
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                            maxWidth: 40,
                            maxHeight: 40,
                          ),
                          suffixIcon: _hasText
                              ? Center(
                                  child: InkWell(
                                    onTap: () => searchController.clear(),
                                    radius: 16,
                                    child: Image.asset(
                                      Assets.icons.defaultClosePurpleIcon.path,
                                      height: 20,
                                      width: 20,
                                      scale: 1.9,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  )
                : Text(
                    '',
                    style: AppTextStyles.size18Weight600,
                  ),
          ),

          actionsPadding: EdgeInsets.only(right: 8),
          actions: _searchOpen
              ? [
                  TextButton(
                    onPressed: _closeSearch,
                    child: Text('Отменить',
                        style: TextStyle(
                            color: AppColors.mainPurpleColor,
                            fontWeight: FontWeight.w600)),
                  ),
                ]
              : [
                  IconButton(
                    icon: Image.asset(
                      Assets.icons.defaultSearchIcon.path,
                      scale: 2.1,
                      height: 24,
                      width: 24,
                      color: Colors.black,
                    ),
                    onPressed: _openSearch,
                    tooltip: 'Поиск',
                  ),
                ],

          backgroundColor: Colors.white,
          elevation: 0,
          leading: _searchOpen
              ? null
              : IconButton(
                  onPressed: () {
                    final filters = context.read<FilterProvider>();

                    filters.resetAll();
                    context.router.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),

          // Container(
          //   width: 311,
          //   height: 40,
          //   alignment: Alignment.center,
          //   margin: const EdgeInsets.only(right: 16),
          //   decoration: BoxDecoration(
          //       color: const Color(0xFFF8F8F8),
          //       borderRadius: BorderRadius.circular(10)),
          //   child: TextField(
          //     controller: searchController,
          //     onChanged: (value) {
          //       GetStorage().write('search', value);

          //       BlocProvider.of<productCubit.ProductCubit>(context).products();
          //     },
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.all(4),
          //       suffixIconConstraints:
          //           BoxConstraints(maxHeight: 20, maxWidth: 20),
          //       prefixIcon: SizedBox(
          //         height: 20,
          //         width: 20,
          //         child: Image.asset(
          //           Assets.icons.defaultSearchIcon.path,
          //           scale: 3.1,
          //           height: 20,
          //           width: 20,
          //         ),
          //       ),
          //       hintText: 'Поиск',
          //       hintMaxLines: 1,
          //       hintStyle: TextStyle(
          //           color: AppColors.kGray300,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500),
          //       border: InputBorder.none,
          //     ),
          //     style: const TextStyle(
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ),
        body: CustomScrollView(slivers: [const ProductWidget()]));
  }
}
