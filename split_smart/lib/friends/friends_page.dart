import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  int _owe =0;
  int _owed = 0;
  double _percent = 0.8;

  @override
  Widget build(BuildContext context) {
    return Center(
      //color: Colors.red,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                /*Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 30,
                    animation: true,
                    lineHeight: 50.0,
                    animationDuration: 2500,
                    percent: _percent,
                    //center: Text("80.0%"),
                    linearStrokeCap: LinearStrokeCap.butt,
                    backgroundColor: Colors.red,
                    progressColor: Colors.green,
                  ),
                ),*/
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    width: (MediaQuery.of(context).size.width -60) * _percent,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(_owed.toString()),
                    )
                    ),
                  Container(
                    height: 75,
                    width: 10,
                  ),
                  Container(
                    height: 75,
                    width:  (MediaQuery.of(context).size.width -60)* (1-_percent),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(_owe.toString()),
                    ),
                  ),
                ],
              )
            )
              ],
      ),
    );
  }

  void onTransactionUpdate(int owe, int owed) {
    setState(() {
      _owe = owe;
      _owed = owed;
      _percent = owe/(owe+owed);
    });
  }
}
