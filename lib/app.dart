import "package:flutter/cupertino.dart";

import "routes/home.dart";

/// Главный виджет приложения, отображающий само приложение.
class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: "Onest",
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
