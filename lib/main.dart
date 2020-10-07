import 'package:flutter/material.dart';
import 'package:jpy_minimize_your_change/minimize_change_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Japanese bills and coins calculator',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<MinimizeChangeModel>(
          create: (_) => MinimizeChangeModel(),
          child: Scaffold(
              appBar: AppBar(
                title: Text('Japanese bills and coins calculator'),
              ),
              body: Consumer<MinimizeChangeModel>(builder: (context, model, child) {
                final formatter = NumberFormat("#,###");
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
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "合計${formatter.format(model.sum())} 円",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("クリア"),
                                      color: Colors.white,
                                      textColor: Colors.black,
                                      onPressed: () {
                                        model.clear();
                                      },
                                    ),
                                  ]),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                    child: Text("10,000円"),
                                    color: Colors.grey,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      model.increment(Bill.tenThousands);
                                    },
                                  ),
                                  Text("${model.numberOfBills(Bill.tenThousands)} 枚"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                    child: Text("5,000円"),
                                    color: Colors.grey,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      model.increment(Bill.fiveThousands);
                                    },
                                  ),
                                  Text("${model.numberOfBills(Bill.fiveThousands)} 枚"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                    child: Text("1,000円"),
                                    color: Colors.grey,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      model.increment(Bill.oneThousand);
                                    },
                                  ),
                                  Text("${model.numberOfBills(Bill.oneThousand)} 枚"),
                                ],
                              ),
                              Row(
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
                                      onPressed: () {
                                        model.increment(Bill.fiveHundreds);
                                      },
                                    ),
                                  ),
                                  Text("${model.numberOfBills(Bill.fiveHundreds)} 枚"),
                                ],
                              ),
                              Row(
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
                                      onPressed: () {
                                        model.increment(Bill.oneHundred);
                                      },
                                    ),
                                  ),
                                  Text("${model.numberOfBills(Bill.oneHundred)} 枚"),
                                ],
                              ),
                              Row(
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
                                      onPressed: () {
                                        model.increment(Bill.fifty);
                                      },
                                    ),
                                  ),
                                  Text("${model.numberOfBills(Bill.fifty)} 枚"),
                                ],
                              ),
                              Row(
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
                                      onPressed: () {
                                        model.increment(Bill.ten);
                                      },
                                    ),
                                  ),
                                  Text("${model.numberOfBills(Bill.ten)} 枚"),
                                ],
                              ),
                              Row(
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
                                      onPressed: () {
                                        model.increment(Bill.five);
                                      },
                                    ),
                                  ),
                                  Text("${model.numberOfBills(Bill.five)} 枚"),
                                ],
                              ),
                              Row(
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
                                      onPressed: () {
                                        model.increment(Bill.one);
                                      },
                                    ),
                                  ),
                                  Text("${model.numberOfBills(Bill.one)} 枚"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ));
  }
}