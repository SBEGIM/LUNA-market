import 'package:flutter/material.dart';

/// Глобальный свитч без бордера трека (M3), со статичным белым кружком.
/// По умолчанию размер 51×31, как в твоём макете.
/// Пример:
/// AppSwitch(
///   value: isSwitched,
///   onChanged: (v) => setState(() => isSwitched = v),
/// )
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,

    // Размер
    this.width = 51,
    this.height = 31,

    // Цвета
    this.activeTrackColor =
        const Color(0xFF6C45F3), // AppColors.mainPurpleColor
    this.inactiveTrackColor = const Color(0x30808080),
    this.thumbColor = Colors.white,

    // Поведение/стили
    this.useMaterial3 = true,
    this.compactHitTarget =
        true, // уменьшает кликабельную область до реального размера
    this.staticThumb = true, // фиксированный круглый thumb
    this.thumbIconSize = 24,

    // Дополнительно
    this.mouseCursor,
    this.autofocus = false,
    this.splashRadius,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  final double width;
  final double height;

  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;

  final bool useMaterial3;
  final bool compactHitTarget;
  final bool staticThumb;
  final double thumbIconSize;

  final MouseCursor? mouseCursor;
  final bool autofocus;
  final double? splashRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      useMaterial3: useMaterial3,
      switchTheme: SwitchThemeData(
        // убираем бордер у трека
        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        trackOutlineWidth: MaterialStateProperty.all(0),
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: Theme(
        data: theme,
        child: Switch(
          value: value,
          onChanged: onChanged, // передай null, чтобы задизейблить

          activeColor: thumbColor, // цвет круглого бегунка (ON)
          inactiveThumbColor: thumbColor, // цвет круглого бегунка (OFF)
          activeTrackColor: activeTrackColor, // цвет дорожки (ON)
          inactiveTrackColor: inactiveTrackColor, // цвет дорожки (OFF)

          materialTapTargetSize: compactHitTarget
              ? MaterialTapTargetSize.shrinkWrap
              : MaterialTapTargetSize.padded,

          mouseCursor: mouseCursor,
          autofocus: autofocus,
          splashRadius: splashRadius,

          // статичный белый кружок (без «дыхания»)
          thumbIcon: staticThumb
              ? MaterialStateProperty.all(
                  Icon(Icons.circle, size: thumbIconSize, color: thumbColor),
                )
              : null,
        ),
      ),
    );
  }
}
