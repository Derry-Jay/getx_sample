import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global_configs/global_configs.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/common_controller.dart';
import '../css/css.dart';
import '../css/measurements.dart';
import '../css/shades.dart';
import '../models/common/app_config.dart';
import '../models/common/bench_mark.dart';
import 'enums.dart';
import 'methods.dart';
import 'my_geocoder.dart';
import 'my_geolocator.dart';
import 'route_generator.dart';

int page = 0;

WidgetsBinding? wb;

GlobalConfigs? res;

bool hideText = true;

GlobalConfiguration? gc;

AppConfig acf = AppConfig();

DateTime? currentBackPressTime;

StreamSubscription<BenchMark>? ssc;

Map<String, dynamic> body = <String, dynamic>{};

const apiMode =
    kDebugMode ? APIMode.dev : (kProfileMode ? APIMode.test : APIMode.prod);

final css = Css(),
    st = Stopwatch(),
    shades = Shades(),
    gco = MyGeocoder(),
    gl = MyGeolocator(),
    conn = Connectivity(),
    today = DateTime.now(),
    isIOS = Platform.isIOS,
    picker = ImagePicker(),
    fmd1 = DateFormat.MMMd(),
    isMac = Platform.isMacOS,
    dip = DeviceInfoPlugin(),
    isLinux = Platform.isLinux,
    thisMoment = TimeOfDay.now(),
    sc = TextEditingController(),
    tc = TextEditingController(),
    isCupertino = isIOS || isMac,
    measurements = Measurements(),
    phc = TextEditingController(),
    pwc = TextEditingController(),
    sdc = TextEditingController(),
    edc = TextEditingController(),
    isAndroid = Platform.isAndroid,
    isWindows = Platform.isWindows,
    isFuchsia = Platform.isFuchsia,
    rg = RouteGenerator(flag: true),
    isPortable = isAndroid || isIOS,
    sharedPrefs = SharedPreferences.getInstance(),
    cc = putDefault<CommonController>(CommonController()),
    isWeb = !(isAndroid || isCupertino || isWindows || isLinux || isFuchsia) &&
        kIsWeb,
    pwdExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$'),
    mailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
