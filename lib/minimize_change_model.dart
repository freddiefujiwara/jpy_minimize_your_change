import 'package:trotter/trotter.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('one');
    prefs.remove('five');
    prefs.remove('ten');
    prefs.remove('fifty');
    prefs.remove('oneHundred');
    prefs.remove('fiveHundreds');
    prefs.remove('oneThousand');
    prefs.remove('fiveThousands');
    prefs.remove('tenThousands');
  }

  Future save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('one', this._bills[Bill.one.index]);
    prefs.setInt('five', this._bills[Bill.five.index]);
    prefs.setInt('ten', this._bills[Bill.ten.index]);
    prefs.setInt('fifty', this._bills[Bill.fifty.index]);
    prefs.setInt('oneHundred', this._bills[Bill.oneHundred.index]);
    prefs.setInt('fiveHundreds', this._bills[Bill.fiveHundreds.index]);
    prefs.setInt('oneThousand', this._bills[Bill.oneThousand.index]);
    prefs.setInt('fiveThousands', this._bills[Bill.fiveThousands.index]);
    prefs.setInt('tenThousands', this._bills[Bill.tenThousands.index]);
  }

  Future restore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._bills[Bill.one.index] =
        prefs.getInt('one') == null ? 0 : prefs.getInt('one');
    this._bills[Bill.five.index] =
        prefs.getInt('five') == null ? 0 : prefs.getInt('five');
    this._bills[Bill.ten.index] =
        prefs.getInt('ten') == null ? 0 : prefs.getInt('ten');
    this._bills[Bill.fifty.index] =
        prefs.getInt('fifty') == null ? 0 : prefs.getInt('fifty');
    this._bills[Bill.oneHundred.index] =
        prefs.getInt('oneHundred') == null ? 0 : prefs.getInt('oneHundred');
    this._bills[Bill.fiveHundreds.index] =
        prefs.getInt('fiveHundreds') == null ? 0 : prefs.getInt('fiveHundreds');
    this._bills[Bill.oneThousand.index] =
        prefs.getInt('oneThousand') == null ? 0 : prefs.getInt('oneThousand');
    this._bills[Bill.fiveThousands.index] =
        prefs.getInt('fiveThousands') == null
            ? 0
            : prefs.getInt('fiveThousands');
    this._bills[Bill.tenThousands.index] =
        prefs.getInt('tenThousands') == null ? 0 : prefs.getInt('tenThousands');
  }

  List<List<int>> allSubsetsCanBePaid() {
    List<int> candidates = [];
    List<int> candidatesIndex = [];
    final List<int> values = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000];
    int index = 0;
    Bill.values.forEach((b) {
      for (var i = 0; i < this.numberOfBills(b); i++) {
        candidates.add(values[b.index]);
        candidatesIndex.add(index);
        index++;
      }
    });
    List<List<int>> subs = [];
    Subsets(candidatesIndex)().where((s) {
      int sum = 0;
      s.forEach((b) {
        sum += candidates[b];
      });
      return this._billing <= sum;
    }).forEach((s) {
      List<int> pays = [0, 0, 0, 0, 0, 0, 0, 0, 0];
      s.forEach((b) {
        pays[values.indexOf(candidates[b])]++;
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

  List<int> _cheatMinimumPay() {
    int remain = this._billing;
    List<int> answerArray = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    final column = [1, 10, 100, 100];
    for (var i = 0; i < 4; i++) {
      int targetNum = (remain % (10 * column[i]) / column[i]).ceil();
      if (targetNum == 10) {
        targetNum = 0;
      }
      if (targetNum % 5 <= this._bills[2 * i]) {
        answerArray[2 * i] = targetNum % 5;
      }
      int targetRemain = targetNum - answerArray[2 * i];
      if (targetRemain <= 5 * this._bills[2 * i + 1] && targetRemain != 0) {
        answerArray[2 * i + 1] = 1;
      }
      remain = remain -
          column[i] * answerArray[2 * i] -
          column[i] * 5 * answerArray[2 * i + 1];
    }
    answerArray[8] = (remain / 10000).ceil();
    return answerArray;
  }

  List<List<int>> minimumPays() {
    List<int> bestPay = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> bestChange = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    // exactly same as perfect
    List<int> perfectPay = this.changeToBills(this._billing);
    if (this._bills[Bill.one.index] >= perfectPay[Bill.one.index] &&
        this._bills[Bill.five.index] >= perfectPay[Bill.five.index] &&
        this._bills[Bill.ten.index] >= perfectPay[Bill.ten.index] &&
        this._bills[Bill.fifty.index] >= perfectPay[Bill.fifty.index] &&
        this._bills[Bill.oneHundred.index] >=
            perfectPay[Bill.oneHundred.index] &&
        this._bills[Bill.fiveHundreds.index] >=
            perfectPay[Bill.fiveHundreds.index] &&
        this._bills[Bill.oneThousand.index] >=
            perfectPay[Bill.oneThousand.index] &&
        this._bills[Bill.fiveThousands.index] >=
            perfectPay[Bill.fiveThousands.index] &&
        this._bills[Bill.tenThousands.index] >=
            perfectPay[Bill.tenThousands.index]) {
      return [perfectPay, bestChange];
    }
    final int currentBills = this.totalNumberOfBills();
    if (currentBills > 20) {
      // too many candidates
      bestPay = this._cheatMinimumPay();
      bestChange = this.changeToBills(this.sum(bills: bestPay) - this._billing);
    } else {
      // best pairs
      int minimumBills = -1;
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
    }
    // refiled
    Bill.values.forEach((b) {
      if (bestPay[b.index] - bestChange[b.index] >= 0) {
        bestPay[b.index] = bestPay[b.index] - bestChange[b.index];
        bestChange[b.index] = 0;
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

  void increment(Bill b, {int number = 1, doNotifyListeners: true}) {
    this._minimizeChangeData.increment(b, number: number);
    if (doNotifyListeners) {
      notifyListeners();
    }
  }

  void decrement(Bill b, {int number = 1, doNotifyListeners: true}) {
    this._minimizeChangeData.decrement(b, number: number);
    if (doNotifyListeners) {
      notifyListeners();
    }
  }

  int numberOfBills(Bill b) {
    return this._minimizeChangeData.numberOfBills(b);
  }

  int totalNumberOfBills({List<int> bills}) {
    return this._minimizeChangeData.totalNumberOfBills(bills: bills);
  }

  int sum({List<int> bills}) {
    return this._minimizeChangeData.sum(bills: bills);
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
  Future remove() async => await this._minimizeChangeData.remove();
  Future save() async => await this._minimizeChangeData.save();
  Future restore() async {
    await this._minimizeChangeData.restore();
    notifyListeners();
  }

  set billing(int _billing) => this._minimizeChangeData.billing = _billing;
  int get billing => this._minimizeChangeData.billing;
}
