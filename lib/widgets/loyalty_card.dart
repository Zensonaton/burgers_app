import "package:flutter/material.dart";

import "../utils.dart";

/// Виджет для [LoyaltyCardWidget], отображающий правую часть карточки (QR-код).
class _CardQR extends StatelessWidget {
  const _CardQR();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/qr.png",
    );
  }
}

/// Виджет для [LoyaltyCardWidget], отображающий левую часть карточки (текстовая информация).
class _CardInfo extends StatelessWidget {
  /// ID карточки, отображаемый под верхним текстом ([topText]).
  final String cardID;

  /// Количество бонусов на карточке, отображаемое внизу.
  final int bonusCount;

  const _CardInfo({
    required this.cardID,
    required this.bonusCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            const Text(
              "Карта уровень VIP",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            Text(
              cardID,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              formatNumber(bonusCount),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            const Text(
              "Бонусов",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Виджет, отображающий карточку лояльности.
class LoyaltyCardWidget extends StatelessWidget {
  /// ID карточки, отображаемый под верхним текстом ([topText]).
  final String cardID;

  /// Количество бонусов на карточке, отображаемое внизу.
  final int bonusCount;

  const LoyaltyCardWidget({
    super.key,
    required this.cardID,
    required this.bonusCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF497EE0),
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(
            "assets/images/card_background.png",
          ),
          opacity: 0.2,
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _CardInfo(
              cardID: cardID,
              bonusCount: bonusCount,
            ),
          ),
          const Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: _CardQR(),
            ),
          ),
        ],
      ),
    );
  }
}
