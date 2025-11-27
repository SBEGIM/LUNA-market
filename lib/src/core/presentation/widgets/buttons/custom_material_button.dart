import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    required this.child,
    super.key,
    this.materialColor = Colors.transparent,
    this.borderRadiusGeometry = const BorderRadius.all(Radius.circular(16)),
    this.onTap,
    this.onLongPress,
    this.padding = EdgeInsets.zero,
  });
  final Color materialColor;
  final BorderRadius? borderRadiusGeometry;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Material(
    color: materialColor,
    borderRadius: borderRadiusGeometry,
    child: InkWell(
      borderRadius: borderRadiusGeometry,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(padding: padding, child: child),
    ),
  );
}
