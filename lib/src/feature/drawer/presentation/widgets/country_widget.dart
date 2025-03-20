import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/country_cubit.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/country_state.dart';
import '../../../../core/common/constants.dart';
import '../../../app/widgets/custom_back_button.dart';

class CountryWidget extends StatefulWidget {
  const CountryWidget({Key? key}) : super(key: key);

  @override
  _CountryWidgetState createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  String? countryName;
  int? countryIndex;
  final _box = GetStorage();

  List<String> country = ['', 'Казахстан', 'Россия', 'Украина', 'Беларусь'];

  @override
  void initState() {
    BlocProvider.of<CountryCubit>(context).country();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            // Navigator.pop(context);
            Get.back(result: countryName);
          }),
        ),
        elevation: 0,
        title: const Text(
          'Выберите страну',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        BlocConsumer<CountryCubit, CountryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedState) {
              return Container(
                color: Colors.white,
                height: 70.00 * state.country.length,
                child: ListView.builder(
                    itemCount: state.country.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              countryIndex = index;
                              countryName = state.country[index].name;
                              _box.write('country_index', countryName);
                              _box.write(
                                  'user_country_id', state.country[index].id);
                              setState(() {
                                countryName;
                                countryIndex;
                              });
                            },
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 13, right: 13, top: 20),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Image.network(
                                    'https://lunamarket.ru/storage/${state.country[index].path}',
                                    height: 30,
                                    width: 30,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const ErrorImageWidget(
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                      width: 280,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${state.country[index].name}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          countryIndex == index
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 20,
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                )
                                              : Container()
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ]),
    );
  }
}
