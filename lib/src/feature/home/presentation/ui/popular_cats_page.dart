// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:haji_market/src/core/common/constants.dart';
// import 'package:haji_market/src/core/presentation/widgets/shimmer/shimmer_box.dart';
// import 'package:haji_market/src/feature/app/router/app_router.dart';
// import 'package:haji_market/src/feature/drawer/bloc/sub_cats_cubit.dart';
// import 'package:haji_market/src/feature/drawer/bloc/sub_cats_state.dart';
// import 'package:haji_market/src/feature/home/presentation/widgets/gridLayout_popular.dart';

// class PopularCatsHomepage extends StatefulWidget {
//   const PopularCatsHomepage({super.key});

//   @override
//   State<PopularCatsHomepage> createState() => _PopularCatsHomePageState();
// }

// class _PopularCatsHomePageState extends State<PopularCatsHomepage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SubCatsCubit, SubCatsState>(
//       builder: (context, state) {
//         if (state is ErrorState) {
//           return Center(
//             child: Text(state.message, style: const TextStyle(fontSize: 20.0, color: Colors.grey)),
//           );
//         }
//         // if (state is subCatState.LoadingState) {
//         //   return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
//         // }

//         if (state is LoadedState) {
//           return Container(
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Популярное',
//                     style: TextStyle(
//                       color: AppColors.kGray900,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   GridView.builder(
//                     padding: EdgeInsets.zero,
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 0.70,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: state.cats.length >= 6 ? 6 : state.cats.length,
//                     itemBuilder: (BuildContext ctx, index) {
//                       return InkWell(
//                         onTap: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) => UnderCatalogPage(
//                           //           cats: state.cats[index])),
//                           // );
//                           GetStorage().remove('CatId');
//                           GetStorage().remove('subCatFilterId');
//                           GetStorage().remove('shopFilterId');
//                           GetStorage().remove('search');
//                           GetStorage().write('CatId', state.cats[index].id);

//                           context.router.push(ProductsRoute(cats: state.cats[index + 1]));
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(builder: (context) => ProductsPage(cats: state.cats[index])),
//                           // );
//                         },
//                         child: GridOptionsPopular(
//                           layout: GridLayoutPopular(
//                             title: state.cats[index + 1].name,
//                             image: state.cats[index + 1].image,
//                             icon: state.cats[index + 1].icon,
//                             bonus: state.cats[index + 1].bonus ?? 0,
//                             credit: state.cats[index + 1].credit ?? 0,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                   InkWell(
//                     onTap: () {
//                       context.router.push(SubCatalogRoute(catChapters: state.cats[1].catSections));
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => const CatalogPage()),
//                       // );
//                     },
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Все предложения', style: AppTextStyles.kcolorPrimaryTextStyle),
//                         Icon(Icons.arrow_forward_ios, color: AppColors.kPrimaryColor, size: 14),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return Container(
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const ShimmerBox(height: 22, radius: 10),
//                   const SizedBox(height: 16),
//                   GridView.builder(
//                     padding: EdgeInsets.zero,
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 0.65,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: 6,
//                     itemBuilder: (BuildContext ctx, index) {
//                       return const ShimmerBox(height: 90, width: 90, radius: 12);
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
