import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/city_cubit.dart';

import '../../data/bloc/city_state.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  int _selectedIndex = -1;

  String? city;

  @override
  void initState() {
    BlocProvider.of<CityCubit>(context).cities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Населенный пункт',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            // Navigator.pop(context);
            Get.back(result: city ?? 'Не выбрано');
          }),
        ),
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 8,
            color: Colors.white,
          ),
          BlocConsumer<CityCubit, CityState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return Container(
                    color: Colors.white,
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.city.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                // устанавливаем индекс выделенного элемента
                                _selectedIndex = index;
                                city = state.city[index].name;
                                GetStorage().write('user_city_id',
                                    state.city[index].id.toString());
                              });
                            },
                            child: SizedBox(
                              height: 47,
                              child: ListTile(
                                selected: index == _selectedIndex,
                                leading: Text(
                                  "${state.city[index].name}",
                                  style: const TextStyle(
                                      color: AppColors.kGray900,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),

                                trailing: _selectedIndex == index
                                    ? SvgPicture.asset(
                                        'assets/icons/check_circle.svg')
                                    : const SizedBox(),

                                // title: Text("List item $index"));
                              ),
                            ),
                          );
                        }),
                  );
                }
                if (state is NodataState) {
                  return Container(
                    width: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 146),
                            child: Image.asset('assets/icons/no_data.png')),
                        const Text(
                          'Для этой страны не добавлены города',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'В ближайшие время мы обновим список городов',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff717171)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
