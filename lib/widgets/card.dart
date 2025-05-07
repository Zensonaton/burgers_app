import "package:flutter/cupertino.dart";

/// Виджет, отображающий карточку с названием, описанием, а так же кнопкой.
class CardWidget extends StatelessWidget {
  /// Название карточки.
  final String title;

  /// Описание карточки.
  final String description;

  /// Действие, выполняемое при нажатии на кнопку либо карточку.
  final VoidCallback? onPressed;

  const CardWidget({
    super.key,
    required this.title,
    required this.description,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF404040),
                      letterSpacing: 0,
                      height: 1.1,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      description,
                      maxLines: 100,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF959398),
                        letterSpacing: 0,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    CupertinoIcons.arrow_up_right,
                    color: Color(0xFF497EE0),
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
