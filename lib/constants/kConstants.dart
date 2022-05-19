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
