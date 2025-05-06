import "package:flutter/material.dart";

/// Виджет для [CarouselDotsView], отображающий отдельную "точку".
class _Dot extends StatelessWidget {
  /// Активна ли эта точка?
  final bool isActive;

  const _Dot({
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Сделать "растянутый" вид точки, если она активна, с прогрессом внутри точки.

    final color = isActive ? Colors.white : const Color(0x817F8440);

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

/// Виджет, показывающий ряд из "точек" (или "кружочков") для индикации текущего положения в карусели.
class CarouselDotsView extends StatelessWidget {
  /// Общее количество точек.
  final int count;

  /// Индекс выбранной точки.
  final int selectedIndex;

  const CarouselDotsView({
    super.key,
    required this.count,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      count > 0,
      "Count must be greater than 0",
    );
    assert(
      selectedIndex >= 0 && selectedIndex < count,
      "Selected index must be in range of 0 to count - 1",
    );

    // @Zensonaton: Я боялся добавлять background blur при помощи BackdropFilter, поскольку мне кажется,
    // что в таком случае будет использоваться уж слишком много ClipRRect, и я боюсь, что это может
    // вызвать проблемы с производительностью.

    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < count; i++)
          _Dot(
            isActive: i == selectedIndex,
          ),
      ],
    );
  }
}
