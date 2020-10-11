import 'package:flutter/material.dart';
import 'package:jpy_minimize_your_change/minimize_change_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Result extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MinimizeChangeModel>(
      create: (_) => MinimizeChangeModel(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('ステップ3:これではらってね'),
          ),
          body: Consumer<MinimizeChangeModel>(builder: (context, model, child) {
            final formatter = NumberFormat("#,###");
            List<List<int>> result = model.minimumPays();
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              visible: result[0][8] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                      child: Text("10,000円"),
                                      color: Colors.grey,
                                      textColor: Colors.white,
                                      onPressed: () {}),
                                  Text("${result[0][8]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][7] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                    child: Text("5,000円"),
                                    color: Colors.grey,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                  Text("${result[0][7]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][6] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                    child: Text("1,000円"),
                                    color: Colors.grey,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                  Text("${result[0][6]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][5] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonTheme(
                                    minWidth: 50.0,
                                    height: 50.0,
                                    child: RaisedButton(
                                      child: Text("500"),
                                      textColor: Colors.white,
                                      color: Colors.grey,
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text("${result[0][5]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][4] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonTheme(
                                    minWidth: 40.0,
                                    height: 40.0,
                                    child: RaisedButton(
                                      child: Text("100"),
                                      color: Colors.grey,
                                      textColor: Colors.white,
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text("${result[0][4]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][3] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonTheme(
                                    minWidth: 35.0,
                                    height: 35.0,
                                    child: RaisedButton(
                                      child: Text("50"),
                                      color: Colors.grey,
                                      textColor: Colors.white,
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text("${result[0][3]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][2] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonTheme(
                                    minWidth: 35.0,
                                    height: 35.0,
                                    child: RaisedButton(
                                      child: Text("10"),
                                      color: Colors.orange,
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text("${result[0][2]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][1] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonTheme(
                                    minWidth: 30.0,
                                    height: 30.0,
                                    child: RaisedButton(
                                      child: Text("5"),
                                      color: Colors.yellow,
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text("${result[0][1]} 枚"),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: result[0][0] != 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonTheme(
                                    minWidth: 30.0,
                                    height: 30.0,
                                    child: RaisedButton(
                                      child: Text("1"),
                                      color: Colors.white70,
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text("${result[0][0]} 枚"),
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "おつり${formatter.format(model.sum(bills: result[1]))} 円",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  child: Text("もどる"),
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName("/input"));
                                  },
                                ),
                                RaisedButton(
                                  child: Text("支払う！"),
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    model.decrement(Bill.one,
                                        number: result[0][0]);
                                    model.decrement(Bill.five,
                                        number: result[0][1]);
                                    model.decrement(Bill.ten,
                                        number: result[0][2]);
                                    model.decrement(Bill.fifty,
                                        number: result[0][3]);
                                    model.decrement(Bill.oneHundred,
                                        number: result[0][4]);
                                    model.decrement(Bill.fiveHundreds,
                                        number: result[0][5]);
                                    model.decrement(Bill.oneThousand,
                                        number: result[0][6]);
                                    model.decrement(Bill.fiveThousands,
                                        number: result[0][7]);
                                    model.decrement(Bill.tenThousands,
                                        number: result[0][8]);

                                    model.increment(Bill.one,
                                        number: result[1][0]);
                                    model.increment(Bill.five,
                                        number: result[1][1]);
                                    model.increment(Bill.ten,
                                        number: result[1][2]);
                                    model.increment(Bill.fifty,
                                        number: result[1][3]);
                                    model.increment(Bill.oneHundred,
                                        number: result[1][4]);
                                    model.increment(Bill.fiveHundreds,
                                        number: result[1][5]);
                                    model.increment(Bill.oneThousand,
                                        number: result[1][6]);
                                    model.increment(Bill.fiveThousands,
                                        number: result[1][7]);
                                    model.increment(Bill.tenThousands,
                                        number: result[1][8]);
                                    model.billing = 0;
                                    model.save();
                                    Navigator.of(context)
                                        .popUntil(ModalRoute.withName('/'));
                                  },
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
