import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/rounded_button.dart';


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
      // print(controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, 
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
