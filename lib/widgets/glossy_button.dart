import "dart:ui";

import "package:flutter/material.dart";

/// Виджет, репрезентирующий кнопку с эффектом глянца.
class GlossyIconButton extends StatelessWidget {
  /// Иконка, которая будет отображаться слева от текста (если он указан).
  final IconData? icon;

  /// Текст для кнопки.
  final String? text;

  /// Текст для badge, отображаемый на кнопке.
  final String? badgeText;

  /// Действие, вызываемое при нажатии на кнопку.
  final VoidCallback? onPressed;

  const GlossyIconButton({
    super.key,
    this.icon,
    this.text,
    this.badgeText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      icon != null || text != null,
      "Either icon or text must be provided",
    );

    return MouseRegion(
      cursor: onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onPressed,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40,
                  sigmaY: 40,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 16,
                  ),
                  color: const Color(0x407F8440),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      if (icon != null)
                        Icon(
                          icon,
                          color: Colors.white,
                        ),
                      if (text != null)
                        Text(
                          text!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (badgeText != null)
              Positioned(
                right: 0,
                top: 1,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff497EE0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
