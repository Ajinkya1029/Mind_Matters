import 'package:flutter/material.dart';
import 'package:mind_matters/screens/home_screen.dart';
import 'package:mind_matters/screens/thread_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).viewInsets.bottom;

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(0, 128, 128, 1),
          onPrimary: Color.fromRGBO(0, 128, 128, 1),
          secondary: Color.fromRGBO(178, 216, 216, 1),
          onSecondary: Color.fromRGBO(1, 3, 0, 1),
          error: Colors.black,
          onError: Colors.black,
          background: Color.fromRGBO(251, 251, 251, 1),
          onBackground: Color.fromRGBO(242, 241, 235, 1),
          surface: Color.fromRGBO(254, 254, 254, 1),
          onSurface: Color.fromRGBO(255, 255, 255, 1),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.black,
          backgroundColor: Color.fromRGBO(0, 128, 128, 1),
        ),
        textTheme: const TextTheme(
             bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          headline3: TextStyle(color: Colors.black),
          headline4: TextStyle(color: Colors.black),
          headline5: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.black),
          subtitle1: TextStyle(color: Colors.black),
          subtitle2: TextStyle(color: Colors.black),
          caption: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
          overline: TextStyle(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
