import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  static const String id='welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  AnimationController controller;
  
  @override
  void initState() {

    super.initState();

    controller =  AnimationController(
      duration: Duration(seconds: 5),
      vsync: this, 
      upperBound: 100
      // lowerBound:1,
      // upperBound: 100.0
    );

    controller.forward(); //start the animation or proceed

    controller.addListener((){
      setState(() { 
      });
      print(controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo' ,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value,
                  ),
                ),
                Text(
                  'Flash chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),

            RoundedButton(title: 'Log In', colour: Colors.lightBlueAccent, onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },),

            RoundedButton(title: 'Register', colour: Colors.blueAccent,onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },),

          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  // const RoundedButton({
  //   Key key,
  // }) : super(key: key);


  RoundedButton({this.title,this.colour,@required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        // color: Colors.lightBlueAccent,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,  
          ),
        ),
      ),
    );
  }
}
