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
  List<int> _pays = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int _billing = 0;
  MinimizeChangeModel() {
    this.clear();
  }
  void clear() {
    Bill.values.forEach((b) => this._bills[b.index] = this._pays[b.index] = 0);
    this._billing = 0;
    notifyListeners();
  }

  void increment(Bill b, int number) {
    this._bills[b.index] += number;
    notifyListeners();
  }

  int numberOfBills(Bill b) {
    return this._bills[b.index];
  }

  int numberOfPays(Bill b) {
    return this._pays[b.index];
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

  void minimize() {
    int rest = this._billing;
    // one
    if (this._bills[Bill.one.index] >= rest % 10) {
      this._pays[Bill.one.index] = rest % 10;
      this._bills[Bill.one.index] -= rest % 10;
    } else if (rest % 10 < 5) {
      if (this._bills[Bill.five.index] > 0) {
        this._pays[Bill.five.index]++;
        this._bills[Bill.five.index]--;
      }
    } else {
      if (this._bills[Bill.one.index] >= (rest % 10 - 5)) {
        this._pays[Bill.one.index] = rest % 10 - 5;
        this._bills[Bill.one.index] -= rest % 10 - 5;
      }
    }
    rest -= rest % 10;

    // ten
    if (this._bills[Bill.ten.index] >= ((rest % 100) / 10).round()) {
      this._pays[Bill.ten.index] = ((rest % 100) / 10).round();
      this._bills[Bill.ten.index] -= ((rest % 100) / 10).round();
    } else if (((rest % 100) / 10).round() < 5) {
      if (this._bills[Bill.fifty.index] > 0) {
        this._pays[Bill.fifty.index]++;
        this._bills[Bill.fifty.index]--;
      }
    } else {
      if (this._bills[Bill.ten.index] >= (((rest % 100) / 10).round() - 5)) {
        this._pays[Bill.ten.index] = ((rest % 100) / 10).round() - 5;
        this._bills[Bill.ten.index] -= ((rest % 100) / 10).round() - 5;
      }
    }
    rest -= rest % 100;

    // hundred
    if (this._bills[Bill.oneHundred.index] >= ((rest % 1000) / 100).round()) {
      this._pays[Bill.oneHundred.index] = ((rest % 1000) / 100).round();
      this._bills[Bill.oneHundred.index] -= ((rest % 1000) / 100).round();
    } else if (((rest % 1000) / 100).round() < 5) {
      if (this._bills[Bill.fiveHundreds.index] > 0) {
        this._pays[Bill.fiveHundreds.index]++;
        this._bills[Bill.fiveHundreds.index]--;
      }
    } else {
      if (this._bills[Bill.oneHundred.index] >=
          (((rest % 1000) / 100).round() - 5)) {
        this._pays[Bill.oneHundred.index] = ((rest % 1000) / 100).round() - 5;
        this._bills[Bill.oneHundred.index] -= ((rest % 1000) / 100).round() - 5;
      }
    }
    rest -= rest % 1000;

    // thousand
    if (this._bills[Bill.oneThousand.index] >=
        ((rest % 10000) / 1000).round()) {
      this._pays[Bill.oneThousand.index] = ((rest % 10000) / 1000).round();
      this._bills[Bill.oneThousand.index] -= ((rest % 10000) / 1000).round();
    } else if (((rest % 10000) / 1000).round() < 5) {
      if (this._bills[Bill.fiveThousands.index] > 0) {
        this._pays[Bill.fiveThousands.index]++;
        this._bills[Bill.fiveThousands.index]--;
      }
    } else {
      if (this._bills[Bill.oneThousand.index] >=
          (((rest % 10000) / 1000).round() - 5)) {
        this._pays[Bill.oneThousand.index] =
            ((rest % 10000) / 1000).round() - 5;
        this._bills[Bill.oneThousand.index] -=
            ((rest % 10000) / 1000).round() - 5;
      }
    }
    rest -= rest % 10000;
  }

  bool canPay() => this._billing <= this.sum();

  set billing(int _billing) => this._billing = _billing;
  int get billing => this._billing;
}
