import "dart:ui";

import "package:flutter/material.dart";

/// Класс, который описывает элемент навигации в нижней навигационной панели.
class NavigationBarItem {
  /// Текст, отображаемый в этом элементе навигации.
  final String? label;

  /// Иконка.
  final IconData icon;

  const NavigationBarItem({
    this.label,
    required this.icon,
  });
}

/// Виджет для [BottomNavigationBar], отображающий отдельный элемент навигации.
class NavigationBarItemWidget extends StatelessWidget {
  /// Текст, отображаемый в этом элементе навигации.
  final String label;

  /// Иконка.
  final IconData icon;

  /// Указывает, активен ли этот элемент навигации.
  final bool isActive;

  /// Действие, выполняемое при нажатии на этот элемент навигации.
  final VoidCallback? onPressed;

  const NavigationBarItemWidget({
    super.key,
    required this.label,
    required this.icon,
    this.isActive = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor =
        isActive ? const Color(0xff497EE0) : const Color(0xffC7C5CE);
    final textColor =
        isActive ? const Color(0xff497EE0) : const Color(0xff959398);

    // @Zensonaton: здесь у меня не получилось по какой-то причине использовать точно такие же значения размеров, и я не уверен почему.

    return MouseRegion(
      cursor: onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 36,
                width: 36,
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Виджет, который отображает нижнюю навигационную панель приложения.
class BottomNavigationBar extends StatelessWidget {
  /// Высота этого виджета без учёта нижней системной навигационной панели.
  ///
  /// Воспользуйтесь методом [getHeightWithPadding] для получения высоты с учётом навигационной панели.
  static const double height = 67;

  /// Возвращает высоту этого виджета с учётом нижней системной навигационной панели.
  static double getHeightWithPadding(BuildContext context) =>
      height + MediaQuery.viewPaddingOf(context).bottom;

  /// [BorderRadius], используемый для этого виджета.
  static const BorderRadius borderRadius = BorderRadius.vertical(
    top: Radius.circular(20),
  );

  /// Список из элементов навигации типа [NavigationBarItem], отображаемых в этом виджете.
  final List<NavigationBarItem> items;

  /// Выбранный элемент навигации.
  final int selectedIndex;

  /// Действие, выполняемое при нажатии на элемент навигации.
  final Function(int index)? onItemSelected;

  const BottomNavigationBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          height: getHeightWithPadding(context),
          decoration: const BoxDecoration(
            color: Color(0xE6F2F4F8),
            borderRadius: borderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(
                  width: 40,
                ),
              ),
              for (NavigationBarItem item in items)
                Expanded(
                  flex: 2,
                  child: NavigationBarItemWidget(
                    label: item.label!,
                    icon: item.icon,
                    isActive: items.indexOf(item) == selectedIndex,
                    onPressed: () => onItemSelected?.call(items.indexOf(item)),
                  ),
                ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(
                  width: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
