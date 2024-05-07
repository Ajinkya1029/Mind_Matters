import 'package:flutter/material.dart';
import 'package:mind_matters/screens/home_screen.dart';
import 'package:mind_matters/screens/thread_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
          primary: Color.fromRGBO(65, 148, 136, 1),
          onPrimary: Color.fromRGBO(65, 148, 136, 1),
          secondary: Color.fromRGBO(178, 216, 216, 1),
          onSecondary: Color.fromRGBO(178, 216, 216, 1),
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
        textTheme:GoogleFonts.openSansTextTheme(),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
