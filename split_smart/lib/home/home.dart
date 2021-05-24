// page shown after log in
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:split_smart/services/auth.dart';
import 'package:split_smart/friends/friends_page.dart';
import 'package:split_smart/groups/groups_page.dart';
import 'package:split_smart/friends/add_friend.dart';

import 'package:split_smart/profile/userProfile.dart';

import 'package:split_smart/groups/make_group.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Home_Stateful();
  }
}

class Home_Stateful extends StatefulWidget {
  @override
  _Home_StatefulState createState() => _Home_StatefulState();
}

class _Home_StatefulState extends State<Home_Stateful> {

  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  bool shouldShow = true;
  final List<Widget> _children = [Friends(), Groups(), Profile()];
  final List<IconData> _floatingIcon = [Icons.person_add, Icons.group_add, Icons.logout];
  //final List<IconData> _floatingIcon = [Icons.person_add, Icons.group_add, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,

      /*appBar: AppBar(
        //;backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text('Welcome'),

      ),*/
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: _children[_currentIndex],
      ),
      floatingActionButton:
          Visibility(
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_currentIndex == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddFriends()),
                    );
                  }

                  else if(_currentIndex == 2) {
                    //_auth.signOut();
                  }
                  else if (_currentIndex ==1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MakeGroup()),
                    );

                  }
                });
                // Add your onPressed code here!
              },
              child: Icon(_floatingIcon[_currentIndex]),
            ),
            visible: shouldShow,
          ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Friends'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.group),
            title: new Text('Groups'),
            //for make group button --> group_add icon
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_rounded),
              title: Text('Profile')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index==2) {
        shouldShow = false;
      }
      else {
        shouldShow = true;
      }
    });
    print(shouldShow);
  }

}
