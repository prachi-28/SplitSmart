import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_smart/models/user.dart';
import 'package:split_smart/services/auth.dart';
//import 'package:split_smart/services/auth.dart;
import 'package:split_smart/groups/make_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/groupDivBarValues.dart';
import 'package:split_smart/groups/GroupData.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User user = FirebaseAuth.instance.currentUser;
GroupData _groupData = new GroupData();

class AddGroupTransactionClass extends StatefulWidget {
  @override
  _AddGroupTransactionClassState createState() => _AddGroupTransactionClassState();
}

class _AddGroupTransactionClassState extends State<AddGroupTransactionClass> {

  String docID = user.email; //currentUser's document ID
  String gName = _groupData.returnGroupName();

  List<String> tempEmails = new List<String>();
  String _paidBy = "";
  //final _amountPaid = TextEditingController();
  //final List<TextEditingController> _amountIndividual = List();
  final _amountIndividual = TextEditingController();
  int _radioValue = -1;
  bool flag = true;
  double _amountPaid;

  List<double> _amountPerson = new List<double>();

  void initState() {
    setState(() {
      for (int i=0 ; i<_groupData.returnEmail().length ; i++) {
        _amountPerson.add(0.0);
      }
    });
  }

  void setAmount(int i, double text){
    _amountPerson[i] = text;
  }

  void _handleRadioValueChange(int value) {
    setState(() {

      if (_amountPaid == null) {
        Fluttertoast.showToast(
            msg: "Add Amount Paid",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black12,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          print("EQUAL");
          setState(() {
            for (int i=0 ; i<_groupData.returnEmail().length ; i++) {
              _amountPerson[i] = _amountPaid/_groupData.returnEmail().length;
            }
          });
          break;
        case 1:
          print("CUSTOM");
          setState(() {
            for (int i=0 ; i<_groupData.returnEmail().length ; i++) {
              _amountPerson[i] = 0.00;
            }
          });
          break;
      }
    });
  }

  //TODO: currently assuming that current user is paying
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*appBar: AppBar(
        title: Text("Add Transaction"),
      ),*/

      body:
      Container(
        padding: EdgeInsets.only(top:30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
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
                  gName,
                  style: TextStyle(
                    //color: Colors.black,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            /*Align(
              alignment: Alignment.center,
              child: DropdownButton(
                hint: Text('Paid by'),
                value: _paidBy,
                onChanged: (newValue) {
                  setState(() {
                    _paidBy = newValue;
                  });
                },
                items: _groupData.returnEmail().map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
            ),*/
            Column(
              children: [
                Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 0,
                        groupValue: _radioValue,
                        //TODO: better colour
                        activeColor: Colors.red,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Split Equally',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      new Radio(
                        value: 1,
                        groupValue: _radioValue,
                        activeColor: Colors.red,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Custom Split',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextField(
                      //controller: _amountPaid,
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
                      onChanged: (value) {
                        setState(() {
                          _amountPaid = double.parse(value);
                          print(_amountPaid);
                          if (_radioValue == 0) {
                            for (int i=0 ; i<_groupData.returnEmail().length ; i++) {
                              _amountPerson[i] = _amountPaid/_groupData.returnEmail().length;
                            }
                          }
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                  height: 500,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: _groupData.returnEmail().length,
                      itemBuilder: (BuildContext context, int index) {
                        //_amountIndividual.add(new TextEditingController());
                        return Container(
                          height: 60.0,
                          //color: Colors.grey.withOpacity(0.2),
                          decoration: BoxDecoration(
                                border: Border.all(
                                color: Colors.grey.withOpacity(0.2)
                              ),
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 240,
                                  child: Text(
                                    '${_groupData.returnEmail()[index]}',
                                    style: TextStyle(
                                     fontSize: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  alignment: Alignment.centerRight,
                                  //color: Colors.blue,
                                  child: TextField(
                                    //controller: _amountIndividual,
                                    textAlign: TextAlign.center,
                                    //textAlignVertical: TextAlignVertical.center,
                                    decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.all(2.0),
                                      hintText: '${_amountPerson[index]}',
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      setAmount(index, double.parse(text));
                                      print(text);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                      print(_amountPaid);
                      double Sum=0;
                      for (int i=0 ; i<_groupData.returnEmail().length ; i++) {
                        Sum = Sum + _amountPerson[i];
                      }
                      setState(() {
                        if (Sum != _amountPaid) {
                          flag = false;
                          Fluttertoast.showToast(
                              msg: "Amounts Do Not Add Up",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black12,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        else {
                          flag = true;
                        }
                        print(flag);
                      });

                      //print(desc.text);
                      //print(amount.text);
                      //:: TODO a function to update owes and owed -> updateUser.dart
                      /*amt=double.parse(amount.text);
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
                      );*/



                      //print(widget.email);
                      //print(_selectedEmail);
                    },
                  ),
                ),


              ],
            ),

          ],
        ),
      ),
    );
  }
}
