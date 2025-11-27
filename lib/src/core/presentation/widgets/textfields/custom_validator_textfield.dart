import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haji_market/src/core/presentation/widgets/error/error_text_widget.dart';
import 'package:haji_market/src/core/presentation/widgets/textfields/custom_textfield.dart';
import 'package:haji_market/src/core/theme/resources.dart';
// import 'package:haji_market/src/feature/auth/presentation/widgets/password_eye_suffix_icon.dart';

class CustomValidatorTextfield extends StatelessWidget {
  const CustomValidatorTextfield({
    super.key,
    required this.controller,
    this.validator,
    required this.valueListenable,
    this.onChanged,
    this.hintText,
    this.obscureText,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    this.autofocus = false,
    this.readOnly = false,
    this.keyboardType,
    this.prefixIcon,
    this.contentPadding,
    this.prefixIconConstraints,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueNotifier<String?> valueListenable;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? hintText;
  final ValueNotifier<bool>? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool autofocus;
  final bool readOnly;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? prefixIconConstraints;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, v, c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              contentPadding: contentPadding,
              // prefix: prefix,
              prefixIcon: prefixIcon,
              prefixIconConstraints: prefixIconConstraints,
              fillColor: v == null ? null : AppColors.muteRed,
              obscureText: obscureText?.value,
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              autofocus: autofocus,
              readOnly: readOnly,
              inputFormatters: inputFormatters,
              hintText: hintText,
              keyboardType: keyboardType,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              validator: validator,
              suffixIcon: suffixIcon,
              // suffixIcon: obscureText != null
              //     ? PasswordEyeSuffixIcon(
              //         valueListenable: obscureText!,
              //         hasError: valueListenable.value != null,
              //       )
              //     : suffixIcon,
            ),
            // const Gap(4),
            Align(
              alignment: Alignment.centerLeft,
              child: ErrorTextWidget(text: valueListenable.value),
            ),
          ],
        );
      },
    );
  }
}
