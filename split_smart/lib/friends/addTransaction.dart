
import 'package:split_smart/friends/settleUpPage.dart';
import 'package:split_smart/friends/updateUser.dart';
import 'package:split_smart/home/home.dart';
import 'package:split_smart/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'friends_page.dart';
import 'package:split_smart/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'getFriendEmail.dart';


// to access current user email
final FirebaseAuth auth = FirebaseAuth.instance;
User user = FirebaseAuth.instance.currentUser;
getFriendEmail _getEmail = getFriendEmail();



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
  //String femail="shivu@gmail.com";
  String femail =  _getEmail.getEmail();
  List<String> _emails = [user.email,_getEmail.getEmail()];
  String _selectedEmail;


  updateUserAmount _update = updateUserAmount();
  bool flag;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  fontSize: 24.0,
                ),
              ),
            ),
          ),

             SizedBox(height: 30,),

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
                items: _emails.map((e) {
                  return DropdownMenuItem(
                    child: new Text(e),
                    value: e,
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
                          _update.updateAmount(user.email,femail, amt);
                        }
                      else
                        {
                          _update.updateAmount(femail,user.email, amt);
                        }

                      showDialog(
                        context: context,
                        builder: (_) => FunkyOverlay(),
                      );
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          //:: TODO send friend's email id here
                            builder: (context) => settleUp(email: femail)

                        ),
                      );*/

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

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                onPressed: () {
                  _navigateToNextScreen(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shadowColor: Colors.white,
                  elevation: 0,
                ),
                child: Text(
                  'Transaction Added!',
                    style: TextStyle(
                    color: Colors.black
                ),

                ),
              )
            ),
          ),
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
  }
}





