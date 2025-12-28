import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/bloc/credit_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/credit_state.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/credit_webview.dart';

class CreditInfoDetailShowPage extends StatefulWidget {
  final int id;
  final String title;

  const CreditInfoDetailShowPage({required this.id, required this.title, super.key});

  @override
  State<CreditInfoDetailShowPage> createState() => _CreditInfoDetailShowPageState();
}

class _CreditInfoDetailShowPageState extends State<CreditInfoDetailShowPage> {
  @override
  void initState() {
    BlocProvider.of<CreditCubit>(context).credits(widget.id);

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
                '${widget.title} - Выберите Кампанию и внимательно ознакомитесь с условиями рассрочки.',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            BlocConsumer<CreditCubit, CreditState>(
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

                if (state is LoadedState) {
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.creditModel.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    CreditWebviewPage(url: state.creditModel[index].url.toString()),
                              ),
                            );
                          },
                          child: Container(
                            height: 72,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                // Add one stop for each color. Stops should increase from 0 to 1
                                // stops: [0.2, 0.4, ],
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Color(0xff80C2DA),
                                  Color(0xffC2E59C),
                                  // Color(0xffC2E59C),
                                  // Color(0xff64B3F4),
                                ],
                              ),
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.creditModel[index].title.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    state.creditModel[index].description.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
