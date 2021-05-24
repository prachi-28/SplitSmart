
import 'package:split_smart/friends/settleUpPage.dart';
import 'package:split_smart/friends/updateUser.dart';
import 'package:split_smart/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'friends_page.dart';
import 'package:split_smart/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


// to access current user email
final FirebaseAuth auth = FirebaseAuth.instance;
User user = FirebaseAuth.instance.currentUser;


class addTransactionFriend extends StatefulWidget {
  String email; // friend's email
  addTransactionFriend({this.email});

  @override
  _addTransactionFriendState createState() => _addTransactionFriendState();
}

class _addTransactionFriendState extends State<addTransactionFriend> {



  final desc = TextEditingController();
  final amount = TextEditingController();
  double amt;

  //:: TODO include friend's email in the list _emails
  String test="shivu@gmail.com";
  List<String> _emails = [user.email,"shivu@gmail.com"];
  String _selectedEmail;


  updateUserAmount _update = updateUserAmount();
  bool flag;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
      ),

      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Center(
                child: Text(
                    'Splitting with',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                    ),
                  ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Center(
              child: Text(
                '${widget.email}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
            ),
          ),

             SizedBox(height: 20,),

             Align(
               alignment: Alignment.center,
               child: DropdownButton(
                hint: Text('Paid by'),
                value: _selectedEmail,
                onChanged: (newValue) {
                  setState(() {
                    _selectedEmail = newValue;
                  });
                },
                items: _emails.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
            ),
             ),




          Column(
            children: [
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    controller: desc,
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.assignment_sharp),
                      labelText: "Enter Description",
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),



              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    controller: amount,
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.attach_money),
                      labelText: "Enter Amount",
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),

              Center(
                child: ElevatedButton(

                     child: Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {

                      //print(desc.text);
                      //print(amount.text);
                      //:: TODO a function to update owes and owed -> updateUser.dart
                      amt=double.parse(amount.text);
                      if(_selectedEmail==user.email)
                        {
                          flag=true;
                        }
                      else
                        {
                          flag=false;
                        }

                      if(flag)
                        {
                          _update.updateAmount(user.email,test, amt);
                        }
                      else
                        {
                          _update.updateAmount(test,user.email, amt);
                        }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //:: TODO send friend's email id here
                            builder: (context) => settleUp(email: test)
                        ),
                      );



                      //print(widget.email);
                      //print(_selectedEmail);
                    },

                  ),
              ),


            ],
          ),

        ],
      ),
    );
  }
}



