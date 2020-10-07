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
    this._bills = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    this._billing = 0;
    notifyListeners();
  }

  void increment(Bill b, {int number = 1}) {
    this._bills[b.index] += number;
    notifyListeners();
  }

  void decrement(Bill b, {int number = 1}) {
    this._bills[b.index] -= number;
    if (this._bills[b.index] < 0) {
      this._bills[b.index] = 0;
    }
    notifyListeners();
  }

  int numberOfBills(Bill b) {
    return this._bills[b.index];
  }

  int totalNumberOfBills({List<int> bills}) {
    if (bills == null) {
      bills = this._bills;
    }
    int sum = 0;
    bills.forEach((v) => sum += v);
    return sum;
  }

  int sum({List<int> bills}) {
    if (bills == null) {
      bills = this._bills;
    }
    int sum = 0;
    final List<int> values = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000];
    Bill.values.forEach((b) {
      sum += bills[b.index] * values[b.index];
    });
    return sum;
  }

  List<List<int>> allSubsetsCanBePaid() {
    List<String> candidates = [];
    final List<int> values = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000];
    Bill.values.forEach((b) {
      int value = values[b.index];
      for (var i = 0; i < this.numberOfBills(b); i++) {
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
    }).forEach((s) {
      List<int> pays = [0, 0, 0, 0, 0, 0, 0, 0, 0];
      s.forEach((b) {
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
    final int currentBills = this.totalNumberOfBills();
    int minimumBills = currentBills;
    List<int> bestPay = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> bestChange = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    this.allSubsetsCanBePaid().forEach((s) {
      final List<int> changes =
          this.changeToBills(this.sum(bills: s) - this._billing);
      final int pay = this.totalNumberOfBills(bills: s);
      final int change = this.totalNumberOfBills(bills: changes);
      if (minimumBills > currentBills - pay + change) {
        bestPay = s;
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
