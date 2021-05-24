import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/services/creategroup.dart';
import 'package:split_smart/home/home.dart';
import 'package:split_smart/friends/read_users.dart';
import 'package:split_smart/groups/GroupData.dart';
import 'package:split_smart/groups/read_groups.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:split_smart/groups/groups_page.dart';
import 'package:split_smart/groups/choose_friends.dart';

class MakeGroup extends StatefulWidget {
  @override
  _MakeGroupState createState() => _MakeGroupState();
}

class _MakeGroupState extends State<MakeGroup> {

  GroupData _groupData = new GroupData();
  String _groupName;
  CreateGroupService _createGroup = new CreateGroupService();

  final resetText = TextEditingController();
  void clearText() {
    resetText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Make Group'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
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
                        borderSide: BorderSide(color: Colors.grey.shade100)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: HexColor("#ce5a6f"), width: 2.0),
                    )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                  //labelText: 'Group Name',
                  hintText: 'Enter Group Name',
                ),
                onChanged: (text) {
                  _groupName = text;
                },
                controller: resetText,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 500,
                width: 500,
                //color: Colors.blue,
                //child: Flexible(
                  child: ChooseFriendsClass(),
                //)

              )
              //child: ReadGroupsClass(),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  //color: Colors.blueGrey,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_groupName == null) {
                      Fluttertoast.showToast(
                          msg: "Enter Group Name",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black12,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else {
                      print(_groupData.returnEmail());
                      _createGroup.allMemberInfo(_groupName, _groupData.returnEmail());
                      Fluttertoast.showToast(
                          msg: "Group Created",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black12,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      clearText();
                      _groupName = "";
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
