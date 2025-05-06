import "package:flutter/cupertino.dart";

/// Главный виджет приложения, отображающий само приложение.
class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Home",
          ),
        ),
        child: Center(
          child: Text(
            "Hello, world!",
          ),
        ),
      ),
    );
  }
}
