import 'package:flutter/material.dart';
import 'package:split_smart/services/auth.dart';
import 'package:split_smart/services/createuser.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final CreateUserService _newUser = CreateUserService();

  String username="";
  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        elevation: 0.0,
        title: Text('Sign up to SplitSmart'),

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
                    height: 150,
                    child: Image.asset('images/home.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    //hintText: 'Enter a valid email id',
                  ),
                  onChanged: (val) {
                    setState(() {
                      username=val;
                    });
                  },
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
              SizedBox(height: 20,),
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

              SizedBox(height: 20,),

              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                  //color: Colors.blueGrey,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                    ),
                  ),
                  onPressed: () async {

                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth. registerWithEmailAndPassword(email,password);
                      if(result==null){
                        setState(() {
                          error="Please supply a valid email";
                        });
                      }
                      else {
                        _newUser.addUser(email, username, 0, 0);
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 20,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 60,),
              ElevatedButton(

                onPressed: () {
                  widget.toggleView();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                ),
                child: Text(
                  'Already have an account? Log In!',
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
