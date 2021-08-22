import 'package:flutter/material.dart';

final ButtonStyle button = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.all(20),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  backgroundColor: Color.fromRGBO(244, 0, 32, 1),
);
