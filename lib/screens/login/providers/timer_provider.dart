import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerProvider extends ChangeNotifier {
  int _ticks = 60;

  int get ticks => _ticks;

  Timer _timer;

  Timer get timer => _timer;

  bool enable = true;

  void reset() {
    _ticks = 60;
    enable = true;
    notifyListeners();
  }

  void startTimer() {
    enable = false;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_ticks < 1) {
        enable = true;
        timer.cancel();
      } else {
        _ticks = _ticks - 1;
      }
      notifyListeners();
    });
  }
}
