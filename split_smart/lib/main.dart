import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_smart/services/auth.dart';
import 'package:split_smart/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:split_smart/models/user.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /*String _darkColour = "#0F1D2E";
  String _lightColour = "#E7DDC7";*/
  String _contrastColour = "#e16428"; // orange-ish

  String _darkColour = "#272121";
  String _lightColour = "#363333"; // lighter shade of black
  String _textColour = "#FFFFFF";
  //String _contrastColour = "#e880ff";
  //String _contrastColour = "#893091";

  /*String _darkColour = "#ce5a6f";
  String _lightColour = "#f3dee7";
  String _contrastColour = "#4d0766";*/

  @override
  Widget build(BuildContext context) {
    return StreamProvider<myUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: HexColor(_darkColour), //dark pink-ish
          accentColor: HexColor(_lightColour), //purple

          backgroundColor: HexColor(_lightColour), //pale pink
          scaffoldBackgroundColor: HexColor(_lightColour),
          //dialogBackgroundColor: HexColor("#f3dee8"),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: HexColor(_lightColour),
            selectedItemColor: HexColor(_contrastColour),
            unselectedItemColor: HexColor(_darkColour),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: HexColor(_darkColour),
            textTheme: ButtonTextTheme.accent,
          ),


          /*textTheme: TextTheme(
            button: TextStyle(
              color: HexColor(_darkColour),
            ),
            body1: TextStyle(
              color: HexColor(_lightColour),
            ),
            body2: TextStyle(
              color: HexColor(_lightColour),
            ),
            title: TextStyle(
              color: HexColor(_darkColour),
            ),
            subtitle: TextStyle(
              color: HexColor(_darkColour),
            )
          ),*/
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: HexColor(_textColour),
            displayColor: HexColor(_textColour),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: HexColor(_contrastColour),
            foregroundColor: HexColor(_lightColour),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: HexColor(_contrastColour),
              onPrimary: HexColor(_lightColour),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor(_darkColour), width: 1.5),

            ),
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(HexColor(_contrastColour)),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}
