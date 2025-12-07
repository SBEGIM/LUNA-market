import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/seller/tape_admin/data/cubit/tape_admin_state.dart';
import 'package:haji_market/src/core/common/constants.dart';
import '../../data/cubit/tape_admin_cubit.dart';

@RoutePage()
class TapeAdminPage extends StatefulWidget {
  const TapeAdminPage({super.key});

  @override
  State<TapeAdminPage> createState() => _TapeAdminPageState();
}

class _TapeAdminPageState extends State<TapeAdminPage> {
  final List<Map> myProducts = List.generate(
    6,
    (index) => {"id": index, "name": "Product "},
  ).toList();

  final int _value = 1;

  @override
  void initState() {
    BlocProvider.of<TapeAdminCubit>(context).tapes(false, false, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: const Icon(
        //   Icons.arrow_back_ios,
        //   color: AppColors.kPrimaryColor,
        // ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: Icon(Icons.search, color: AppColors.kPrimaryColor),
          ),
        ],
        title: const Text("Мои видео", style: AppTextStyles.appBarTextStylea),
      ),
      body: BlocConsumer<TapeAdminCubit, TapeAdminState>(
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
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
          if (state is NoDataState) {
            return SizedBox(
              width: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 146),
                    child: Image.asset('assets/icons/no_data.png'),
                  ),
                  const Text(
                    'В ленте нет данных',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'По вашему запросу ничего не найдено',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff717171),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is LoadedState) {
            return Container();
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        },
      ),
    );
  }
}
