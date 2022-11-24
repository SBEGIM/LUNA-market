import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:haji_market/features/tape/presentation/ui/detail_tape_card_page.dart';

import '../../../app/bloc/navigation_cubit/navigation_cubit.dart';

class TapeCardWidget extends StatelessWidget {
  final TapeModel tape;
  final int index;
  const TapeCardWidget({
    required this.tape,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
            // 'assets/images/tape.png',
            "http://80.87.202.73:8001/storage/${tape.image}"),
        InkWell(
          onTap: () {
            BlocProvider.of<NavigationCubit>(context)
                .emit(DetailTapeState(index));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const Base(
            //             index: 4,
            //           )),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8),
            child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset('assets/icons/play.svg')),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 225),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Text(
            '${tape.shop!.name}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
