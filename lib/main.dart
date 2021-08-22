import 'package:flutter/material.dart';
import 'package:school_calendar/views/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
