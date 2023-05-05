import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/home/data/bloc/popular_shops_cubit.dart';
import '../../../home/data/bloc/popular_shops_state.dart';

class BonusUserPage extends StatefulWidget {
  const BonusUserPage({Key? key}) : super(key: key);

  @override
  State<BonusUserPage> createState() => _BonusUserPageState();
}

class _BonusUserPageState extends State<BonusUserPage> {
  int _selectedIndex = -1;

  @override
  void initState() {
    BlocProvider.of<PopularShopsCubit>(context).popShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Мои бонусы',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
            height: 23,
            child: const Text(
              'Ваши накопленные скидки',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kGray900),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16),
            height: 23,
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: const Text(
              'Магазины',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kGray900),
            ),
          ),
          Container(
            height: 10,
          ),
          Container(
              color: Colors.white,
              child: BlocConsumer<PopularShopsCubit, PopularShopsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadedState) {
                      return Column(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      // устанавливаем индекс выделенного элемента
                                      _selectedIndex = index;
                                    });
                                  },
                                  child: SizedBox(
                                    height: 47,
                                    child: ListTile(
                                      selected: index == _selectedIndex,
                                      leading: Text(
                                        '${state.popularShops[index].name}',
                                        style: const TextStyle(
                                            color: AppColors.kGray900,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      trailing: ClipPath(
                                        clipper: TrapeziumClipper(),
                                        child: Container(
                                          height: 16,
                                          width: 38,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColors.kPrimaryColor),
                                          child: Text(
                                            '${state.popularShops[index].bonus}%',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                        ],
                      );
                    } else {
                      return Container();
                    }
                  })),
          Container(
            height: 10,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width * 0.80, size.height);
    path.lineTo(size.width * 0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
