import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchModel extends ChangeNotifier {
  // 1. Setup Singleton (Hanya satu instance Stopwatch di memori)
  static final StopwatchModel _instance = StopwatchModel._internal();
  factory StopwatchModel() => _instance;
  StopwatchModel._internal(); // Private constructor agar tidak bisa di-instantiate ulang

  // 2. Deklarasi Variabel Utama
  final Stopwatch _nativeStopwatch =
      Stopwatch(); // Mesin core stopwatch bawaan Dart
  Timer? _timer; // Timer untuk memicu update UI secara berkala
  List<String> laps = [];

  bool get isRunning => _nativeStopwatch.isRunning;

  // 3. Logika Start/Stop Stopwatch
  void toggle() {
    if (_nativeStopwatch.isRunning) {
      _nativeStopwatch.stop();
      _timer?.cancel(); // Matikan timer saat pause agar hemat CPU/Baterai
      notifyListeners(); // Beritahu UI untuk mengubah icon menjadi Play
    } else {
      _nativeStopwatch.start();
      // Jalankan timer yang memicu update UI (notifyListeners) setiap 100ms (0.1 detik)
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        notifyListeners();
      });
    }
  }

  // 4. Logika Menambah Lap (Hanya jika stopwatch berjalan)
  void addLap() {
    if (_nativeStopwatch.isRunning) {
      // insert(0, ...) memastikan lap terbaru selalu digeser ke urutan paling atas List
      laps.insert(0, formatTime());
      notifyListeners(); // Beritahu UI agar ListView merender data baru
    }
  }

  // 5. Logika Reset Data (Kembali ke nol)
  void reset() {
    _nativeStopwatch.reset(); // Kembalikan waktu asli ke 0
    _nativeStopwatch.stop(); // Pastikan mesin berhenti
    _timer?.cancel(); // Matikan timer update layar
    laps.clear(); // Kosongkan list riwayat lap
    notifyListeners();
  }

  // 6. Format Waktu ke String (HH:MM:SS:ms)
  String formatTime() {
    int milliseconds = _nativeStopwatch.elapsedMilliseconds;

    // ~/ (Integer Division) membagi bilangan dan membuang desimalnya
    // % (Modulo) mendapatkan sisa bagi agar angka kembali ke 0 setelah mencapai 60
    int h = milliseconds ~/ 3600000;
    int m = (milliseconds ~/ 60000) % 60;
    int s = (milliseconds ~/ 1000) % 60;
    int ms =
        (milliseconds % 1000) ~/
        100; // Mengambil digit pertama (ratusan) dari milidetik

    // padLeft(2, '0') memastikan angka selalu 2 digit (contoh: angka 5 menjadi "05")
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}:${ms.toString().padLeft(2, '0')}";
  }
}
