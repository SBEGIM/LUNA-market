import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onTap;
  final String buttonWord;
  const CustomBackButton({Key? key, required this.onTap, this.buttonWord = 'back_text'})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 2.1),
        ),
      ),
    );
  }
}

class CustomDropButton extends StatelessWidget {
  final Function() onTap;

  const CustomDropButton({Key? key, required this.onTap}) : super(key: key);

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
