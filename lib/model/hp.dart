import 'dart:math';

import 'package:flutter/material.dart';

class Hp extends ChangeNotifier {
  static const maxHp = 100;
  static const minHp = 0;
  static const goal = 100;

  int _hp = 80;
  int get hp => _hp;

  getPudding() {
    _hp = min(hp + 3, maxHp);
    notifyListeners();
  }

  lostHp(int value) {
    _hp -= value;
    notifyListeners();
  }

  int _currentPosition = 0;
  bool get won => _currentPosition >= goal;
  bool get gameOver => _hp <= minHp;

  int get currentPosition => _currentPosition;
  step() {
    if (!won && _hp > minHp) {
      _currentPosition++;
    }
    notifyListeners();
  }
}
