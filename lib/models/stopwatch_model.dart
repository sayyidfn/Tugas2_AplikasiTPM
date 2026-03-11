import 'dart:async';

class StopwatchModel {
  static final StopwatchModel _instance = StopwatchModel._internal();
  factory StopwatchModel() => _instance;
  StopwatchModel._internal();

  int seconds = 0;
  bool isRunning = false;
  Timer? _timer;
  Function(int)? onTick;
  Function(bool)? onStatusChange;

  void toggle(Function updateUI) {
    if (isRunning) {
      _timer?.cancel();
      isRunning = false;
    } else {
      isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        seconds++;
        updateUI();
        if (onTick != null) onTick!(seconds);
      });
    }
    if (onStatusChange != null) onStatusChange!(isRunning);
  }

  void reset(Function updateUI) {
    _timer?.cancel();
    seconds = 0;
    isRunning = false;
    updateUI();
  }

  String formatTime() {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}
