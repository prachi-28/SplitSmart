// if user is logged in, show the home page
// else show login page

import 'package:flutter/material.dart';
import 'package:split_smart/authentication/authenticate.dart';
import 'package:split_smart/home/home.dart';
import 'package:split_smart/models/user.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<myUser>(context);
    print(user);

    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
