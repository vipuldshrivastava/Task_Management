import 'package:flutter/material.dart';
import 'package:flutter_task_management/colorStyle.dart';

const Color kColor = Color(0xffFD794F);

class Themes{
  static final light = ThemeData(
    backgroundColor: kColor,
    primaryColor: kColor,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    backgroundColor: ktextColor,
    primaryColor: kdarkColor,
    brightness: Brightness.dark
  );
}