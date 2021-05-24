import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/friends/read_users.dart';
import 'package:split_smart/groups/read_groups.dart';
import 'package:split_smart/groups/make_group.dart';
import 'package:split_smart/groups/groupDivisionBar.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {

  ReadGroupsClass _read = ReadGroupsClass();
  //ReadUsersClass _read = ReadUsersClass();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        //color: Colors.red,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /*Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Opacity(
                  opacity: 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
              ),*/
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: 75,
                  child: DivisionBarClass(),
                )
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child:
                    Container(
                        child: _read.readGroups(),
                        height: 450,
                        width: 500,
                    ),
              ),
            ]),
      ),
    );
  }
}
