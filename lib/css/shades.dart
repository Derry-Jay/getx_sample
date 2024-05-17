import 'package:flutter/material.dart';

import '../models/common/shade.dart';

class Shades {
  static final Shades _singleton = Shades._internal();

  factory Shades() => _singleton;

  Shades._internal();

  final kGrey = Colors.grey,
      kBlue = Colors.blue,
      kLightBlue = Colors.lightBlue,
      kBlueAccent = Colors.blueAccent,
      kTransparent = Colors.transparent,
      kGrey1 = Shade(1, 'grey').fromConfigs,
      kGold1 = Shade(1, 'gold').fromConfigs;
}
