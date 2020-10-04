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

    test("minimize", () {
      //one
      c.billing = 14;
      c.increment(Bill.one, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.one), 3);
      expect(c.numberOfPays(Bill.one), 0);
      c.clear();

      c.billing = 14;
      c.increment(Bill.one, 4);
      c.minimize();
      expect(c.numberOfBills(Bill.one), 0);
      expect(c.numberOfPays(Bill.one), 4);
      c.clear();

      c.billing = 14;
      c.increment(Bill.one, 3);
      c.increment(Bill.five, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.one), 3);
      expect(c.numberOfPays(Bill.one), 0);
      expect(c.numberOfBills(Bill.five), 2);
      expect(c.numberOfPays(Bill.five), 1);
      c.clear();

      c.billing = 15;
      c.increment(Bill.one, 6);
      c.minimize();
      expect(c.numberOfBills(Bill.one), 1);
      expect(c.numberOfPays(Bill.one), 5);
      c.clear();

      c.billing = 16;
      c.increment(Bill.one, 1);
      c.minimize();
      expect(c.numberOfBills(Bill.one), 0);
      expect(c.numberOfPays(Bill.one), 1);
      c.clear();

      //ten
      c.billing = 140;
      c.increment(Bill.ten, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.ten), 3);
      expect(c.numberOfPays(Bill.ten), 0);
      c.clear();

      c.billing = 140;
      c.increment(Bill.ten, 4);
      c.minimize();
      expect(c.numberOfBills(Bill.ten), 0);
      expect(c.numberOfPays(Bill.ten), 4);
      c.clear();

      c.billing = 140;
      c.increment(Bill.ten, 3);
      c.increment(Bill.fifty, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.ten), 3);
      expect(c.numberOfPays(Bill.ten), 0);
      expect(c.numberOfBills(Bill.fifty), 2);
      expect(c.numberOfPays(Bill.fifty), 1);
      c.clear();

      c.billing = 150;
      c.increment(Bill.ten, 6);
      c.minimize();
      expect(c.numberOfBills(Bill.ten), 1);
      expect(c.numberOfPays(Bill.ten), 5);
      c.clear();

      c.billing = 160;
      c.increment(Bill.ten, 1);
      c.minimize();
      expect(c.numberOfBills(Bill.ten), 0);
      expect(c.numberOfPays(Bill.ten), 1);
      c.clear();

      //oneHundred
      c.billing = 1400;
      c.increment(Bill.oneHundred, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.oneHundred), 3);
      expect(c.numberOfPays(Bill.oneHundred), 0);
      c.clear();

      c.billing = 1400;
      c.increment(Bill.oneHundred, 4);
      c.minimize();
      expect(c.numberOfBills(Bill.oneHundred), 0);
      expect(c.numberOfPays(Bill.oneHundred), 4);
      c.clear();

      c.billing = 1400;
      c.increment(Bill.oneHundred, 3);
      c.increment(Bill.fiveHundreds, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.oneHundred), 3);
      expect(c.numberOfPays(Bill.oneHundred), 0);
      expect(c.numberOfBills(Bill.fiveHundreds), 2);
      expect(c.numberOfPays(Bill.fiveHundreds), 1);
      c.clear();

      c.billing = 1500;
      c.increment(Bill.oneHundred, 6);
      c.minimize();
      expect(c.numberOfBills(Bill.oneHundred), 1);
      expect(c.numberOfPays(Bill.oneHundred), 5);
      c.clear();

      c.billing = 1600;
      c.increment(Bill.oneHundred, 1);
      c.minimize();
      expect(c.numberOfBills(Bill.oneHundred), 0);
      expect(c.numberOfPays(Bill.oneHundred), 1);
      c.clear();


      //oneThousand
      c.billing = 14000;
      c.increment(Bill.oneThousand, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.oneThousand), 3);
      expect(c.numberOfPays(Bill.oneThousand), 0);
      c.clear();

      c.billing = 14000;
      c.increment(Bill.oneThousand, 4);
      c.minimize();
      expect(c.numberOfBills(Bill.oneThousand), 0);
      expect(c.numberOfPays(Bill.oneThousand), 4);
      c.clear();

      c.billing = 14000;
      c.increment(Bill.oneThousand, 3);
      c.increment(Bill.fiveThousands, 3);
      c.minimize();
      expect(c.numberOfBills(Bill.oneThousand), 3);
      expect(c.numberOfPays(Bill.oneThousand), 0);
      expect(c.numberOfBills(Bill.fiveThousands), 2);
      expect(c.numberOfPays(Bill.fiveThousands), 1);
      c.clear();

      c.billing = 15000;
      c.increment(Bill.oneThousand, 6);
      c.minimize();
      expect(c.numberOfBills(Bill.oneThousand), 1);
      expect(c.numberOfPays(Bill.oneThousand), 5);
      c.clear();

      c.billing = 16000;
      c.increment(Bill.oneThousand, 1);
      c.minimize();
      expect(c.numberOfBills(Bill.oneThousand), 0);
      expect(c.numberOfPays(Bill.oneThousand), 1);
      c.clear();
    });
  });
}
