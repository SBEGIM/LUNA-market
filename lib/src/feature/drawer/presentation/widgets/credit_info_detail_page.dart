import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/bloc/respublic_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/respublic_state.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/credit_info_detail_show_page.dart';

class CreditInfoDetailPage extends StatefulWidget {
  final String title;

  const CreditInfoDetailPage({required this.title, super.key});

  @override
  State<CreditInfoDetailPage> createState() => _CreditInfoDetailPageState();
}

class _CreditInfoDetailPageState extends State<CreditInfoDetailPage> {
  @override
  void initState() {
    BlocProvider.of<RespublicCubit>(context).respublics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.kGray900,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.kPrimaryColor),
        ),
      ),
      body: Container(
        color: AppColors.kBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 12, color: AppColors.kBackgroundColor),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${widget.title} - Для приобретения товаров в рассрочку по нормам Ислама, перейдите по соответсвующей ссылке по вашему Региону прописки.',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              //color: AppColors.kBackgroundColor,
              child: const Text(
                'Выберите регион',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            BlocConsumer<RespublicCubit, RespublicState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    width: 343,
                    height: 60 * state.respublicModel.length.toDouble(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      itemCount: state.respublicModel.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreditInfoDetailShowPage(
                                  id: state.respublicModel[index].id!,
                                  title: widget.title,
                                ),
                              ),
                            );
                          },
                          child: DrawerListTile(text: '${state.respublicModel[index].name}'),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String text;
  const DrawerListTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppTextStyles.drawer2TextStyle),
          SvgPicture.asset('assets/icons/back_menu.svg'),
        ],
      ),
    );
  }
}
