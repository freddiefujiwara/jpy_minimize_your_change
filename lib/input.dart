import 'package:flutter/material.dart';
import 'package:jpy_minimize_your_change/minimize_change_model.dart';
import 'package:provider/provider.dart';

class Input extends StatelessWidget {
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
              body: Consumer<MinimizeChangeModel>(
                  builder: (context, model, child) {
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
                                  RaisedButton(
                                    child: Text("次へ"),
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    onPressed: () {
                                      model.clear();
                                    },
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
