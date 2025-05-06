import "package:flutter/cupertino.dart";

/// Метод, создающий уведомление о том, что данный функционал ещё не реализован.
void showNotImplemented(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text(
          "Не реализовано",
        ),
        content: const Text(
          "Этот функционал не реализован.",
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text(
              "OK",
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

/// Метод, форматирующий числа, добавляя пробелы в качестве разделителей тысяч.
///
/// Например, 1234567 будет преобразовано в "1 234 567".
String formatNumber(int number) {
  return number.toString().replaceAllMapped(
        RegExp(r"(\d)(?=(\d{3})+(?!\d))"),
        (Match match) => "${match[1]} ",
      );
}
