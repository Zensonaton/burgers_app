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
