import "dart:ui";

import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../consts.dart";
import "../models/story.dart";
import "../utils.dart";
import "../widgets/carousel_dots_view.dart";
import "../widgets/glossy_button.dart";

/// Виджет для [HomePage], отображающий Row с кнопками в верхней части экрана.
class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GlossyIconButton(
          // TODO: Заменить на иконку из Figma.
          icon: CupertinoIcons.gift_fill,
          text: "1234",
          onPressed: () => showNotImplemented(context),
        ),
        GlossyIconButton(
          icon: CupertinoIcons.bell_fill,
          badgeText: "12",
          onPressed: () => showNotImplemented(context),
        ),
      ],
    );
  }
}

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
    return CupertinoPageScaffold(
      child: Column(
        children: [
          const Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 443,
                child: CarouselWidget(),
              ),
              SafeArea(
                left: false,
                bottom: false,
                right: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: AppBarWidget(),
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: const Offset(0, -27),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF9FAFD),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 27,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
