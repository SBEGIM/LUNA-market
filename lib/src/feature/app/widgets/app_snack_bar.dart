import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppSnackType { success, error, info }

class AppSnackBar {
  static OverlayEntry? _entry;

  static void show(
    BuildContext context,
    String message, {
    AppSnackType type = AppSnackType.error,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Закрыть предыдущий, если висит
    _removeCurrent();

    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay == null) return;

    _entry = OverlayEntry(
      builder: (_) =>
          _SnackHost(message: message, type: type, duration: duration, onDismissed: _removeCurrent),
    );

    // лёгкий тактильный отклик
    HapticFeedback.lightImpact();

    overlay.insert(_entry!);
  }

  static void _removeCurrent() {
    try {
      _entry?.remove();
      _entry = null;
    } catch (_) {
      _entry = null;
    }
  }
}

class _SnackHost extends StatefulWidget {
  const _SnackHost({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismissed,
  });

  final String message;
  final AppSnackType type;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_SnackHost> createState() => _SnackHostState();
}

class _SnackHostState extends State<_SnackHost> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  late final Animation<Offset> _slide = Tween(
    begin: const Offset(0, -0.15),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));
  late final Animation<double> _fade = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);

  @override
  void initState() {
    super.initState();
    _c.forward();

    // держим видимым duration, затем закрываем
    Future.delayed(widget.duration, () async {
      if (!mounted) return;
      await _c.reverse();
      if (mounted) widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top - 35;

    // Цвет и иконка по типу
    late final Color badge;
    late final IconData icon;
    switch (widget.type) {
      case AppSnackType.success:
        badge = const Color(0xFF34C759);
        icon = Icons.check_rounded;
        break;
      case AppSnackType.info:
        badge = const Color(0xFF007AFF);
        icon = Icons.info_rounded;
        break;
      case AppSnackType.error:
      default:
        badge = const Color(0xFFFF3B30);
        icon = Icons.close_rounded;
    }

    return IgnorePointer(
      ignoring: true, // не блокируем жесты под снэком
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, paddingTop + 8, 16, 0),
            child: SlideTransition(
              position: _slide,
              child: FadeTransition(
                opacity: _fade,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 560),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(color: badge, shape: BoxShape.circle),
                          child: Icon(icon, color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: const TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
