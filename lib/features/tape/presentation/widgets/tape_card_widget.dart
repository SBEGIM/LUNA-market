import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/tape/presentation/ui/detail_tape_card_page.dart';

class TapeCardWidget extends StatelessWidget {
  const TapeCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/tape.png',
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent.withOpacity(0.4),
            child: const Text(
              'ZARA',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        InkWell(
          onTap: (){
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  DetailTapeCardPage()),
  );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8),
            child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset('assets/icons/play.svg')),
          ),
        ),
      ],
    );
  }
}