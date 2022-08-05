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

final gradientButton = BoxDecoration(
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
