import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
//import 'package:split_smart/services/auth.dart;
import 'package:split_smart/groups/GroupData.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChooseFriendsClass extends StatefulWidget {

  @override
  _ChooseFriendsClassState createState() => _ChooseFriendsClassState();
}

class _ChooseFriendsClassState extends State<ChooseFriendsClass> {

  GroupData _groupData = new GroupData();

  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  List<String> tempEmail = new List<String>();
  List<bool> tempInputs = new List<bool>();

  void initState() {
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < _groupData.returnNum(); i++) {
        //_groupData.initInputs(i);
        tempInputs.add(false);
      }
      _groupData.setInputs(tempInputs);
    });
  }

  void ItemChange(bool val, int index) {
    setState(() {
      tempInputs[index] = val;
      _groupData.setInputs(tempInputs);
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: readFriends(),
    );
  }

  StreamBuilder readFriends() {

    String docID = user.email;

    Stream<QuerySnapshot> _friendsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(docID)
        .collection('friends')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _friendsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (!snapshot.hasData) {
          return Container(
            child: Text("No Friends"),
          );
        }

        _groupData.setNum(snapshot.data.docs.length);
        tempEmail.clear();
        for (int i=0 ; i<_groupData.returnNum() ; i++) {
          tempEmail.insert(i, snapshot.data.docs[i].data()['femail']);
        }//add current user to list of group emails
        _groupData.setEmail(tempEmail);
        print(_groupData.returnEmail());

        return Container(
          //color: Colors.blue,
          child: Scrollbar(
            child: ListView.builder(
              //padding: EdgeInsets.all(5.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) => buildItem(index, context, snapshot.data.docs[index], snapshot.data.docs.length),
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(int index, BuildContext context, QueryDocumentSnapshot doc, int num) {
    if (num == 0) {
      return Container();
    }
    else {
      print("HELLO");
      return Container(
        decoration: new BoxDecoration(
          border: new Border.all(width: 0, color: Colors.transparent),
          //color is transparent so that it does not blend with the actual color specified
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
          color: Colors.white70.withOpacity(
              0.2), // Specifies the background color and the opacity
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Checkbox(
                      value: _groupData.returnInputs()[index],
                      onChanged: (bool val) {
                        ItemChange(val, index);
                      }
                  )
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${doc.data()['fname']}',
                          style: TextStyle(color: Colors.black54,
                              fontSize: 17.0),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Email ID: ${doc.data()['femail']}',
                          style: TextStyle(color: Colors.black26,
                              fontSize: 12.0),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  //margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          //color: greyColor2,
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 25.0, 10.0),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}

