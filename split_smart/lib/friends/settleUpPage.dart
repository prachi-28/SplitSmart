import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class settleUp extends StatefulWidget {

  String email; // friend's email
  settleUp({this.email});

  @override
  _settleUpState createState() => _settleUpState();
}

class _settleUpState extends State<settleUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Row(

        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                '${widget.email}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),

          Center(
            child: ElevatedButton(

              child: Text(
                'Settle Up',
                style: TextStyle(
                    color: Colors.white
                ),
              ),

              //:: TODO function for settle up
              onPressed: () async {

              },


            ),
          ),


        ],
      ),

    );
  }
}
