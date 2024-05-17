import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/common_controller.dart';
import '../extensions/extensions.dart';
// import '../modules/common/common_module.dart';
// import '../modules/common/models/progress.dart';
// import '../modules/common/views/widgets/circular_loader.dart';
import '../views/widgets/common/empty_widget.dart';
import 'enums.dart';
import 'values.dart';

void rollbackOrientations() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void lockScreenRotation() async {
  await SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
  ]);
}

void showStatusBar() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
}

void putLazyCommon({String? tag, bool? fenix}) {
  putLazy<CommonController>(getCommonModule);
}

void putLazy<T extends GetMaterialController>(T Function() builder,
    {String? tag, bool? fenix}) {
  Get.lazyPut<T>(builder, tag: tag, fenix: fenix ?? false);
}

void doNothing() {}

// OverlayEntry overlayLoader(Duration time, {LoaderType? type}) {
//   Widget loaderBuilder(BuildContext context) {
//     return Positioned(
//         top: 0,
//         left: 0,
//         width: context.width,
//         height: context.height,
//         child: Material(
//             color: context.theme.primaryColor.withOpacity(0.5),
//             child: CircularLoader(
//                 duration: time,
//                 loaderType: type,
//                 // heightFactor: 16,
//                 // widthFactor: 16,
//                 color: context.theme.primaryColor)));
//   }

//   return OverlayEntry(builder: loaderBuilder);
// }

bool onBadCertificate(X509Certificate cert, String host, int port) {
  return true;
}

T putDefault<T extends GetMaterialController>(T dep,
    [String? tag, bool? permanent, T Function()? builder]) {
  return Get.put<T>(dep,
      tag: tag, permanent: permanent ?? false, builder: builder);
}

bool predicate(Route<dynamic> route) {
  route.jot();
  return false;
}

Icon obtainStar(int index) {
  return index.filledStar;
}

Icon obtainStarOutline(int index) {
  return index.outlinedStar;
}

CommonController getCommonModule() {
  return CommonController();
}

bool isFirstRoute(Route route) {
  route.jot();
  return route.isFirst;
}

bool isActiveRoute(Route route) {
  route.jot();
  return route.isActive;
}

bool isCurrentRoute(Route route) {
  route.jot();
  return route.isCurrent;
}

bool predicate4(Route route) {
  route.jot();
  return route.hasActiveRouteBelow;
}

bool predicate5(Route route) {
  route.jot();
  return route.willHandlePopInternally;
}

double getDoubleData(Map<String, dynamic> data) {
  return (data['data'] as double);
}

bool getBoolData(Map<String, dynamic> data) {
  return (data['data'] as bool);
}

String getData(List<int> values) {
  return base64.encode(values);
}

Uint8List fromIntList(List<int> list) {
  return getData(list).listData;
}

// Widget errorBuilder(BuildContext context, Object object, StackTrace? trace) {
//   object.jot();
//   trace.jot();
//   return Icon(Icons.error,
//       size: context.height / 16, color: context.theme.secondaryHeaderColor);
// }

// Widget getPageLoader(Size size) {
//   return Image.asset('${assetImagePath}loading_trend.gif',
//       width: size.width, fit: BoxFit.fill, height: size.height);
// }

// Widget getPageLoader1(Size size) {
//   return Image.asset('${assetImagePath}loader1.gif',
//       width: size.width, fit: BoxFit.fill, height: size.height);
// }

Widget getImageLoader(BuildContext context, Widget child, int? i, bool flag) {
  i.jot();
  flag.jot();
  return const EmptyWidget();
}

// Widget getPlaceHolderNoImage(BuildContext context, String url) {
//   return Image.asset('${assetImagePath}noImage.png',
//       height: context.height / 12.8,
//       width: context.width / 6.4,
//       fit: BoxFit.fill);
// }

Widget getErrorWidget(BuildContext context, Object object, StackTrace? trace) {
  object.jot();
  trace.jot();
  return Text(object.string);
}

// Widget getErrorWidget(BuildContext context, String url, dynamic error) {
//   return Image.asset('${assetImagePath}noImage.png',
//       height: context.height / 12.8,
//       width: context.width / 6.4,
//       fit: BoxFit.fill);
// }

// Widget getLoaderBuilder(
//     BuildContext context, Widget child, ImageChunkEvent? event) {
//   try {
//     final value = (event?.cumulativeBytesLoaded ?? double.nan) /
//         (event?.expectedTotalBytes ?? double.nan);
//     context
//         .getCommonProvider(false)
//         .addBenchMark(BenchMark(value, '${(value * 100).toStringAsFixed(2)}%'));
//     return const CircularLoader(loaderType: LoaderType.normal);
//   } catch (e) {
//     e.jot();
//     return child;
//   }
// }

Future<Uint8List> getBytesFromAsset(String path,
    {int? width, int? height}) async {
  final data = await rootBundle.load(path);
  final codec = await instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  final fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<XFile?> chooseMedium(ImageSource source,
    {PickType? type,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    Duration? maxDuration,
    bool? requestFullMetadata,
    CameraDevice? preferredCameraDevice}) async {
  try {
    switch (type) {
      case PickType.image:
        return picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality,
            requestFullMetadata: requestFullMetadata ?? true,
            preferredCameraDevice: preferredCameraDevice ?? CameraDevice.rear);
      case PickType.media:
        return picker.pickMedia(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality,
            requestFullMetadata: requestFullMetadata ?? true);
      case PickType.video:
        return picker.pickVideo(
            source: source,
            maxDuration: maxDuration,
            preferredCameraDevice: preferredCameraDevice ?? CameraDevice.rear);
      default:
        return null;
    }
  } catch (e) {
    e.jot();
    return null;
  }
}
