import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/main/data/model/stories_seller_model.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _progress = 0.0;
    const storyDuration = Duration(seconds: 5);
    const tick = Duration(milliseconds: 50);

    _timer = Timer.periodic(tick, (timer) {
      setState(() {
        _progress += tick.inMilliseconds / storyDuration.inMilliseconds;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _nextStory();
        }
      });
    });
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back();
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _startTimer();
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
          PageView.builder(
            controller: _pageController,
            itemCount: widget.stories.length,
            onPageChanged: _onPageChanged,
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
                      Color(0xD6FF7171), // с прозрачностью 0.84
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

          // Кнопка закрытия
          Positioned(
            top: 48,
            right: 24,
            child: IconButton(
              icon: Image.asset(
                Assets.icons.defaultCloseIcon.path,
                scale: 1.6,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Прогресс-бар
          Positioned(
            top: 32,
            left: 24,
            right: 24,
            child: Row(
              children: List.generate(widget.stories.length, (index) {
                double value;
                if (index < _currentIndex) {
                  value = 1.0; // Пройдено
                } else if (index == _currentIndex) {
                  value = _progress; // Текущий прогресс
                } else {
                  value = 0.0; // Ещё не начат
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: LinearProgressIndicator(
                      value: value,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              }),
            ),
          ),
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
