import 'package:flutter/material.dart';
import 'package:school_calendar/views/home.dart';

void main() {
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(Color.fromRGBO(244, 0, 32, 1))),
        scaffoldBackgroundColor: Colors.grey,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Color.fromRGBO(244, 0, 32, 1)),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
