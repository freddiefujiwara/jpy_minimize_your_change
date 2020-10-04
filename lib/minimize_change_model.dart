import 'dart:math';

import 'package:flutter/cupertino.dart';

enum Bill {
  one,
  five,
  ten,
  fifty,
  oneHundred,
  fiveHundreds,
  oneThousand,
  fiveThousands,
  tenThousands,
}

class MinimizeChangeModel extends ChangeNotifier {
  List<int> _bills = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int _billing = 0;
  MinimizeChangeModel() {
    this.clear();
  }
  void clear() {
    Bill.values.forEach((b) => this._bills[b.index] = 0);
    this._billing = 0;
    notifyListeners();
  }

  void increment(Bill b, int number) {
    this._bills[b.index] += number;
    notifyListeners();
  }

  int number(Bill b) {
    return this._bills[b.index];
  }

  int sum() {
    double sum = 0.0;
    Bill.values.forEach((b) {
      sum += b.index % 2 == 0
          ? this._bills[b.index] * pow(10, b.index / 2)
          : this._bills[b.index] * pow(10, (b.index + 1) / 2) / 2;
    });
    return sum.round();
  }

  bool canPay() => this._billing <= this.sum();

  set billing(int _billing) => this._billing = _billing;
  int get billing => this._billing;
}
