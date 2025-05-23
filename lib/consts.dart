import "package:flutter/foundation.dart";

import "models/action_block.dart";
import "models/story.dart";

/// Список из всех доступных историй ([Story]), отображаемых на главном экране.
///
/// @Zensonaton: изначально, я хотел реализовать Provider вместо этой const-переменной,
/// но, поскольку тут не требуется использование какого-либо State Management'а, я решил
/// этого не делать.
final List<Story> stories = [
  Story(
    title: "Мастер-Класс по сборке бургеров!",
    imageName: "burgers.png",
    buttonText: "Забронировать",
  ),
  Story(
    title: "Прекрасная погода в Питере :)",
    imageName: "spb.png",
    buttonText: "ААААААААААВИА—",
  ),
  Story(
    title: "Баурсаки с рецептом из Казахстана!",
    imageName: "baursaki.png",
    buttonText: "Хочу покушОть!",
  ),
  Story(
    title:
        "Скажите «привет» Джошу и Тайлеру из twenty one pilots на туре Clancy!",
    imageName: "clancy.png",
    buttonText: "Купить билет",
  ),
  Story(
    title: "Вареники. Надеемся, что не с вишней. Но такие тоже бывают (ужасы).",
    imageName: "vareniki.png",
    buttonText: "Проверить, с чем они",
  ),
];

/// Список из карточек на главном экране, нажатие которых открывает что-то.
final List<ActionBlock> actionBlocks = [
  ActionBlock(
    title: "Меню",
    description: "Переход на внешнее меню",
  ),
  ActionBlock(
    title: "Отзыв",
    description: "Оставить отзыв о посещении",
  ),
  ActionBlock(
    title: "Сертификат",
    description: "Подарочный сертификат себе или другу",
  ),
  ActionBlock(
    title: "Сайт",
    description: "Переход на сайт ресторана",
  ),

  // Debug.
  if (kDebugMode)
    ActionBlock(
      title: "Супер-дупер-мупер-мега длинное название",
      description:
          "Вы удивитесь, но это не шутка! Это описание очень, очень и очень, действительно длинное!",
    ),
];

/// Магическая константа, определяющая размер текстов. Чаще всего, это значение делится на что-то, чтобы компенсировать большой размер.
///
/// @Zensonaton: Я, по-правде говоря, вообще не понял почему это так реализовано. В Figma пишется `Size/12` вместо фиксированного, и для меня такое в новинку.
const double textSize = 336;
