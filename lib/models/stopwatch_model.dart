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

  // Start/stop stopwatch
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

  // Menambah Lap
  void addLap() {
    if (_nativeStopwatch.isRunning) {
      laps.insert(0, formatTime());
      notifyListeners();
    }
  }

  // Reset
  void reset() {
    _nativeStopwatch.reset();
    _nativeStopwatch.stop();
    _timer?.cancel();
    laps.clear();
    notifyListeners();
  }

  // Format waktu (HH:MM:SS:ms)
  String formatTime() {
    int milliseconds = _nativeStopwatch.elapsedMilliseconds;

    // ~/ (Integer Division) membagi bilangan dan membuang desimalnya
    // % (Modulo) mendapatkan sisa bagi agar angka kembali ke 0 setelah mencapai 60
    int h = milliseconds ~/ 3600000;
    int m = (milliseconds ~/ 60000) % 60;
    int s = (milliseconds ~/ 1000) % 60;
    int ms =
        (milliseconds % 1000) ~/
        10; // Mengambil digit pertama (ratusan) dari milidetik

    // padLeft(2, '0') memastikan angka selalu 2 digit (contoh: angka 5 menjadi "05")
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}:${ms.toString().padLeft(2, '0')}";
  }
}
