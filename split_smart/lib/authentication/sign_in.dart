import 'package:flutter/material.dart';
import 'package:split_smart/services/auth.dart';
import 'package:split_smart/models/user.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        //backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text('Sign in to SplitSmart'),

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(

            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 110,
                    child: Image.asset('images/login.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    //hintText: 'Enter a valid email id',
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email': null,
                  onChanged: (val) {
                    setState(() {
                      email=val;
                    });

                  },
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),

                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    //hintText: 'Enter a valid email id',
                  ),
                  validator: (val) => val.length<6 ? 'Enter more than 6 chars': null,
                  obscureText: true,
                  onChanged: (val) {

                    setState(() {
                      password=val;
                    });
                  },
                ),
              ),

              //SizedBox(height: 8,),
              SizedBox(
                width: 300,
                child: ElevatedButton(


                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          error="Could not sign in with those credentials";
                        });
                      }
                    }
                  },


                ),
              ),

              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),


                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                        color: Colors.pink,
                    ),
                  ),
                  onPressed: () async {

                      dynamic result = await _auth.signInWithGoogle();
                      if(result==null){
                        setState(() {
                          error="Could not sign in with those credentials";
                        });
                      }


                  },


                ),
              ),



              SizedBox(height: 5,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 30,),
              ElevatedButton(

                  onPressed: () {
                    widget.toggleView();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                  child: Text(
                    'New User? Sign Up!',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
