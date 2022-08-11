import 'package:flutter/material.dart';

final kGreenBackground = Colors.green.withOpacity(
  0.06,
);

final kBlueBackground = Colors.blue.withOpacity(
  0.06,
);
const kCards = BorderRadius.only(
  bottomLeft: Radius.circular(5),
  bottomRight: Radius.circular(5),
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

const kTextFieldPass = TextField(
  enableSuggestions: false,
  autocorrect: false,
  showCursor: true,
  textAlign: TextAlign.center,
  decoration: InputDecoration(),
);

const kBoxShadowBlue = BoxShadow(
  color: Colors.blue,
  blurRadius: 10,
  spreadRadius: 5,
);

const kBoxShadowGreen = BoxShadow(
  color: Colors.green,
  blurRadius: 10,
  spreadRadius: 5,
);

final BoxDecoration gradientButton = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.green,
  boxShadow: const [
    BoxShadow(color: Colors.green, spreadRadius: 1),
  ],
);

const kFieldDecoration = InputDecoration(
  fillColor: Colors.deepOrangeAccent,
  filled: true,
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const k8pad = EdgeInsets.all(8.0);
const k10pad = EdgeInsets.all(10.0);
const k20pad = EdgeInsets.all(30.0);
const k3010LRpad = EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10);
const k10SizedBox = SizedBox(height: 10.0);
const k20SizedBox = SizedBox(height: 20.0);
const k24SizedBox = SizedBox(height: 24.0);

const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
);

final kLoginContainer = Container(
  height: 50,
  width: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.green,
    boxShadow: const [
      BoxShadow(
        color: Colors.white,
        spreadRadius: 1,
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'Login',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  ),
);

final kRegisterContainer = Container(
  height: 50,
  width: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.blue,
    boxShadow: const [
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'Register',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  ),
);

const kEmailTextField = TextField(
  enableSuggestions: false,
  autocorrect: false,
  showCursor: true,
  keyboardType: TextInputType.emailAddress,
  textAlign: TextAlign.center,
  decoration: InputDecoration(
      prefixIcon: Icon(Icons.email),
      labelText: 'Email',
      hintText: 'Enter your email here'),
);

final kSendEmailVerificationContainer = Container(
  height: 50,
  width: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.blue,
    boxShadow: const [
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'Send email verification',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
  ),
);

final kSendVerificationContainer = Container(
  height: 50,
  width: 250,
  decoration: BoxDecoration(
    // add icon to the button

    borderRadius: BorderRadius.circular(20),
    color: Colors.blue,
    boxShadow: const [
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        'Resend verification',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      SizedBox(width: 5),

      Icon(
        Icons.send_sharp,
        color: Colors.white,
        size: 20,
      ),
      //space between the icon and the text
    ],
  ),
);

final kRestartContainer = Container(
  height: 50,
  width: 200,
  decoration: BoxDecoration(
    // add icon to the button

    borderRadius: BorderRadius.circular(20),
    color: Colors.blue,
    boxShadow: const [
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        'Restart',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      SizedBox(width: 5),

      Icon(
        Icons.refresh,
        color: Colors.white,
        size: 20,
      ),
      //space between the icon and the text
    ],
  ),
);
