import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

import '../../../../../core/constant/generated/assets.gen.dart';

class StoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: const GradientRotation(4.2373),
                colors: [
                  Color(0xFF8FA503),
                  Color(0xFF518F3C),
                ],
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(Assets.images.storyMoney.path),
          ),

          Positioned(
            top: 48,
            right: 24,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Progress indicator (like Instagram stories)
          Positioned(
            top: 32,
            left: 24,
            right: 24,
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.3, // Current progress
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Место для заголовка',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Место для подзаголовка. Место для подзаголовка. Место для подзаголовка',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                  // Spacer(),
                  SizedBox(height: 10),
                  Container(
                    width: 500,
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextButton(
                      onPressed: () {
                        // Handle "Подробнее" action
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'Подробнее',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
