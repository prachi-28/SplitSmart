// page shown after log in
import 'package:flutter/material.dart';
import 'package:split_smart/services/auth.dart';
import 'package:split_smart/friends/friends_page.dart';
import 'package:split_smart/groups/groups_page.dart';

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
  final List<Widget> _children = [Friends(), Groups(), ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text('Welcome'),
        actions: [
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('Logout'),
          ),
        ],
      ),
      body: _children[_currentIndex],
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
    });
  }

}
