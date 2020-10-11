import 'package:flutter/material.dart';
import 'package:jpy_minimize_your_change/minimize_change_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MinimizeChangeModel>(
      create: (_) => MinimizeChangeModel(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('ステップ2:買った金額は？'),
          ),
          body: Consumer<MinimizeChangeModel>(builder: (context, model, child) {
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
                            new TextField(
                              decoration: new InputDecoration(labelText: "金額"),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"^\d+$")),
                              ],
                              onChanged: (String number) {
                                model.billing = int.parse(number);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  child: Text("もどる"),
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName("/"));
                                  },
                                ),
                                RaisedButton(
                                  child: Text("つぎへ"),
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    if (model.canPay() && model.billing > 0) {
                                      Navigator.of(context)
                                          .pushNamed('/result');
                                    }
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
