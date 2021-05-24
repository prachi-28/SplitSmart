import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/friends/read_users.dart';
import 'package:split_smart/groups/read_groups.dart';
import 'package:split_smart/groups/make_group.dart';
import '../models/groupDivBarValues.dart';

class DivisionBarClass extends StatefulWidget {
  @override
  _DivisionBarClassState createState() => _DivisionBarClassState();
}

class _DivisionBarClassState extends State<DivisionBarClass> {

  GroupDivBarValuesClass _valuesClass = new GroupDivBarValuesClass();
  /*double _percent=_valuesClass.getPercent();
  double _owed=_valuesClass.getOwed();
  double _owe=0;*/

  @override
  Widget build(BuildContext context) {
    if (_valuesClass.getOwed()==0 && _valuesClass.getOwes()==0 || _valuesClass.getPercent()==0.0) {
      return Container(
        padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20, bottom: 20.0),
        height: 75,
        width: (MediaQuery.of(context).size.width - 60),
        decoration: BoxDecoration(
          color: HexColor("#56B43C"), //green
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
            "No Pending Transactions!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
    }
    else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 75,
              width: (MediaQuery.of(context).size.width - 60) * _valuesClass.getPercent(),
              decoration: BoxDecoration(
                color: HexColor("#56B43C"), //green
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(_valuesClass.getOwed().toString()),
              )),
          Container(
            height: 75,
            width: 10,
          ),
          Container(
            height: 75,
            width: (MediaQuery.of(context).size.width - 60) *
                (1 - _valuesClass.getPercent()),
            decoration: BoxDecoration(
              color: HexColor("#B52B45"), //red
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(_valuesClass.getOwes().toString()),
            ),
          ),
        ],
      );
    }
  }
}
