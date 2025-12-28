import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

class MonthSelector extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const MonthSelector({
    super.key,
    required this.value, // 3 / 6 / 12 / 24
    required this.onChanged,
  });

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  final List<String> items = ['3 мес', '6 мес', '12 мес', '24 мес'];
  int selectedIndex = 0;
  int selectedIndexMonth = 3;

  @override
  Widget build(BuildContext context) {
    const double height = 44; // как в дизайне
    const double borderWidth = 2;
    const double gap = 0; // зазор между сегментами
    final double radius = height / 2; // внешняя капсула
    final double innerRadius = radius - borderWidth;

    Alignment _alignmentFor(int index, int len) {
      if (len <= 1) return Alignment.center;
      // -1,  -1/3,  +1/3,  +1  для 4 сегментов
      return Alignment(-1 + (2 * index) / (len - 1), 0);
    }

    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: AppColors.kYellowDark, width: borderWidth),
        ),
        child: Padding(
          padding: const EdgeInsets.all(borderWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(innerRadius),
            child: Stack(
              children: [
                // Пилюля выбора БЕЗ “ступенек”, скруглённая с обеих сторон
                AnimatedAlign(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  alignment: _alignmentFor(selectedIndex, items.length),
                  child: FractionallySizedBox(
                    widthFactor: 1 / items.length,
                    heightFactor: 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      // зазор внутри своего сегмента: по краям только внутренняя сторона
                      margin: EdgeInsets.only(
                        left: selectedIndex == 0 ? 0 : gap,
                        right: selectedIndex == items.length - 1 ? 0 : gap,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kYellowDark,
                        borderRadius: BorderRadius.circular(innerRadius),
                      ),
                    ),
                  ),
                ),

                // Тап-зоны и текст
                Row(
                  children: List.generate(items.length, (i) {
                    final bool isSelected = i == selectedIndex;
                    return Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: i == 0 ? Radius.circular(innerRadius) : Radius.zero,
                            bottomLeft: i == 0 ? Radius.circular(innerRadius) : Radius.zero,
                            topRight: i == items.length - 1
                                ? Radius.circular(innerRadius)
                                : Radius.zero,
                            bottomRight: i == items.length - 1
                                ? Radius.circular(innerRadius)
                                : Radius.zero,
                          ),
                          onTap: () {
                            widget.onChanged([3, 6, 12, 24][i]);
                            setState(() {
                              selectedIndex = i;
                              selectedIndexMonth = const [3, 6, 12, 24][i];
                            });
                          },
                          child: Center(
                            child: Text(
                              items[i],
                              style: isSelected
                                  ? AppTextStyles.size14Weight600
                                  : AppTextStyles.size14Weight500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
