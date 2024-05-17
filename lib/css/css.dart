import 'package:flutter/material.dart';

import '../utils/values.dart';

class Css {
  static final Css _singleton = Css._internal();

  factory Css() {
    return _singleton;
  }

  Css._internal();

  final theme = ThemeData(primaryColor: shades.kBlue);
}
