import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:split_smart/services/auth.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Align(
                //alignment: Alignment.topCenter,
                child: Text('Profile',
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/login.jpg"),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,

                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 30,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                    onPressed: () {},
                   // padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                ),

                FlatButton(
                  onPressed: () {},
                  // padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                FlatButton(
                  onPressed: () {},
                  // padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                FlatButton(
                  onPressed: () {
                    _auth.signOut();
                  },
                  // padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: HexColor("#e16428"),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),


    );
  }
}
