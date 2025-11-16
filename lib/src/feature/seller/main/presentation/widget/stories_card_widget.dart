import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/main/data/model/stories_seller_model.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;

class StoryScreen extends StatefulWidget {
  final List<SellerStoriesItemModel> stories;

  const StoryScreen({required this.stories, super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  double _progress = 0.0;
  Timer? _timer;
  bool _isPaused = false;

  static const _storyDuration = Duration(seconds: 3);
  static const _tick = Duration(milliseconds: 50);

  @override
  void initState() {
    super.initState();
    _startTimer(resetProgress: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ===== Таймер прогресса =====
  void _startTimer({bool resetProgress = false}) {
    _timer?.cancel();
    if (resetProgress) _progress = 0.0;

    // Если уже на 100% (например, при быстром тапе) — сразу вперед
    if (_progress >= 1.0) {
      _nextStory();
      return;
    }

    _isPaused = false;
    _timer = Timer.periodic(_tick, (timer) {
      setState(() {
        _progress += _tick.inMilliseconds / _storyDuration.inMilliseconds;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _nextStory();
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isPaused = true;
  }

  void _resumeTimer() {
    if (_isPaused) {
      _startTimer(resetProgress: false);
    }
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.linear,
      );
    } else {
      Get.back();
    }
  }

  void _prevStory() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      // в начале — просто держим на первой или закрываем, если хотите
      // Get.back();
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
    _startTimer(resetProgress: true);
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade500,
      child: Container(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Контент сторис
          PageView.builder(
            controller: _pageController,
            itemCount: widget.stories.length,
            onPageChanged: _onPageChanged,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final story = widget.stories[index];
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(4.2373),
                    colors: [
                      Color(0xFFFB62E2),
                      Color(0xD6FF7171),
                      Color(0x00FFF500),
                    ],
                  ),
                ),
                child: ClipRRect(
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                      "https://lunamarket.ru/storage/${story.image}",
                    ),
                    fit: BoxFit.cover,
                    placeholderErrorBuilder: (_, __, ___) =>
                        _buildShimmerPlaceholder(),
                    imageErrorBuilder: (_, __, ___) => const Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                    fadeInDuration: const Duration(milliseconds: 400),
                  ),
                ),
              );
            },
          ),

          // ===== Невидимые области жестов поверх контента =====
          // (ниже прогресс-бара и кнопки закрытия, чтобы те работали)
          // Левая половина — предыдущая сторис; правая — следующая
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _prevStory,
                    onLongPressStart: (_) => _pauseTimer(),
                    onLongPressEnd: (_) => _resumeTimer(),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // мгновенно добиваем прогресс до конца, чтобы логика была единая
                      setState(() => _progress = 1.0);
                      _nextStory();
                    },
                    onLongPressStart: (_) => _pauseTimer(),
                    onLongPressEnd: (_) => _resumeTimer(),
                  ),
                ),
              ],
            ),
          ),

          // Кнопка закрытия

          // Прогресс-бар
          Positioned(
            top: 64,
            left: 16,
            right: 16, // 46 больше не нужен
            child: Row(
              children: [
                // Только прогресс-бары игнорируют тапы
                Expanded(
                  child: IgnorePointer(
                    ignoring: true,
                    child: Row(
                      children: List.generate(widget.stories.length, (index) {
                        final value = index < _currentIndex
                            ? 1.0
                            : (index == _currentIndex ? _progress : 0.0);
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: ClipRRect(
                              // чтобы радиус реально работал
                              borderRadius: BorderRadius.circular(50),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 2,
                                backgroundColor: const Color(0xffC4C4C480),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xffFFFFFFBF)),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    Assets.icons.defaultClosePurpleIcon.path,
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Прозрачная картинка для FadeInImage
final kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
