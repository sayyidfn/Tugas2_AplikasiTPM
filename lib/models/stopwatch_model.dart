import 'dart:async';
import 'package:flutter/material.dart'; 
class StopwatchModel extends ChangeNotifier {
  static final StopwatchModel _instance = StopwatchModel._internal();
  factory StopwatchModel() => _instance;
  StopwatchModel._internal();

  final Stopwatch _nativeStopwatch = Stopwatch();
  Timer? _timer;
  List<String> laps = [];

  bool get isRunning => _nativeStopwatch.isRunning;

  void toggle() {
    if (_nativeStopwatch.isRunning) {
      _nativeStopwatch.stop();
      _timer?.cancel();
      notifyListeners();
    } else {
      _nativeStopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        notifyListeners();
      });
    }
  }

  void addLap() {
    if (_nativeStopwatch.isRunning) {
      laps.insert(0, formatTime());
      notifyListeners();
    }
  }

  void reset() {
    _nativeStopwatch.reset();
    _nativeStopwatch.stop();
    _timer?.cancel();
    laps.clear();
    notifyListeners();
  }

  String formatTime() {
    int milliseconds = _nativeStopwatch.elapsedMilliseconds;
    int h = milliseconds ~/ 3600000;
    int m = (milliseconds ~/ 60000) % 60;
    int s = (milliseconds ~/ 1000) % 60;
    int ms = (milliseconds % 1000) ~/ 100;

    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}";
  }
}
