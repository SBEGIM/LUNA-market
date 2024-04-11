import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onTap;
  final String buttonWord;
  const CustomBackButton({
    Key? key,
    required this.onTap,
    this.buttonWord = 'back_text',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            // horizontal: 4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF1DC4CF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDropButton extends StatelessWidget {
  final Function() onTap;

  const CustomDropButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            // horizontal: 4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [SvgPicture.asset('assets/icons/cancel.svg')],
          ),
        ),
      ),
    );
  }
}
