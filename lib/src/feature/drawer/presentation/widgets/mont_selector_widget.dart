import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({super.key});

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  // элементы как в макете
  final List<String> items = ['3 мес', '6 мес', '12 мес', '24 мес'];

  int selectedIndex = 0;
  int selectedIndexMonth = 3; // то, что ты хранишь отдельно

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double height = 28;
        final double radius = 12;
        final double borderWidth = 2;
        final double segmentWidth = constraints.maxWidth / items.length;

        return SizedBox(
          height: height,
          child: Stack(
            children: [
              // 1. Общая капсула с бордером
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: AppColors.kYellowDark, // твой лаймово-жёлтый бордер
                    width: borderWidth,
                  ),
                ),
              ),

              // 2. Жёлтый хайлайт под выбранным сегментом
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                left: selectedIndex * segmentWidth,
                top: 0,
                height: height,
                width: segmentWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.kYellowDark,
                    borderRadius: BorderRadius.only(
                      topLeft: selectedIndex == 0
                          ? Radius.circular(radius)
                          : Radius.circular(0),
                      bottomLeft: selectedIndex == 0
                          ? Radius.circular(radius)
                          : Radius.circular(0),
                      topRight: selectedIndex == items.length - 1
                          ? Radius.circular(radius)
                          : Radius.circular(0),
                      bottomRight: selectedIndex == items.length - 1
                          ? Radius.circular(radius)
                          : Radius.circular(0),
                    ),
                  ),
                ),
              ),

              // 3. Текстовые кнопки сверху (Row с Expanded)
              Row(
                children: List.generate(items.length, (index) {
                  return Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                        topLeft: index == 0
                            ? Radius.circular(radius)
                            : Radius.circular(0),
                        bottomLeft: index == 0
                            ? Radius.circular(radius)
                            : Radius.circular(0),
                        topRight: index == items.length - 1
                            ? Radius.circular(radius)
                            : Radius.circular(0),
                        bottomRight: index == items.length - 1
                            ? Radius.circular(radius)
                            : Radius.circular(0),
                      ),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;

                          // обновляем твоё selectedIndexMonth
                          if (index == 0) {
                            selectedIndexMonth = 3;
                          } else if (index == 1) {
                            selectedIndexMonth = 6;
                          } else if (index == 2) {
                            selectedIndexMonth = 12;
                          } else {
                            selectedIndexMonth = 24;
                          }
                        });
                      },
                      child: Center(
                        child: Text(items[index],
                            style: AppTextStyles.size14Weight500),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
