import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/color_cubit.dart';
import 'package:haji_market/core/common/constants.dart';
import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../../features/home/data/model/Cats.dart';
import '../../data/bloc/color_state.dart';

class ColorsAdminPage extends StatefulWidget {
  const ColorsAdminPage({Key? key}) : super(key: key);

  @override
  State<ColorsAdminPage> createState() => _ColorsAdminPageState();
}

class _ColorsAdminPageState extends State<ColorsAdminPage> {
  int _selectedIndex = -1;
  Cats? _cat;

  @override
  void initState() {
    BlocProvider.of<ColorCubit>(context).brands();
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
          'Цвета',
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
            child: BlocConsumer<ColorCubit, ColorState>(
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
            if (_cat != null) {
              Get.back(result: _cat);
            }

            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (_cat != null)
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
