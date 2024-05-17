import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../extensions/extensions.dart';
import '../models/common/bench_mark.dart';
import '../utils/keys.dart';
import '../utils/methods.dart';
import '../utils/values.dart';

class CommonController extends GetMaterialController
    with AnimationLocalStatusListenersMixin {
  static final CommonController _singleton = CommonController._internal();

  factory CommonController() {
    return _singleton;
  }

  CommonController._internal();

  RxInt count = 0.obs;

  Animation<double>? animation;

  AnimationController? animationController;

  final _progressCon = StreamController<BenchMark>.broadcast();

  Stream<BenchMark> get progress => _progressCon.stream;

  BuildContext? get bc =>
      navKey.currentContext ?? wb?.buildOwner?.focusManager.rootScope.context;

  void addBenchMark(BenchMark p) {
    _progressCon.add(p);
  }

  void onBenchMark(int a, int b) async {
    ssc ??= progress.listen(onBenchMarkData);
    'a: $a / b: $b'.jot();
    addBenchMark(BenchMark(a / b, '${((a * 100) / b).toStringAsFixed(2)}%'));
    if (a == b) {
      await ssc?.cancel();
      ssc = null;
    }
  }

  void onBenchMarkData(BenchMark event) {
    event.jot();
  }

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }

  void gotoNextScreen(Duration timeStamp) async {
    (await Future<Object?>.delayed(
            timeStamp.inSeconds == 3 ? timeStamp : const Duration(seconds: 3),
            nextScreen))
        ?.jot();
  }

  void detectChange(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
      case AnimationStatus.dismissed:
        animationController?.dispose();
        break;
      default:
        doNothing();
        break;
    }
  }

  void goFrontIfMounted([double? from]) async {
    await animationController?.forward(from: from);
    // animationController?.notifyListeners();
    animationController?.notifyStatusListeners(AnimationStatus.forward);
  }

  void assignState(TickerProvider tp) {
    void setData(Duration duration) {
      animationController = AnimationController(duration: duration, vsync: tp);
      animation = Tween<double>(begin: bc?.pixelRatio, end: 0).animate(
          CurvedAnimation(parent: animationController!, curve: Curves.easeOut))
        ..addListener(goFrontIfMounted)
        ..addStatusListener(detectChange);
    }

    wb?.addPostFrameCallback(setData);
  }

  void loaderDispose() {
    animationController?.dispose();
  }

  FutureOr nextScreen() {
    return Get.offNamedUntil('/sample', predicate);
  }

  @override
  void didRegisterListener() {
    // TODO: implement didRegisterListener
  }

  @override
  void didUnregisterListener() {
    // TODO: implement didUnregisterListener
  }
}
