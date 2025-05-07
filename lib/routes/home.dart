import "dart:ui";

import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../consts.dart";
import "../models/story.dart";
import "../utils.dart";
import "../widgets/bottom_navigation_bar.dart"
    show BottomNavigationBar, NavigationBarItem;
import "../widgets/card.dart";
import "../widgets/carousel_dots_view.dart";
import "../widgets/glossy_button.dart";
import "../widgets/loyalty_card.dart";

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
                        color: CupertinoColors.white,
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
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF9FAFD),
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(
              bottom: BottomNavigationBar.getHeightWithPadding(context),
            ),
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
                    color: const Color(0xFFF9FAFD),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 27,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      const LoyaltyCardWidget(
                        cardID: "230365398",
                        bonusCount: 5689,
                      ),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 120,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                        // @Zensonaton: Я знаю, что shrinkWrap это зло. Не знаю, можно ли по-другому это реализовать.
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),

                        padding: EdgeInsets.zero,
                        itemCount: actionBlocks.length,
                        itemBuilder: (BuildContext context, int index) {
                          final block = actionBlocks[index];

                          return CardWidget(
                            title: block.title,
                            description: block.description,
                            onPressed: () => showNotImplemented(context),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              selectedIndex: 0,
              onItemSelected: (_) => showNotImplemented(context),
              items: [
                // TODO: Использовать иконки из Figma.

                const NavigationBarItem(
                  icon: CupertinoIcons.house_fill,
                  label: "Главная",
                ),
                const NavigationBarItem(
                  icon: CupertinoIcons.gift_fill,
                  label: "Бонусы",
                ),
                const NavigationBarItem(
                  icon: CupertinoIcons.bell_fill,
                  label: "Доставка",
                ),
                const NavigationBarItem(
                  icon: CupertinoIcons.location_solid,
                  label: "Рестораны",
                ),
                const NavigationBarItem(
                  icon: CupertinoIcons.person_fill,
                  label: "Профиль",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
