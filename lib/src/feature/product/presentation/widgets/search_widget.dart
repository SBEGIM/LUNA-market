import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color primary;
  final ValueChanged<String>? onSubmitted;

  const SearchField({
    required this.controller,
    required this.focusNode,
    required this.primary,
    this.onSubmitted,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final v = widget.controller.text.isNotEmpty;
      if (v != _hasText) setState(() => _hasText = v);
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      style: AppTextStyles.size18Weight400,
      decoration: InputDecoration(
        hintText: '',
        hintStyle: AppTextStyles.size18Weight400,
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFEDEDED),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: widget.primary, width: 1),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
          maxWidth: 40,
          maxHeight: 40,
        ),
        prefixIcon: Center(
          child: Image.asset(
            Assets.icons.defaultSearchIcon.path,
            height: 20,
            width: 20,
            scale: 2.1,
            color: widget.primary,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 36,
          maxWidth: 36,
          maxHeight: 36,
        ),
        suffixIcon: _hasText
            ? Center(
                child: InkResponse(
                  onTap: () => widget.controller.clear(),
                  radius: 16,
                  child: Image.asset(
                    Assets.icons.defaultClosePurpleIcon.path,
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
