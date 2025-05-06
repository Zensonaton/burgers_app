/// Класс, репрезентирующий отдельную историю, которая отображается на главном экране.
class Story {
  /// Заголовок истории.
  final String title;

  /// Название изображения истории.
  ///
  /// Воспользуйтесь [fullImagePath] для получения полного пути к изображению (в asset'ах).
  final String? imageName;

  /// Текст для кнопки, отображаемой внизу истории.
  final String? buttonText;

  /// Полный путь к изображению истории в asset'ах.
  String? get fullImagePath => "assets/images/$imageName";

  Story({
    required this.title,
    required this.imageName,
    required this.buttonText,
  });
}
