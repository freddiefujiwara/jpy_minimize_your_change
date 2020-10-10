import 'package:flutter_test/flutter_test.dart';
import 'package:jpy_minimize_your_change/minimize_change_model.dart';

void main() {
  MinimizeChangeModel m;
  setUp(() {
    m = MinimizeChangeModel();
    m.clear();
  });
  group('MinimizeChange', () {
    test("increment/number", () {
      m.increment(Bill.tenThousands, number: 1);
      expect(m.sum(), 10000);
      m.increment(Bill.fiveThousands, number: 1);
      expect(m.sum(), 15000);
      m.increment(Bill.oneThousand, number: 1);
      expect(m.sum(), 16000);
      m.increment(Bill.fiveHundreds, number: 1);
      expect(m.sum(), 16500);
      m.increment(Bill.oneHundred, number: 1);
      expect(m.sum(), 16600);
      m.increment(Bill.fifty, number: 1);
      expect(m.sum(), 16650);
      m.increment(Bill.ten, number: 1);
      expect(m.sum(), 16660);
      m.increment(Bill.five, number: 1);
      expect(m.sum(), 16665);
      m.increment(Bill.one, number: 1);
      expect(m.sum(), 16666);
      expect(m.numberOfBills(Bill.tenThousands), 1);
      expect(m.numberOfBills(Bill.fiveThousands), 1);
      expect(m.numberOfBills(Bill.oneThousand), 1);
      expect(m.numberOfBills(Bill.fiveHundreds), 1);
      expect(m.numberOfBills(Bill.oneHundred), 1);
      expect(m.numberOfBills(Bill.fifty), 1);
      expect(m.numberOfBills(Bill.ten), 1);
      expect(m.numberOfBills(Bill.five), 1);
      expect(m.numberOfBills(Bill.one), 1);
    });
    test("clear", () {
      m.increment(Bill.tenThousands, number: 1);
      m.increment(Bill.fiveThousands, number: 1);
      m.increment(Bill.oneThousand, number: 1);
      m.increment(Bill.fiveHundreds, number: 1);
      m.increment(Bill.oneHundred, number: 1);
      m.increment(Bill.fifty, number: 1);
      m.increment(Bill.ten, number: 1);
      m.increment(Bill.five, number: 1);
      m.increment(Bill.one, number: 1);
      expect(m.sum(), 16666);
      m.clear();
      expect(m.sum(), 0);
    });
    test("billing", () {
      m.billing = 16666;
      expect(m.billing, 16666);
    });

    test("canPay", () {
      m.billing = 16666;
      m.increment(Bill.tenThousands, number: 1);
      m.increment(Bill.fiveThousands, number: 1);
      m.increment(Bill.oneThousand, number: 1);
      m.increment(Bill.fiveHundreds, number: 1);
      m.increment(Bill.oneHundred, number: 1);
      m.increment(Bill.fifty, number: 1);
      m.increment(Bill.ten, number: 1);
      m.increment(Bill.five, number: 1);
      expect(m.canPay(), false);
      m.increment(Bill.one);
      expect(m.canPay(), true);
      m.increment(Bill.one);
      expect(m.canPay(), true);
    });

    test("allSubsetsCanBePaid", () {
      m.billing = 22665;
      m.increment(Bill.tenThousands, number: 1);
      m.increment(Bill.fiveThousands, number: 3);
      m.decrement(Bill.fiveThousands);
      m.increment(Bill.oneThousand, number: 1);
      m.increment(Bill.fiveHundreds, number: 3);
      m.increment(Bill.oneHundred, number: 1);
      m.increment(Bill.fifty, number: 1);
      m.increment(Bill.ten, number: 1);
      m.increment(Bill.five, number: 1);
      m.increment(Bill.one, number: 1);
      final candidates = m.allSubsetsCanBePaid();
      expect(candidates.length, 2);
      expect(candidates, [
        [0, 1, 1, 1, 1, 3, 1, 2, 1],
        [1, 1, 1, 1, 1, 3, 1, 2, 1]
      ]);
    });
    test("changeToBills", () {
      List<int> bills = m.changeToBills(10);
      expect(bills, [0, 0, 1, 0, 0, 0, 0, 0, 0]);
      bills = m.changeToBills(11);
      expect(bills, [1, 0, 1, 0, 0, 0, 0, 0, 0]);
      bills = m.changeToBills(16);
      expect(bills, [1, 1, 1, 0, 0, 0, 0, 0, 0]);
      bills = m.changeToBills(4016);
      expect(bills, [1, 1, 1, 0, 0, 0, 4, 0, 0]);
      bills = m.changeToBills(5016);
      expect(bills, [1, 1, 1, 0, 0, 0, 0, 1, 0]);
    });
    test("minimize", () {
      m.billing = 22665;
      m.increment(Bill.tenThousands, number: 1);
      m.increment(Bill.fiveThousands, number: 2);
      m.increment(Bill.oneThousand, number: 1);
      m.increment(Bill.fiveHundreds, number: 3);
      m.increment(Bill.oneHundred, number: 1);
      m.increment(Bill.fifty, number: 1);
      m.increment(Bill.ten, number: 1);
      m.increment(Bill.five, number: 1);
      m.increment(Bill.one, number: 1);

      List<List<int>> minimums = m.minimumPays();
      expect(minimums.length, 2);
      expect(minimums[0].length, 9);
      expect(minimums[1].length, 9);
      expect(minimums, [
        [0, 1, 1, 1, 1, 3, 1, 2, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
      ]);
      m.clear();

      m.billing = 756;
      m.increment(Bill.tenThousands);
      m.increment(Bill.fiveThousands, number: 1);
      m.increment(Bill.oneThousand, number: 1);
      m.decrement(Bill.fiveHundreds, number: 50);
      m.increment(Bill.oneHundred, number: 3);
      m.increment(Bill.fifty, number: 0);
      m.increment(Bill.ten, number: 1);
      m.increment(Bill.five, number: 0);
      m.increment(Bill.one, number: 1);

      minimums = m.minimumPays();
      expect(minimums.length, 2);
      expect(minimums[0].length, 9);
      expect(minimums[1].length, 9);
      expect(minimums, [
        [1, 0, 1, 0, 3, 0, 1, 0, 0],
        [0, 1, 0, 1, 0, 1, 0, 0, 0]
      ]);

      m.clear();
      m.billing = 900;
      m.increment(Bill.tenThousands, number: 1);

      minimums = m.minimumPays();
      expect(minimums.length, 2);
      expect(minimums[0].length, 9);
      expect(minimums[1].length, 9);
      expect(minimums, [
        [0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 0, 4, 1, 0]
      ]);
    });
  });
}
