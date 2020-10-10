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

class _MinimizeChangeData {
  List<int> _bills = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int _billing = 0;
  static final _MinimizeChangeData _instance = _MinimizeChangeData();

  static _MinimizeChangeData get instance {
    return _instance;
  }

  _MinimizeChangeData() {
    this.clear();
  }

  void clear() {
    this._bills = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    this._billing = 0;
  }

  void increment(Bill b, {int number = 1}) {
    this._bills[b.index] += number;
  }

  void decrement(Bill b, {int number = 1}) {
    this._bills[b.index] -= number;
    if (this._bills[b.index] < 0) {
      this._bills[b.index] = 0;
    }
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
    int minimumBills = -1;
    List<int> bestPay = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> bestChange = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    this.allSubsetsCanBePaid().forEach((s) {
      final List<int> changes =
          this.changeToBills(this.sum(bills: s) - this._billing);
      final int pay = this.totalNumberOfBills(bills: s);
      final int change = this.totalNumberOfBills(bills: changes);
      if (minimumBills == -1 || minimumBills > currentBills - pay + change) {
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

class MinimizeChangeModel extends ChangeNotifier {
  _MinimizeChangeData _minimizeChangeData;

  MinimizeChangeModel() {
    this._minimizeChangeData = _MinimizeChangeData.instance;
  }
  void clear() {
    this._minimizeChangeData.clear();
    notifyListeners();
  }

  void increment(Bill b, {int number = 1}) {
    this._minimizeChangeData.increment(b, number: number);
    notifyListeners();
  }

  void decrement(Bill b, {int number = 1}) {
    this._minimizeChangeData.decrement(b, number: number);
    notifyListeners();
  }

  int numberOfBills(Bill b) {
    return this._minimizeChangeData.numberOfBills(b);
  }

  int totalNumberOfBills({List<int> bills}) {
    return this._minimizeChangeData.totalNumberOfBills(bills: bills);
  }

  int sum({List<int> bills}) {
    return this._minimizeChangeData.sum(bills:bills);
  }

  List<List<int>> allSubsetsCanBePaid() {
    return this._minimizeChangeData.allSubsetsCanBePaid();
  }

  List<int> changeToBills(int change) {
    return this._minimizeChangeData.changeToBills(change);
  }

  List<List<int>> minimumPays() {
    return this._minimizeChangeData.minimumPays();
  }

  bool canPay() => this._minimizeChangeData.canPay();

  set billing(int _billing) => this._minimizeChangeData.billing = _billing;
  int get billing => this._minimizeChangeData.billing;
}