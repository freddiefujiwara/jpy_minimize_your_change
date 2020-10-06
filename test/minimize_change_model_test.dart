import 'package:flutter_test/flutter_test.dart';
import 'package:jpy_minimize_your_change/minimize_change_model.dart';

void main() {
  MinimizeChangeModel c;
  setUp(() {
    c = MinimizeChangeModel();
  });
  group('MinimizeChange', () {
    test("increment/number", () {
      c.increment(Bill.tenThousands, 1);
      expect(c.sum(), 10000);
      c.increment(Bill.fiveThousands, 1);
      expect(c.sum(), 15000);
      c.increment(Bill.oneThousand, 1);
      expect(c.sum(), 16000);
      c.increment(Bill.fiveHundreds, 1);
      expect(c.sum(), 16500);
      c.increment(Bill.oneHundred, 1);
      expect(c.sum(), 16600);
      c.increment(Bill.fifty, 1);
      expect(c.sum(), 16650);
      c.increment(Bill.ten, 1);
      expect(c.sum(), 16660);
      c.increment(Bill.five, 1);
      expect(c.sum(), 16665);
      c.increment(Bill.one, 1);
      expect(c.sum(), 16666);
      expect(c.numberOfBills(Bill.tenThousands), 1);
      expect(c.numberOfBills(Bill.fiveThousands), 1);
      expect(c.numberOfBills(Bill.oneThousand), 1);
      expect(c.numberOfBills(Bill.fiveHundreds), 1);
      expect(c.numberOfBills(Bill.oneHundred), 1);
      expect(c.numberOfBills(Bill.fifty), 1);
      expect(c.numberOfBills(Bill.ten), 1);
      expect(c.numberOfBills(Bill.five), 1);
      expect(c.numberOfBills(Bill.one), 1);
    });
    test("clear", () {
      c.increment(Bill.tenThousands, 1);
      c.increment(Bill.fiveThousands, 1);
      c.increment(Bill.oneThousand, 1);
      c.increment(Bill.fiveHundreds, 1);
      c.increment(Bill.oneHundred, 1);
      c.increment(Bill.fifty, 1);
      c.increment(Bill.ten, 1);
      c.increment(Bill.five, 1);
      c.increment(Bill.one, 1);
      expect(c.sum(), 16666);
      c.clear();
      expect(c.sum(), 0);
    });
    test("billing", () {
      c.billing = 16666;
      expect(c.billing, 16666);
    });

    test("canPay", () {
      c.billing = 16666;
      c.increment(Bill.tenThousands, 1);
      c.increment(Bill.fiveThousands, 1);
      c.increment(Bill.oneThousand, 1);
      c.increment(Bill.fiveHundreds, 1);
      c.increment(Bill.oneHundred, 1);
      c.increment(Bill.fifty, 1);
      c.increment(Bill.ten, 1);
      c.increment(Bill.five, 1);
      expect(c.canPay(), false);
      c.increment(Bill.one, 1);
      expect(c.canPay(), true);
      c.increment(Bill.one, 1);
      expect(c.canPay(), true);
    });

    test("allSubsetsCanBePaid", () {
      c.billing = 22665;
      c.increment(Bill.tenThousands, 1);
      c.increment(Bill.fiveThousands, 2);
      c.increment(Bill.oneThousand, 1);
      c.increment(Bill.fiveHundreds, 3);
      c.increment(Bill.oneHundred, 1);
      c.increment(Bill.fifty, 1);
      c.increment(Bill.ten, 1);
      c.increment(Bill.five, 1);
      c.increment(Bill.one, 1);
      final candidates = c.allSubsetsCanBePaid();
      expect(candidates.length, 2);
      expect(candidates, [
        [0, 1, 1, 1, 1, 3, 1, 2, 1],
        [1, 1, 1, 1, 1, 3, 1, 2, 1]
      ]);
    });
    test("changeToBills", () {
      List<int> bills = c.changeToBills(10);
      expect(bills, [0, 0, 1, 0, 0, 0, 0, 0, 0]);
      bills = c.changeToBills(11);
      expect(bills, [1, 0, 1, 0, 0, 0, 0, 0, 0]);
      bills = c.changeToBills(16);
      expect(bills, [1, 1, 1, 0, 0, 0, 0, 0, 0]);
      bills = c.changeToBills(4016);
      expect(bills, [1, 1, 1, 0, 0, 0, 4, 0, 0]);
      bills = c.changeToBills(5016);
      expect(bills, [1, 1, 1, 0, 0, 0, 0, 1, 0]);
    });
    test("minimize", () {
      c.billing = 22665;
      c.increment(Bill.tenThousands, 1);
      c.increment(Bill.fiveThousands, 2);
      c.increment(Bill.oneThousand, 1);
      c.increment(Bill.fiveHundreds, 3);
      c.increment(Bill.oneHundred, 1);
      c.increment(Bill.fifty, 1);
      c.increment(Bill.ten, 1);
      c.increment(Bill.five, 1);
      c.increment(Bill.one, 1);

      List<List<int>> minimums = c.minimumPays();
      expect(minimums.length, 2);
      expect(minimums[0].length, 9);
      expect(minimums[1].length, 9);
      expect(minimums, [
        [0, 1, 1, 1, 1, 3, 1, 2, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
      ]);
      c.clear();

      c.billing = 756;
      c.increment(Bill.tenThousands, 1);
      c.increment(Bill.fiveThousands, 1);
      c.increment(Bill.oneThousand, 1);
      c.increment(Bill.fiveHundreds, 0);
      c.increment(Bill.oneHundred, 3);
      c.increment(Bill.fifty, 0);
      c.increment(Bill.ten, 1);
      c.increment(Bill.five, 0);
      c.increment(Bill.one, 1);

      minimums = c.minimumPays();
      expect(minimums.length, 2);
      expect(minimums[0].length, 9);
      expect(minimums[1].length, 9);
      expect(minimums, [
        [1, 0, 1, 0, 3, 0, 1, 0, 0],
        [0, 1, 0, 1, 0, 1, 0, 0, 0]
      ]);
    });
  });
}
