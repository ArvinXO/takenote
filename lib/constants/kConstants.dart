import 'package:flutter/material.dart';

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
  // gradient: const LinearGradient(
  //   begin: Alignment.topRight,
  //   end: Alignment.bottomLeft,
  //   stops: [
  //     0.1,
  //     0.4,
  //     0.6,
  //     0.9,
  //   ],
  //   colors: [
  //     Colors.yellow,
  //     Colors.green,
  //     Colors.green,
  //     Colors.teal,
  //   ],
  // ),
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
const k10SizedBox = SizedBox(height: 10.0);
const k20SizedBox = SizedBox(height: 20.0);
const k24SizedBox = SizedBox(height: 24.0);

const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
);
