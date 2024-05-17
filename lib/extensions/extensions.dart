import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/src/auth_messages_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';
import 'package:local_auth_platform_interface/types/auth_messages.dart';
import 'package:local_auth_windows/types/auth_messages_windows.dart';

import '../utils/enums.dart';
import '../utils/keys.dart';
import '../utils/methods.dart';
import '../utils/values.dart';
import '../views/widgets/common/circular_loader.dart';
import '../views/widgets/common/custom_button.dart';
import '../views/widgets/common/empty_widget.dart';

extension Mileage on IosDeviceInfo {
  String get value => jsonEncode(data);
}

extension Ext on XFile {
  File get file => File(path);
  Future<int> get size => length();
  Future<Uint8List> get bytes => readAsBytes();
  Future<String> asString([Encoding? encoding]) =>
      readAsString(encoding: encoding ?? utf8);
  Future<DateTime> get lastModifiedDate => lastModified();
  Widget imageBuilder1(
      {BoxFit? fit,
      Color? color,
      double? scale,
      double? width,
      double? height,
      int? cacheWidth,
      int? cacheHeight,
      Rect? centerSlice,
      bool? isAntiAlias,
      ImageRepeat? repeat,
      String? semanticLabel,
      bool? gaplessPlayback,
      bool? matchTextDirection,
      BlendMode? colorBlendMode,
      bool? excludeFromSemantics,
      Animation<double>? opacity,
      AlignmentGeometry? alignment,
      FilterQuality? filterQuality,
      Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
      Widget Function(BuildContext, Object, StackTrace?)? errorBuilder}) {
    return Image.file(file,
        fit: fit,
        width: width,
        color: color,
        height: height,
        opacity: opacity,
        scale: scale ?? 1.0,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        centerSlice: centerSlice,
        semanticLabel: semanticLabel,
        colorBlendMode: colorBlendMode,
        isAntiAlias: isAntiAlias ?? false,
        repeat: repeat ?? ImageRepeat.noRepeat,
        alignment: alignment ?? Alignment.center,
        gaplessPlayback: gaplessPlayback ?? false,
        frameBuilder: frameBuilder ?? getImageLoader,
        errorBuilder: errorBuilder ?? getErrorWidget,
        matchTextDirection: matchTextDirection ?? false,
        filterQuality: filterQuality ?? FilterQuality.low,
        excludeFromSemantics: excludeFromSemantics ?? false);
  }

  Widget imageBuilder2(
      {BoxFit? fit,
      Color? color,
      double? scale,
      double? width,
      double? height,
      int? cacheWidth,
      int? cacheHeight,
      Rect? centerSlice,
      bool? isAntiAlias,
      ImageRepeat? repeat,
      String? semanticLabel,
      bool? gaplessPlayback,
      bool? matchTextDirection,
      BlendMode? colorBlendMode,
      bool? excludeFromSemantics,
      Animation<double>? opacity,
      AlignmentGeometry? alignment,
      FilterQuality? filterQuality,
      Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
      Widget Function(BuildContext, Object, StackTrace?)? errorBuilder}) {
    Widget picBuilder(BuildContext context, AsyncSnapshot<Uint8List> list) {
      try {
        switch (list.connectionState) {
          case ConnectionState.done:
            if (list.hasData && !list.hasError) {
              return Image.memory(list.data!,
                  fit: fit,
                  width: width,
                  color: color,
                  height: height,
                  opacity: opacity,
                  scale: scale ?? 1.0,
                  cacheWidth: cacheWidth,
                  cacheHeight: cacheHeight,
                  centerSlice: centerSlice,
                  semanticLabel: semanticLabel,
                  colorBlendMode: colorBlendMode,
                  isAntiAlias: isAntiAlias ?? false,
                  repeat: repeat ?? ImageRepeat.noRepeat,
                  alignment: alignment ?? Alignment.center,
                  gaplessPlayback: gaplessPlayback ?? false,
                  frameBuilder: frameBuilder ?? getImageLoader,
                  errorBuilder: errorBuilder ?? getErrorWidget,
                  matchTextDirection: matchTextDirection ?? false,
                  filterQuality: filterQuality ?? FilterQuality.low,
                  excludeFromSemantics: excludeFromSemantics ?? false);
            } else if (list.hasError) {
              return Text(list.error.string);
            } else if (!list.hasData) {
              return const Text('No Data');
            } else {
              return const CircularLoader();
            }
          case ConnectionState.none:
            return const EmptyWidget();
          default:
            return const CircularLoader();
        }
      } catch (e) {
        e.jot();
        return const EmptyWidget();
      }
    }

    return FutureBuilder<Uint8List>(future: bytes, builder: picBuilder);
  }
}

extension Tips on LocalAuthentication {
  Future<bool> get isGadgetSupported => isDeviceSupported();

  Future<bool> get isAuthenticationStopped => stopAuthentication();

  Future<List<BiometricType>> get availableBiometrics =>
      getAvailableBiometrics();

  Future<bool> confirm(String message,
          [AuthenticationOptions? options,
          Iterable<AuthMessages>? authMessages]) =>
      authenticate(
          localizedReason: message.trimmed,
          options: options ?? const AuthenticationOptions(),
          authMessages: authMessages ??
              const <AuthMessages>[
                IOSAuthMessages(),
                AndroidAuthMessages(),
                WindowsAuthMessages()
              ]);
}

extension Jury on IosUtsname {
  Map<String, dynamic> get map {
    final data = <String, dynamic>{};
    try {
      data['machine'] = machine;
      data['sysname'] = sysname;
      data['release'] = release;
      data['version'] = version;
      data['nodename'] = nodename;
    } catch (e) {
      e.jot();
    }
    return data;
  }
}

extension Extras on AndroidDisplayMetrics {
  String get value => jsonEncode(toMap());
}

extension Aid on Object? {
  String get string => toString().trimmed;

  void jot([bool? flag, int? wrapWidth]) {
    if (kDebugMode) {
      return (flag ?? false)
          ? debugPrint(string, wrapWidth: wrapWidth)
          : print(this);
    }
  }
}

extension Extra on List<num> {
  bool get hasOnlyZeroes {
    if (isEmpty) {
      return true;
    } else {
      bool val = true;
      for (num i in this) {
        if (i != 0) {
          val = false;
          break;
        } else {
          continue;
        }
      }
      return val;
    }
  }

  num get sumOfNumList {
    if (isEmpty) {
      return '0'.toNum();
    } else {
      num s = 0;
      for (num i in this) {
        s += i;
      }
      return s;
    }
  }

  num get largestNumber {
    if (isEmpty) {
      return -1;
    } else if (length == 1) {
      return first;
    } else {
      num val = first;
      for (num i in this) {
        val = max(i, val);
      }
      return val;
    }
  }

  num getNthLargest(int n) {
    if (isEmpty) {
      return '0'.toNum();
    } else if (length == 1) {
      return single;
    } else {
      final ls = [...this];
      ls.sort();
      return ls[ls.length - n];
    }
  }
}

extension Usefullness on AndroidDeviceInfo {
  String get value => jsonEncode(data);
}

extension Benefit on DateTime {
  String putDateTimeToString([String? separator]) {
    final sep = separator?.trimmed ?? '-',
        ds = (millisecond * 1000) + microsecond;
    return '$year$sep$month$sep$day, $hour:$minute:$second.$ds';
  }

  bool get isToday => today.isAtSameMomentAs(this);

  bool compareDateOnly(DateTime other) {
    return other.year == year && other.month == month && other.day == day;
  }

  bool compareDateAndTimeOnly(DateTime other) {
    return compareDateOnly(other) &&
        other.hour == hour &&
        other.minute == minute &&
        other.second == second;
  }
}

extension Assist on Map<String, dynamic> {
  FormData formData(
          [ListFormat? collectionFormat, bool? camelCaseContentDisposition]) =>
      FormData.fromMap(this, collectionFormat ?? ListFormat.multi,
          camelCaseContentDisposition ?? false);
}

extension Spare on AndroidBuildVersion {
  Map<String, dynamic> get map {
    final data = <String, dynamic>{};
    try {
      data['sdk'] = sdkInt;
      data['base_os'] = baseOS;
      data['release'] = release;
      data['codename'] = codename;
      data['incremental'] = incremental;
      data['preview_sdk'] = previewSdkInt;
      data['security_patch'] = securityPatch;
    } catch (e) {
      e.jot();
    }
    return data;
  }
}

extension Use on DeviceInfoPlugin {
  Future<bool> get isRealDevice async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return isIOS && (await iosInfo).isPhysicalDevice;
      case TargetPlatform.android:
        return isAndroid && (await androidInfo).isPhysicalDevice;
      default:
        return true;
    }
  }
}

extension Support on Size {
  double get radius => (width.square + height.square).squareRoot;

  double get diagonal => (shortestSide.square + longestSide.square).squareRoot;
}

extension Tip on BoxConstraints {
  double get minRadius => minSize.radius;

  double get maxRadius => maxSize.radius;

  Size get minSize => Size(minWidth, minHeight);

  Size get maxSize => Size(maxWidth, maxHeight);

  Size get avgSize => Size(avgWidth, avgHeight);

  double get avgWidth => (minWidth + maxWidth) / 2;

  double get avgHeight => (minHeight + maxHeight) / 2;

  double get avgRadius => (minRadius + maxRadius) / 2;
}

extension Avail on num {
  int get upper => ceil();

  int get lower => floor();

  num get absolute => abs();

  int get approx => round();

  int get integer => toInt();

  double get float => toDouble();

  int get truncated => truncate();

  double get up => ceilToDouble();

  double get sine => sin(radians);

  num get cube => toThePowerOf(3);

  num get square => toThePowerOf(2);

  double get cosine => cos(radians);

  double get low => floorToDouble();

  double get logarithm => log(this);

  double get tangent => tan(radians);

  double get cosInverse => acos(this);

  double get tanInverse => atan(this);

  double get squareRoot => sqrt(this);

  double get sineInverse => asin(this);

  num get degrees => (this * 180) / pi;

  num get radians => (this * pi) / 180;

  double get approximate => roundToDouble();

  num toThePowerOf(num exp) => pow(this, exp);

  double get truncatedDouble => truncateToDouble();

  double tanInverseOfQuotientOf(num other) => atan2(this, other);

  bool get isPerfectSquare =>
      this > 0.0 &&
      (this is int
          ? squareRoot * squareRoot == this
          : (string.split('.').last.length % 2 == 0 &&
              string.split('.').join().toInt().isPerfectSquare));

  Widget getRatingWidget(int total,
      {MainAxisSize? mainAxisSize,
      TextBaseline? textBaseline,
      TextDirection? textDirection,
      VerticalDirection? verticalDirection,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment}) {
    if (this > total) {
      return const EmptyWidget();
    } else {
      final list = List<Icon>.generate(lower, obtainStar);
      if (this - lower > 0) {
        list.add(Icon(Icons.star_half, color: shades.kGold1));
      }
      list.addAll(List<Icon>.generate(
          total - lower - (this - lower).upper, obtainStarOutline));
      return Row(
          textBaseline: textBaseline,
          textDirection: textDirection,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          verticalDirection: verticalDirection ?? VerticalDirection.down,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: list);
    }
  }
}

extension Help on int {
  bool get isPalindrome => reversed == this;

  Icon get filledStar => Icon(Icons.star, color: shades.kGold1);

  bool get isAdam => square.integer == reversed.square.integer.reversed;

  Icon get outlinedStar => Icon(Icons.star_border, color: shades.kGold1);

  bool get isFibonacci =>
      (5 * this * this + 4).isPerfectSquare ||
      (5 * this * this - 4).isPerfectSquare;

  bool get isArmstrong {
    int om = 0, curNum = this;
    while (curNum != 0) {
      om += (curNum % 10).cube.integer;
      curNum ~/= 10;
    }
    return om == this;
  }

  int get reversed {
    int om = 0, curNum = this;
    while (curNum != 0) {
      om = (om * 10) + (curNum % 10);
      curNum = curNum ~/ 10;
    }
    return om;
  }

  bool get isStrong {
    int om = 0, curNum = this;
    while (curNum != 0) {
      om = (curNum % 10).factorial;
      curNum = curNum ~/ 10;
    }
    return om == this;
  }

  bool get isPerfect {
    int sum = 0;
    for (int i = 1; i < this; i++) {
      if (this % i == 0) {
        sum += i;
      }
    }
    return sum == this;
  }

  int get factorial {
    if (this < 0) {
      return 0;
    } else if ([0, 1].contains(this)) {
      return 1;
    } else {
      return this * (this - 1).factorial;
    }
  }

  bool get isPrime {
    if (this < 2) {
      return false;
    } else {
      bool flag = true;
      for (int i = 2; i <= squareRoot.lower; i++) {
        if (this % i == 0) {
          flag = false;
          break;
        }
      }
      return flag;
    }
  }

  String get creditCardNumber {
    final n2s = absolute.string;
    return this > 10.toThePowerOf(15).integer && n2s.length == 16
        ? '${n2s.substring(0, 4)} ${n2s.substring(4, 8)} ${n2s.substring(8, 12)} ${n2s.substring(12, 16)}'
        : '';
  }

  int largestFactorUnderN([int n = 10]) {
    int fact = 1;
    final lt = n - (this < n ? 0 : 1);
    for (int i = 2; i < this; i++) {
      if (i > lt) {
        break;
      } else if (this % i == 0) {
        fact = i;
      } else {
        continue;
      }
    }
    return fact;
  }

  DateTime getDateFromMilli([bool? isUtc]) =>
      DateTime.fromMillisecondsSinceEpoch(this, isUtc: isUtc ?? false);

  DateTime getDateFromMicro([bool? isUtc]) =>
      DateTime.fromMicrosecondsSinceEpoch(this, isUtc: isUtc ?? false);

  DateTime getDate(
          {int? day,
          int? hour,
          int? month,
          int? minute,
          int? second,
          int? millisecond,
          int? microsecond}) =>
      DateTime(this, month ?? 1, day ?? 1, hour ?? 0, minute ?? 0, second ?? 0,
          millisecond ?? 0, microsecond ?? 0);

  DateTime getUTCDate(
          {int? day,
          int? hour,
          int? month,
          int? minute,
          int? second,
          int? millisecond,
          int? microsecond}) =>
      DateTime.utc(this, month ?? 1, day ?? 1, hour ?? 0, minute ?? 0,
          second ?? 0, millisecond ?? 0, microsecond ?? 0);
}

extension PlaceUtils on LatLng {
  Future<List<Placemark>> get places =>
      placemarkFromCoordinates(latitude, longitude);

  Map<String, double> get map =>
      <String, double>{'longitude': longitude, 'latitude': latitude};

  Location get loc =>
      Location(latitude: latitude, longitude: longitude, timestamp: today);

  double distanceTo(LatLng other) =>
      gl.distanceBetween(latitude, longitude, other.latitude, other.longitude) /
      1000;

  double get earthRadius {
    final eqRadSq = 6378.137.square,
        poleRadSq = 6356.752.square,
        poleRad4 = poleRadSq.square,
        latCosSq = latitude.cosine.square,
        v1 = (eqRadSq.square - poleRad4) * latCosSq,
        v2 = (eqRadSq - poleRadSq) * latCosSq;
    return ((v1 + poleRad4) / (v2 + poleRadSq)).absolute.squareRoot;
  }

  double getAngle(LatLng other) {
    final
        // sLong = other.longitude + longitude,
        dLon = (other.longitude - longitude).absolute,
        // dLat = (other.latitude - latitude).absolute,
        y = dLon.sine * other.longitude.cosine,
        x = latitude.cosine * other.latitude.sine -
            latitude.sine * other.latitude.cosine * dLon.cosine;
    return y.tanInverseOfQuotientOf(x);
  }

  double haversineDistanceTo(LatLng other) {
    final sLat = (other.latitude + latitude),
        dLat = (other.latitude - latitude).absolute,
        dLong = (other.longitude - longitude).absolute,
        v1 = 1 + sLat.cosine,
        v2 = 1 - sLat.cosine,
        v3 = (dLat.cosine + sLat.cosine) * dLong.cosine;
    return ((earthRadius + other.earthRadius) *
        ((v1 - v3) / (v2 + v3)).absolute.squareRoot.tanInverse);
  }
}

extension Services on TimeOfDay {
  String get time {
    final trailingZeroHour = hour.toString().length == 1 ? '0' : '',
        trailingZeroMinute = minute.toString().length == 1 ? '0' : '';
    return '$trailingZeroHour$hour:$trailingZeroMinute$minute';
  }

  String get timeWithMeridiem {
    if (hour < 12) {
      final hr = hour == 0 ? 12 : hour,
          trailingZeroHour = hr.string.length == 1 ? '0' : '',
          trailingZeroMinute = minute.string.length == 1 ? '0' : '';
      return '$trailingZeroHour$hr:$trailingZeroMinute$minute AM';
    } else {
      final hr = hour == 12 ? hour : hour - 12,
          trailingZeroHour = hr.string.length == 1 ? '0' : '',
          trailingZeroMinute = minute.string.length == 1 ? '0' : '';
      return '$trailingZeroHour$hr:$trailingZeroMinute$minute PM';
    }
  }
}

extension Utils on String {
  String get trimmed => trim();

  String get lowerCased => toLowerCase();

  String get upperCased => toUpperCase();

  String get dateWithF2 => fmd1.format(dateTime);

  Uint8List get listData => base64.decode(trimmed);

  String get fileExtension => split('.').last.trimmed;

  double toDouble([double? orElse]) =>
      double.tryParse(trimmed) ?? (orElse ?? double.nan);

  int toInt([int? radix, int? orElse]) =>
      int.tryParse(trimmed, radix: radix) ?? (orElse ?? -1);

  num toNum([num? orElse]) => num.tryParse(trimmed) ?? (orElse ?? toDouble());

  String get firstLetterCapitalized => trimmed.isEmpty
      ? ''
      : trimmed.substring(0, 1).upperCased + trimmed.substring(1).lowerCased;

  bool Function(Route<dynamic>) get popDestination =>
      ModalRoute.withName(trimmed);

  bool get isValidEmail =>
      mailExp.hasMatch(trimmed) && mailExp.allMatches(trimmed).length == 1;

  bool get isAudio => <String>[
        'mp3',
        'wav',
        'aac',
        'm4a',
        'flac',
        'wma',
        'midi',
        'mod'
      ].contains(fileExtension);

  bool get isImage =>
      <String>['jpg', 'jpeg', 'png', 'svg', 'gif'].contains(fileExtension);

  bool get isVideo => <String>['avi', 'mp4', 'mov', 'hevc', 'flv', 'mkv']
      .contains(fileExtension);

  String limitString({int? limit, String? hiddenText}) {
    final lt = limit ?? 24, ht = hiddenText ?? '...';
    return trimmed.isEmpty
        ? ''
        : trimmed.substring(0, min<int>(lt, length)) + (length > lt ? ht : '');
  }

  String get firstAndLastName => trimmed.isEmpty
      ? ''
      : trimmed
          .split(' ')
          .where((element) => [0, trimmed.split(' ').length - 1]
              .contains(trimmed.split(' ').indexOf(element)))
          .toList()
          .join(' ');

  bool get toFlag {
    final values = ['true', 'yes', 'ok', 'good', 'fine'];
    return trimmed.isNotEmpty &&
        (values.contains(trimmed.lowerCased) ||
            values
                .map<String>((String e) => e.trimmed.upperCased)
                .contains(trimmed.upperCased) ||
            toInt(null, 0) > 0);
  }

  bool get isAssetImagePath {
    bool result = false;
    for (String element in <String>[
      'images',
      'imgs',
      'img',
      'image',
      'pics',
      'pictures'
    ]) {
      if (trimmed.contains(element) || RegExp(element).hasMatch(trimmed)) {
        result = true;
        break;
      } else {
        continue;
      }
    }
    return result;
  }

  BoxFit get boxFit {
    switch (trimmed.lowerCased) {
      case 'fill':
      case 'filled':
        return BoxFit.fill;
      case 'cover':
      case 'covered':
        return BoxFit.cover;
      case 'contain':
      case 'contained':
        return BoxFit.contain;
      case 'fw':
      case 'width':
      case 'fitwidth':
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'fh':
      case 'height':
      case 'fitheight':
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'sd':
      case 'down':
      case 'scaledown':
      case 'scale_down':
        return BoxFit.scaleDown;
      case 'none':
      case 'nill':
      case 'null':
      default:
        return BoxFit.none;
    }
  }

  AlignmentDirectional get alignmentDirectional {
    switch (trimmed.lowerCased) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  Uri get url =>
      Uri.tryParse(
          '${gc?.getValue<String>(apiMode.name).trimmed ?? ""}${(gc?.getValue<String>(apiMode.name).trimmed.endsWith("/") ?? false) ? "" : "/"}$trimmed') ??
      Uri();

  DateTime get dateTime {
    final re1 = RegExp(r'-'), re2 = RegExp(r'/'), re3 = RegExp(r'.');
    if (trimmed.isEmpty) {
      return today;
    } else if (re1.hasMatch(trimmed) && re1.allMatches(trimmed).length == 2) {
      return DateTime.tryParse(trimmed) ?? today;
    } else if (re2.hasMatch(trimmed) && re2.allMatches(trimmed).length == 2) {
      return DateTime.tryParse(trimmed.replaceAll('/', '-')) ?? today;
    } else if (re3.hasMatch(trimmed) && re3.allMatches(trimmed).length == 2) {
      return DateTime.tryParse(trimmed.replaceAll('.', '-')) ?? today;
    } else {
      return today;
    }
  }

  String get dateWithF1 {
    try {
      final ds = split(' '),
          dd = ds.first.dateTime,
          td = ds[1].parseTime(ds.last),
          trailingZeroHour = td.hour.toString().length == 1 ? '0' : '',
          trailingZeroMinute = td.minute.toString().length == 1 ? '0' : '';
      return '${fmd1.format(dd)}, ${dd.year} ($trailingZeroHour${td.hour}:$trailingZeroMinute${td.minute} Hrs)';
    } catch (e) {
      e.jot();
      return '';
    }
  }

  Color getColorFromHex([String? opacity]) {
    try {
      final alpha = opacity?.toInt(null, 0).toRadixString(16) ?? 'ff',
          cst = trimmed.contains('#')
              ? trimmed.replaceAll('#', alpha)
              : '$alpha$trimmed';
      return Color(cst.toInt(16, 0));
    } catch (e) {
      e.jot();
      return const Color(0x00000000);
    }
  }

  TimeOfDay parseTime([String? meridiem]) {
    if (trimmed.isNotEmpty &&
        RegExp(r':').hasMatch(trimmed) &&
        <int>[1, 2].contains(':'.allMatches(trimmed).length)) {
      if (!RegExp(r'\s+\b|\b\s|\s|\b').hasMatch(trimmed)) {
        final a = trimmed.split(':');
        final hr = a.first.toInt(null, 0) +
            (meridiem?.lowerCased.trimmed == 'pm' ? 12 : 0);
        return TimeOfDay(hour: hr, minute: a[1].toInt(null, 0));
      } else if (RegExp(r'\s+\b|\b\s|\s|\b').hasMatch(trimmed) &&
          RegExp(r'[a-zA-Z]').hasMatch(trimmed)) {
        final a = trimmed.split(' ');
        final a1 = a.first.split(':');
        final hr = a1.first.toInt(null, 0) +
            (a.last.trimmed.lowerCased == 'pm' ? 12 : 0);
        return TimeOfDay(hour: hr, minute: a1[1].toInt(null, 0));
      } else if (RegExp(r'\s+\b|\b\s|\s|\b').hasMatch(trimmed) &&
          !today.isAtSameMomentAs(dateTime)) {
        return TimeOfDay.fromDateTime(dateTime);
      } else {
        return thisMoment;
      }
    } else {
      return thisMoment;
    }
  }

  Future<List<Location>> get locations => locationFromAddress(trimmed);

  Future<List<Placemark>> get places => gco.placemarkFromAddress(trimmed);
}

extension Helper on BuildContext {
  ThemeData get theme => Theme.of(this);

  OverlayState? get ol => Overlay.of(this);

  Size get nonNullSize => MediaQuery.sizeOf(this);

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  ModalRoute<Object?>? get route => ModalRoute.of(this);

  EdgeInsets get insets => MediaQuery.viewInsetsOf(this);

  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  CupertinoThemeData get appleTheme => CupertinoTheme.of(this);

  ScaffoldState get sct => Scaffold.maybeOf(this) ?? Scaffold.of(this);

  NavigatorState get nav => Navigator.maybeOf(this) ?? Navigator.of(this);

  MediaQueryData get dimensions =>
      MediaQuery.maybeOf(this) ?? MediaQuery.of(this);

  AnimatedListState get als =>
      AnimatedList.maybeOf(this) ?? AnimatedList.of(this);

  ScaffoldMessengerState get smcT =>
      ScaffoldMessenger.maybeOf(this) ?? ScaffoldMessenger.of(this);

  SliverAnimatedListState get slas =>
      SliverAnimatedList.maybeOf(this) ?? SliverAnimatedList.of(this);

  TextTheme get textTheme => theme.textTheme;

  double get aspectRatio => nonNullSize.aspectRatio;

  double get pixelRatio => dimensions.devicePixelRatio;

  Brightness get brightness => dimensions.platformBrightness;

  double get radius => (width.square + height.square).squareRoot;

  bool get isMobile => isPortable && nonNullSize.shortestSide < 600;

  bool get isTablet => isPortable && nonNullSize.shortestSide >= 600;

  double get width => (dimensions.size.width + nonNullSize.width) / 2;

  double get height => (dimensions.size.height + nonNullSize.height) / 2;

  void hideSnackBar([SnackBarClosedReason? reason]) {
    smcT.hideCurrentSnackBar(reason: reason ?? SnackBarClosedReason.hide);
  }

  void goBack([dynamic result]) {
    try {
      Navigator.pop(this, result);
    } catch (e) {
      e.jot();
      navKey.currentState?.pop(result);
    }
  }

  void goBackForeverTo(String routeName) {
    try {
      Navigator.popUntil(this, routeName.popDestination);
    } catch (e) {
      e.jot();
      navKey.currentState?.popUntil(routeName.popDestination);
    }
  }

  void gotoFirstRoute() {
    try {
      Navigator.popUntil(this, isFirstRoute);
    } catch (e) {
      e.jot();
      navKey.currentState?.popUntil(isFirstRoute);
    }
  }

  void openDrawerIfAny() {
    sct.hasDrawer && !sct.isDrawerOpen ? sct.openDrawer() : doNothing();
  }

  void openEndDrawerIfAny() {
    sct.hasEndDrawer && !sct.isEndDrawerOpen
        ? sct.openEndDrawer()
        : doNothing();
  }

  void closeDrawerIfAnyOpen() {
    sct.hasDrawer && sct.isDrawerOpen ? sct.closeDrawer() : doNothing();
  }

  void closeEndIfAnyOpen() {
    sct.hasEndDrawer && sct.isEndDrawerOpen
        ? sct.closeEndDrawer()
        : doNothing();
  }

  // void addLoader(Duration time, {LoaderType? type}) {
  //   try {
  //     (ol?.mounted ?? false)
  //         ? ol?.insert(overlayLoader(time, type: type))
  //         : doNothing();
  //   } catch (e) {
  //     e.jot();
  //   }
  // }

  T? getWidget<T extends Widget>() {
    return findAncestorWidgetOfExactType<T>();
  }

  T? getState<T extends State<StatefulWidget>>() {
    return findAncestorStateOfType<T>();
  }

  Future<T?> goTo<T extends Object?>(String routeName, {dynamic args}) async {
    T? val;
    try {
      return route?.settings.name != routeName
          ? Navigator.pushNamed<T>(this, routeName, arguments: args)
          : Future.value(val);
    } catch (e) {
      e.jot();
      return route?.settings.name != routeName
          ? navKey.currentState?.pushNamed<T>(routeName, arguments: args)
          : Future.value(val);
    }
  }

  Future<T?> gotoOnce<T extends Object?, U extends Object?>(String routeName,
      {U? res, dynamic args}) async {
    T? val;
    try {
      return route?.settings.name != routeName
          ? Navigator.pushReplacementNamed<T, U>(this, routeName,
              result: res, arguments: args)
          : Future.value(val);
    } catch (e) {
      e.jot();
      return route?.settings.name != routeName
          ? navKey.currentState?.pushReplacementNamed<T, U>(routeName,
              result: res, arguments: args)
          : Future.value(val);
    }
  }

  Future<T?> gotoForever<T extends Object?>(String routeName,
      {dynamic args}) async {
    T? val;
    try {
      return route?.settings.name != routeName
          ? Navigator.pushNamedAndRemoveUntil<T>(this, routeName, predicate,
              arguments: args)
          : Future.value(val);
    } catch (e) {
      e.jot();
      return route?.settings.name != routeName
          ? navKey.currentState?.pushNamedAndRemoveUntil<T>(
              routeName, predicate,
              arguments: args)
          : Future.value(val);
    }
  }

  Future<DateTime?> showAllDatePicker(
      {Locale? locale,
      String? helpText,
      bool? use24hFormat,
      DateTime? lastDate,
      String? cancelText,
      ImageFilter? filter,
      String? confirmText,
      DateTime? firstDate,
      Color? barrierColor,
      Offset? anchorPoint,
      String? barrierLabel,
      DateTime? initialDate,
      DateTime? currentDate,
      String? fieldHintText,
      String? fieldLabelText,
      bool? useRootNavigator,
      Color? backgroundColor,
      String? errorFormatText,
      String? errorInvalidText,
      bool? barrierDismissible,
      TextInputType? keyboardType,
      RouteSettings? routeSettings,
      TextDirection? textDirection,
      CupertinoDatePickerMode? mode,
      DatePickerDateOrder? dateOrder,
      Icon? switchToInputEntryModeIcon,
      Icon? switchToCalendarEntryModeIcon,
      DatePickerMode? initialDatePickerMode,
      DatePickerEntryMode? initialEntryMode,
      bool Function(DateTime)? selectableDayPredicate,
      Widget Function(BuildContext, Widget?)? builder,
      void Function(DatePickerEntryMode)? onDatePickerModeChange}) async {
    assert(isCupertino ||
        ((firstDate != null || initialDate != null) &&
            (lastDate != null || currentDate != null)));
    Widget appleDatePicker(BuildContext context) {
      DateTime? picked;
      void changeDate(DateTime dt) {
        picked = dt;
      }

      return CupertinoActionSheet(
          title: const Text('Choose Date'),
          cancelButton: CustomButton(
              onPressed: () {
                goBack(picked);
              },
              child: const Icon(Icons.close_outlined)),
          message: SizedBox(
              width: width / 1.28,
              height: height / 1.6,
              child: CupertinoDatePicker(
                dateOrder: dateOrder,
                maximumDate: lastDate,
                minimumDate: firstDate,
                initialDateTime: initialDate,
                onDateTimeChanged: changeDate,
                backgroundColor: backgroundColor,
                use24hFormat: use24hFormat ?? false,
                mode: mode ?? CupertinoDatePickerMode.dateAndTime,
              )));
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return await showCupertinoModalPopup<DateTime>(
          context: this,
          filter: filter,
          builder: appleDatePicker,
          anchorPoint: anchorPoint,
          useRootNavigator: useRootNavigator ?? true,
          barrierDismissible: barrierDismissible ?? true,
          routeSettings: routeSettings ?? route?.settings,
          barrierColor: barrierColor ?? kCupertinoModalBarrierColor,
        );
      default:
        return await showDatePicker(
            context: this,
            builder: builder,
            cancelText: cancelText,
            confirmText: confirmText,
            initialDate: initialDate,
            currentDate: currentDate,
            anchorPoint: anchorPoint,
            barrierColor: barrierColor,
            barrierLabel: barrierLabel,
            textDirection: textDirection,
            useRootNavigator: useRootNavigator ?? true,
            lastDate: lastDate ?? (currentDate ?? today),
            firstDate: firstDate ?? (initialDate ?? today),
            selectableDayPredicate: selectableDayPredicate,
            barrierDismissible: barrierDismissible ?? true,
            onDatePickerModeChange: onDatePickerModeChange,
            routeSettings: routeSettings ?? route?.settings,
            switchToCalendarEntryModeIcon: switchToCalendarEntryModeIcon,
            initialDatePickerMode: initialDatePickerMode ?? DatePickerMode.day,
            initialEntryMode: initialEntryMode ?? DatePickerEntryMode.calendar);
    }
  }

  Future<bool?> appearDialogBox(
      {Widget? title,
      Widget? child,
      Widget? content,
      bool? dismissive,
      String? barrierLabel,
      List<Widget>? actions,
      TextStyle? titleStyle,
      Curve? insetAnimation,
      TextStyle? actionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      EdgeInsets? contentPadding,
      RouteSettings? routeSettings,
      ScrollController? scrollController,
      MainAxisAlignment? actionsAlignment,
      ScrollController? actionScrollController}) {
    return showDialogBox<bool>(
        title: title,
        child: child,
        content: content,
        actions: actions,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        titlePadding: titlePadding,
        barrierLabel: barrierLabel,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetDuration: insetDuration,
        routeSettings: routeSettings,
        insetAnimation: insetAnimation,
        contentPadding: contentPadding,
        scrollController: scrollController,
        actionsAlignment: actionsAlignment,
        actionScrollController: actionScrollController);
  }

  Future<bool> revealDialogBox(List<String> options, List<VoidCallback> actions,
      {String? title,
      String? action,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      required ButtonType bt,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) async {
    Widget optionsMap(String e) {
      final child = Text(e, style: optionStyle);
      final onTap = actions[options.indexOf(e)];
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return CupertinoDialogAction(
              onPressed: onTap, textStyle: actionStyle, child: child);
        default:
          return CustomButton(onPressed: onTap, type: bt, child: child);
      }
    }

    return options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty
        ? ((await appearDialogBox(
                dismissive: dismissive,
                titleStyle: titleStyle,
                actionStyle: actionStyle,
                titlePadding: titlePadding,
                buttonPadding: buttonPadding,
                actionPadding: actionPadding,
                insetDuration: insetDuration,
                insetAnimation: insetAnimation,
                scrollController: scrollController,
                actionScrollController: actionScrollController,
                actions: options.map<Widget>(optionsMap).toList(),
                title: title == null ? null : Text(title),
                content: action == null ? null : Text(action))) ??
            false)
        : options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty;
  }

  Future<bool> showSimpleYesNo(
      {bool? flag,
      bool? reverse,
      String? title,
      String? action,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      required ButtonType bt,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) {
    VoidCallback mapAction(String action) {
      return () {
        goBack(action.toFlag);
      };
    }

    final options = [
      (flag ?? true) ? 'Yes' : 'Ok',
      (flag ?? true) ? 'No' : 'Cancel'
    ];
    final actions = ((reverse ?? false) ? options.reversed : options)
        .map<VoidCallback>(mapAction)
        .toList();
    return revealDialogBox(options, actions,
        bt: bt,
        title: title,
        action: action,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        optionStyle: optionStyle,
        titlePadding: titlePadding,
        insetDuration: insetDuration,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetAnimation: insetAnimation,
        scrollController: scrollController,
        actionScrollController: actionScrollController);
  }

  Future<bool> showSimplePopup(String option, VoidCallback onActionDone,
      {required ButtonType bt,
      String? action,
      String? title,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) {
    return revealDialogBox([option], [onActionDone],
        bt: bt,
        title: title,
        action: action,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        optionStyle: optionStyle,
        titlePadding: titlePadding,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetDuration: insetDuration,
        insetAnimation: insetAnimation,
        scrollController: scrollController,
        actionScrollController: actionScrollController);
  }

  Future<T?> showDialogBox<T>(
      {Widget? child,
      Widget? title,
      Widget? content,
      bool? dismissive,
      String? barrierLabel,
      List<Widget>? actions,
      TextStyle? titleStyle,
      Curve? insetAnimation,
      TextStyle? actionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      EdgeInsets? contentPadding,
      RouteSettings? routeSettings,
      ScrollController? scrollController,
      MainAxisAlignment? actionsAlignment,
      ScrollController? actionScrollController}) {
    Widget dialogBuilder(BuildContext context) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return CupertinoAlertDialog(
              title: title,
              content: content,
              actions: actions ?? <Widget>[],
              scrollController: scrollController,
              actionScrollController: actionScrollController,
              insetAnimationCurve: insetAnimation ?? Curves.decelerate,
              insetAnimationDuration:
                  insetDuration ?? const Duration(milliseconds: 100));
        default:
          return child ??
              AlertDialog(
                  title: title,
                  content: content,
                  actions: actions,
                  titlePadding: titlePadding,
                  titleTextStyle: titleStyle,
                  buttonPadding: buttonPadding,
                  contentTextStyle: actionStyle,
                  actionsPadding: actionPadding,
                  contentPadding: contentPadding,
                  actionsAlignment: actionsAlignment);
      }
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return showCupertinoDialog<T>(
            context: this,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            barrierDismissible: dismissive ?? false,
            routeSettings: routeSettings ?? route?.settings);
      default:
        return showDialog<T>(
            context: this,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            barrierDismissible: dismissive ?? false,
            routeSettings: routeSettings ?? route?.settings);
    }
  }

  Future<T?> showBottomPopup<T>(
      {Widget? child,
      Widget? title,
      Widget? message,
      double? elevation,
      ShapeBorder? shape,
      Clip? clipBehavior,
      Color? barrierColor,
      ImageFilter? filter,
      Offset? anchorPoint,
      Widget? cancelButton,
      List<Widget>? actions,
      Color? backgroundColor,
      bool? semanticsDismissible,
      BoxConstraints? constraints,
      RouteSettings? routeSettings,
      ScrollController? actionScrollController,
      ScrollController? messageScrollController,
      AnimationController? transitionAnimationController}) {
    Widget bottomPopupBuilder(BuildContext context) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return CupertinoActionSheet(
              title: title,
              message: message,
              actions: actions,
              cancelButton: cancelButton,
              actionScrollController: actionScrollController,
              messageScrollController: messageScrollController);
        default:
          return child ?? const EmptyWidget();
      }
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return showCupertinoModalPopup<T>(
            context: this,
            filter: filter,
            anchorPoint: anchorPoint,
            builder: bottomPopupBuilder,
            routeSettings: routeSettings ?? route?.settings,
            semanticsDismissible: semanticsDismissible ?? false);
      default:
        return showModalBottomSheet<T>(
            shape: shape,
            context: this,
            elevation: elevation,
            anchorPoint: anchorPoint,
            constraints: constraints,
            barrierColor: barrierColor,
            clipBehavior: clipBehavior,
            builder: bottomPopupBuilder,
            backgroundColor: backgroundColor,
            routeSettings: routeSettings ?? route?.settings,
            transitionAnimationController: transitionAnimationController);
    }
  }

  Future<T?> manifestDialogBox<T>(
      List<String> options, List<VoidCallback> actions, ButtonType type,
      {String? title,
      String? action,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) async {
    Widget optionsMap(String e) {
      final child = Text(e, style: optionStyle);
      final onTap = actions[options.indexOf(e)];
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          return CupertinoDialogAction(
              onPressed: onTap, textStyle: actionStyle, child: child);
        default:
          return CustomButton(type: type, onPressed: onTap, child: child);
      }
    }

    return options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty
        ? await showDialogBox<T>(
            dismissive: dismissive,
            titleStyle: titleStyle,
            actionStyle: actionStyle,
            titlePadding: titlePadding,
            buttonPadding: buttonPadding,
            actionPadding: actionPadding,
            insetDuration: insetDuration,
            insetAnimation: insetAnimation,
            scrollController: scrollController,
            title: title == null ? null : Text(title),
            content: action == null ? null : Text(action),
            actionScrollController: actionScrollController,
            actions: options.map<Widget>(optionsMap).toList())
        : null;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> revealSnackBar(
      {double? width,
      Widget? content,
      double? elevation,
      ShapeBorder? shape,
      Duration? duration,
      Clip? clipBehaviour,
      Color? backgroundColor,
      SnackBarAction? action,
      VoidCallback? onVisible,
      SnackBarBehavior? behavior,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      Animation<double>? animation,
      DismissDirection? direction}) {
    return smcT.showSnackBar(SnackBar(
        shape: shape,
        width: width,
        action: action,
        margin: margin,
        padding: padding,
        behavior: behavior,
        elevation: elevation,
        animation: animation,
        onVisible: onVisible,
        backgroundColor: backgroundColor,
        content: content ?? const EmptyWidget(),
        clipBehavior: clipBehaviour ?? Clip.hardEdge,
        dismissDirection: direction ?? DismissDirection.down,
        duration: duration ?? const Duration(milliseconds: 4000)));
  }
}
