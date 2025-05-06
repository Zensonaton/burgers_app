import "dart:ui";

import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../consts.dart";
import "../models/story.dart";
import "../widgets/carousel_dots_view.dart";

/// Виджет для [HomePage], отображающий карусель с изображениями и текстом.
class CarouselWidget extends HookWidget {
  const CarouselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final story = useState<Story>(stories.first);

    void onPageChanged(int index, _) {
      story.value = stories[index];
    }

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: double.infinity,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            viewportFraction: 1,
            disableCenter: true,
            onPageChanged: onPageChanged,
          ),
          items: stories
              .map(
                (s) => Image.asset(
                  s.fullImagePath!,
                  fit: BoxFit.cover,
                ),
              )
              .toList(),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            // @Zensonaton: Если не указать этот transitionBuilder, то в случае очень быстрого
            // переключения между страницами, будет происходить ошибка "Duplicate keys found".
            //
            // Где-то на Github Flutter'а есть issue про это, но они не хотят фиксить это,
            // ибо "данный фикс ломает какое-то из внутренних приложений Google, и мы не можем рассказать, какое и как".

            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Align(
            key: ValueKey(
              // @Zensonaton: Вместо .title, лучше использовать .id или что-то более простое (примитивное в сравнении), чем string.
              story.value.title,
            ),
            alignment: Alignment.bottomLeft,
            child: IgnorePointer(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 62),
                    decoration: const BoxDecoration(
                      color: Color(0x3535351A),
                    ),
                    child: Text(
                      story.value.title,
                      style: const TextStyle(
                        fontSize: textSize / 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: const Offset(0, -42),
            child: CarouselDotsView(
              count: stories.length,
              selectedIndex: stories.indexOf(story.value),
            ),
          ),
        ),
      ],
    );
  }
}

/// Route, отображающий главную страницу приложения.
class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CarouselWidget(),
    );
  }
}
