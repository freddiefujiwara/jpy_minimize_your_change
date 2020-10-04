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
      expect(c.number(Bill.tenThousands), 1);
      expect(c.number(Bill.fiveThousands), 1);
      expect(c.number(Bill.oneThousand), 1);
      expect(c.number(Bill.fiveHundreds), 1);
      expect(c.number(Bill.oneHundred), 1);
      expect(c.number(Bill.fifty), 1);
      expect(c.number(Bill.ten), 1);
      expect(c.number(Bill.five), 1);
      expect(c.number(Bill.one), 1);
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
  });
}
