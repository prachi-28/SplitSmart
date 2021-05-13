import 'package:flutter/material.dart';
import 'package:split_smart/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        title: Text('Sign up to SplitSmart'),
        actions: [
          FlatButton.icon(
            onPressed: () {

              widget.toggleView();

            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email': null,
                onChanged: (val) {
                  setState(() {
                    email=val;
                  });

                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val.length<6 ? 'Enter more than 6 chars': null,
                obscureText: true,
                onChanged: (val) {

                  setState(() {
                    password=val;
                  });


                },
              ),

              SizedBox(height: 20,),

              RaisedButton(
                color: Colors.blueGrey,
                child: Text('Register', style: TextStyle(color: Colors.white),),
                onPressed: () async {

                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth. registerWithEmailAndPassword(email,password);
                    if(result==null){
                      setState(() {
                        error="Please supply a valid email";
                      });
                    }

                  }

                },

              ),
              SizedBox(height: 7,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
