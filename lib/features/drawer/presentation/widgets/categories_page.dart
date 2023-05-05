import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/common/constants.dart';
import '../../../app/widgets/custom_back_button.dart';
import '../../../home/data/bloc/cats_cubit.dart';
import '../../../home/data/bloc/cats_state.dart';
import '../../../home/data/model/Cats.dart';
import 'package:haji_market/features/drawer/data/bloc/sub_cats_cubit.dart'
    as subCatCubit;
import 'package:haji_market/features/drawer/data/bloc/sub_cats_state.dart'
    as subCatState;

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _selectedIndex = -1;
  //int _selectedIndex2 = -1;
  Cats? _subCat;
  Cats? _cat;

  final List<int> _selectedListIndex2 = [];

  @override
  void initState() {
    BlocProvider.of<CatsCubit>(context).cats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Категории',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            color: Colors.white,
            child: BlocConsumer<CatsCubit, CatsState>(
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
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent));
                  }
                  if (state is LoadedState) {
                    return Column(children: [
                      Divider(
                        color: Colors.grey.shade400,
                      ),
                      ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          color: Colors.grey.shade400,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.cats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    if (_selectedIndex == index) {
                                      setState(() {
                                        _selectedIndex = -1;
                                      });
                                    } else {
                                      await BlocProvider.of<
                                              subCatCubit.SubCatsCubit>(context)
                                          .subCats(state.cats[index].id);

                                      setState(() {
                                        // устанавливаем индекс выделенного элемента
                                        _selectedIndex = index;
                                        _cat = state.cats[index];
                                      });
                                    }
                                  },
                                  child: ListTile(
                                    selected: index == _selectedIndex,
                                    // leading: SvgPicture.asset('assets/temp/kaz.svg'),
                                    title: Text(
                                      state.cats[index].name.toString(),
                                      style: const TextStyle(
                                          color: AppColors.kGray900,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: _selectedIndex == index
                                        ? SvgPicture.asset(
                                            'assets/icons/check_circle.svg',
                                          )
                                        : SvgPicture.asset(
                                            'assets/icons/circle.svg',
                                          ),
                                  )),
                              _selectedIndex == index
                                  ? Divider(
                                      color: Colors.grey.shade400,
                                    )
                                  : Container(),
                              _selectedIndex == index
                                  ? BlocConsumer<subCatCubit.SubCatsCubit,
                                          subCatState.SubCatsState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        if (state is subCatState.ErrorState) {
                                          return Center(
                                            child: Text(
                                              state.message,
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.grey),
                                            ),
                                          );
                                        }
                                        if (state is subCatState.LoadingState) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.indigoAccent));
                                        }

                                        if (state is subCatState.LoadedState) {
                                          return ListView.separated(
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    Divider(
                                              color: Colors.grey.shade400,
                                            ),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            // padding: EdgeInsets.all(16),
                                            itemCount: state.cats.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      // устанавливаем индекс выделенного элемента
                                                      // _selectedIndex2 = index;
                                                      //_selectedListIndex2
                                                      if (_selectedListIndex2
                                                          .contains(index)) {
                                                        _selectedListIndex2
                                                            .remove(index);
                                                      } else {
                                                        _selectedListIndex2
                                                            .add(index);
                                                      }
                                                      GetStorage().write(
                                                          'subCatFilterId',
                                                          _selectedListIndex2
                                                              .toString());

                                                      _subCat =
                                                          state.cats[index];
                                                    });
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 50.0,
                                                              top: 0,
                                                              bottom: 0,
                                                              right: 17.5),
                                                      child: ListTile(
                                                        contentPadding:
                                                            const EdgeInsets.only(
                                                          top: 0,
                                                        ),
                                                        selected:
                                                            _selectedListIndex2
                                                                .contains(
                                                                    index),

                                                        // leading: SvgPicture.asset('assets/temp/kaz.svg'),
                                                        title: Text(
                                                          state.cats[index].name
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .kGray900,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        trailing:
                                                            _selectedListIndex2
                                                                    .contains(
                                                                        index)
                                                                ? SvgPicture
                                                                    .asset(
                                                                    'assets/icons/check_circle.svg',
                                                                  )
                                                                : SvgPicture
                                                                    .asset(
                                                                    'assets/icons/circle.svg',
                                                                  ),
                                                      )));
                                            },
                                          );
                                        } else {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.indigoAccent));
                                        }
                                      })
                                  : Container()
                            ],
                          );
                        },
                      ),
                    ]);
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent));
                  }
                }),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            if (_cat != null && _subCat != null) {
              Get.back(result: _subCat!.name);
            }

            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (_cat != null && _subCat != null)
                    ? AppColors.kPrimaryColor
                    : AppColors.steelGray,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Готово',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}

//   int _selectedIndexSort = -1;
//   String subCatName = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: InkWell(
//           onTap: () {
//             Get.back(result: subCatName);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.kPrimaryColor,
//           ),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               _selectedIndexSort = -1;
//               setState(() {});
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(top: 20.0, right: 15),
//               child: Text(
//                 'Сбросить',
//                 style: TextStyle(color: AppColors.kPrimaryColor),
//               ),
//             ),
//           )
//         ],
//         title: const Text(
//           'Категории',
//           style: TextStyle(
//               color: AppColors.kGray900,
//               fontSize: 16,
//               fontWeight: FontWeight.w500),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: BlocConsumer<SubCatsCubit, SubCatsState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               if (state is ErrorState) {
//                 return Center(
//                   child: Text(
//                     state.message,
//                     style: TextStyle(fontSize: 20.0, color: Colors.grey),
//                   ),
//                 );
//               }
//               if (state is LoadedState) {
//                 return Container(
//                   height: 225,
//                   child: ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: state.cats.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Column(
//                         children: [
//                           const Divider(
//                             height: 1,
//                           ),
//                           SizedBox(
//                             height: 55,
//                             child: InkWell(
//                                 onTap: () {
//                                   BlocProvider.of<ProductCubit>(context)
//                                       .products();

//                                   setState(() {
//                                     // устанавливаем индекс выделенного элемента
//                                     _selectedIndexSort = index;
//                                     subCatName =
//                                         state.cats[index].name.toString();
//                                   });
//                                 },
//                                 child: ListTile(
//                                   selected: index == _selectedIndexSort,
//                                   leading: Text(
//                                     '${state.cats[index].name}',
//                                     style: AppTextStyles.appBarTextStyle,
//                                   ),
//                                   trailing: _selectedIndexSort == index
//                                       ? SvgPicture.asset(
//                                           'assets/icons/check_circle.svg',
//                                         )
//                                       : SvgPicture.asset(
//                                           'assets/icons/check_circle_no_selected.svg',
//                                         ),
//                                 )),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 return const Center(
//                     child:
//                         CircularProgressIndicator(color: Colors.indigoAccent));
//               }
//             }),
//       ),
//       bottomSheet: Container(
//         color: Colors.white,
//         padding:
//             const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
//         child: InkWell(
//           onTap: () {
//             Get.back(result: subCatName);
//           },
//           child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: AppColors.kPrimaryColor,
//               ),
//               width: MediaQuery.of(context).size.width,
//               padding: const EdgeInsets.all(16),
//               child: const Text(
//                 'Готово',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16),
//                 textAlign: TextAlign.center,
//               )),
//         ),
//       ),
//     );
//   }
// }
