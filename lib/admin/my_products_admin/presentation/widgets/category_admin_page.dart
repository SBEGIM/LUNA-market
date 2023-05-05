import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/create_product_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/sub_cats_cubit.dart' as subCatCubit;
import 'package:haji_market/features/drawer/data/bloc/sub_cats_state.dart' as subCatState;

import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../../features/home/data/bloc/cats_cubit.dart';
import '../../../../features/home/data/bloc/cats_state.dart';
import '../../../../features/home/data/model/Cats.dart';

class CategoryAdminPage extends StatefulWidget {
  const CategoryAdminPage({Key? key}) : super(key: key);

  @override
  State<CategoryAdminPage> createState() => _CategoryAdminPageState();
}

class _CategoryAdminPageState extends State<CategoryAdminPage> {


  int _selectedIndex = -1;
  int _selectedIndex2 = -1;
  Cats? _subCat ;
  Cats? _cat ;



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
                            child: CircularProgressIndicator(color: Colors.indigoAccent)
                        );
                      }
                      if (state is LoadedState) {
                        return Column(
                          children: [
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
                                onTap: () async{
                                  if(_selectedIndex == index){
                                    setState(() {
                                      _selectedIndex = -1;
                                    });
                                  }else{
                                await BlocProvider.of<subCatCubit.SubCatsCubit>(context).subCats(state.cats[index].id);

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
                                _selectedIndex == index ?
                                Divider(
                                  color: Colors.grey.shade400,
                                ) : Container(),
                                _selectedIndex == index ?
                                BlocConsumer<subCatCubit.SubCatsCubit, subCatState.SubCatsState>(
                                    listener: (context, state) {},

                                    builder: (context, state) {
                                      if (state is subCatState.ErrorState) {
                                        return Center(
                                          child: Text(
                                            state.message,
                                            style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                                          ),
                                        );
                                      }
                                      if (state is subCatState.LoadingState) {
                                        return const Center(
                                            child: CircularProgressIndicator(color: Colors.indigoAccent)
                                        );
                                      }

                                      if (state is subCatState.LoadedState) {
                                        return  ListView.separated(
                                          separatorBuilder: (BuildContext context, int index) =>
                                              Divider(
                                                color: Colors.grey.shade400,
                                              ),
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          // padding: EdgeInsets.all(16),
                                          itemCount: state.cats.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    // устанавливаем индекс выделенного элемента
                                                    _selectedIndex2 = index;
                                                    _subCat= state.cats[index];
                                                  });
                                                },
                                                child: Padding(
                                                    padding: const EdgeInsets.only(
                                                      left: 50.0, top: 0,bottom: 0,right: 17.5
                                                    ),
                                                    child: ListTile(
                                                      contentPadding: const EdgeInsets.only(top: 0,),
                                                      selected: index == _selectedIndex2,
                                                      // leading: SvgPicture.asset('assets/temp/kaz.svg'),
                                                      title: Text(
                                                        state.cats[index].name.toString(),
                                                        style: const TextStyle(
                                                            color: AppColors.kGray900,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                      trailing: _selectedIndex2 == index
                                                          ? SvgPicture.asset(
                                                        'assets/icons/check_circle.svg',
                                                      )
                                                          : SvgPicture.asset(
                                                        'assets/icons/circle.svg',
                                                      ),
                                                    )));
                                          },
                                        );
                                      }else {
                                        return const Center(
                                            child: CircularProgressIndicator(color: Colors.indigoAccent)
                                        );
                                      }
                                    })
                                    : Container()
                              ],
                            );
                          },
                        ),
                      ]);
                      }else {
                        return const Center(
                            child: CircularProgressIndicator(color: Colors.indigoAccent)
                        );
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

            if(_cat != null && _subCat != null){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProductPage(cat: _cat!, subCat: _subCat!)),
              );
            }

            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  (_cat != null && _subCat != null) ? AppColors.kPrimaryColor :  AppColors.steelGray,
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
