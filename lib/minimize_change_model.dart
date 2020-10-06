import 'package:trotter/trotter.dart';
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

  int numberOfBills(Bill b) {
    return this._bills[b.index];
  }

  int sum() {
    int sum = 0;
    final List<int> values = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000];
    Bill.values.forEach((b) {
      sum += this._bills[b.index] * values[b.index];
    });
    return sum;
  }

  List<List<int>> allSubsetsCanBePaid() {
    List<String> candidates = [];
    final List<int> values = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000];
    Bill.values.forEach((b) {
      int value = values[b.index];
      for (var i = 0; i < this._bills[b.index]; i++) {
        candidates.add("${i}_$value");
      }
    });
    List<List<int>> subs = [];
    final subSet = Subsets(candidates);
    subSet().where((s) {
      int sum = 0;
      s.forEach((b) {
        final match = RegExp("^[0-9]+_([0-9]+)").firstMatch(b);
        sum += int.parse(match.group(1));
      });
      return this._billing <= sum;
    }).forEach((c) {
      List<int> pays = [0, 0, 0, 0, 0, 0, 0, 0, 0];
      c.forEach((b) {
        final match = RegExp("^[0-9]+_([0-9]+)").firstMatch(b);
        pays[values.indexOf(int.parse(match.group(1)))]++;
      });
      subs.add(pays);
    });
    return subs;
  }

  List<int> changeToBills(int change) {
    List<int> bills = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    final List<int> values = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000];
    int i = 0;
    values.reversed.forEach((value) {
      bills[bills.length - i - 1] = (change / value).floor();
      change = change % value;
      i++;
    });
    return bills;
  }

  List<List<int>> minimumPays() {
    int currentBills = 0;
    this._bills.forEach((v) => currentBills += v);
    int minimumBills = currentBills;
    List<int> bestPay = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> bestChange = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    final List<int> values = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000];
    this.allSubsetsCanBePaid().forEach((c) {
      int pay = 0;
      c.forEach((v) => pay += v);
      int payValue = 0;
      int i = 0;
      c.forEach((v) {
        payValue += v * values[i];
        i++;
      });
      List<int> changes = this.changeToBills(payValue - this._billing);
      int change = 0;
      changes.forEach((v) => change += v);
      if (minimumBills > currentBills - pay + change) {
        bestPay = c;
        bestChange = changes;
        minimumBills = currentBills - pay + change;
      }
    });
    return [bestPay, bestChange];
  }

  bool canPay() => this._billing <= this.sum();

  set billing(int _billing) => this._billing = _billing;
  int get billing => this._billing;
}
