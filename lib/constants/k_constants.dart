import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Colors
const Color enabled = Color(0xFF827F8A);
const Color enabledtxt = Colors.white;
const Color deaible = Colors.grey;
const Color forgotPassBackgroundColor = Color(0xFF1F1A30);
const Color kJungleGreen = Color.fromRGBO(31, 171, 137, 1);
const Color kJungleDarkGreen = Color(0xff01ECC0);
const Color kRichBlackFogra = Color.fromRGBO(13, 27, 42, 1);
const Color kOxfordBlue = Color.fromRGBO(27, 38, 59, 1);
const Color kBdazalledBlue = Color.fromRGBO(65, 90, 119, 1);
const Color kPlatinum = Color.fromRGBO(224, 225, 221, 1);
const Color kTuscany = Color.fromRGBO(205, 162, 171, 1);

// Background Colors
final Color kGreenBackground = kJungleGreen.withOpacity(0.65);
final kBlueBackground = Colors.blue.withOpacity(0.06);
final kOrangeBackground = kTuscany.withOpacity(0.65);

// Reusable Widget: Back to Login Button
final kBackToLogin = Container(
  height: 50,
  width: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.transparent,
    border: Border.all(
      color: kOxfordBlue,
      width: 2,
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        'Back to Login',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kJungleGreen,
        ),
      ),
      Icon(
        Icons.arrow_forward,
        color: kJungleGreen,
      ),
    ],
  ),
);

// Text Style: Register Text
const kRegisterText = Text(
  'REGISTER',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: kBdazalledBlue,
  ),
  textAlign: TextAlign.left,
);

// BorderRadius for Cards
const kCards = BorderRadius.only(
  bottomLeft: Radius.circular(5),
  bottomRight: Radius.circular(5),
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

// Text Field Style: Password
const kTextFieldPass = TextField(
  enableSuggestions: false,
  autocorrect: false,
  showCursor: true,
  textAlign: TextAlign.center,
  decoration: InputDecoration(),
);

// Box Shadows
const kBoxShadowBlue = BoxShadow(
  color: kBdazalledBlue,
  blurRadius: 10,
  spreadRadius: 5,
);
const kBoxShadowGreen = BoxShadow(
  color: kJungleGreen,
  blurRadius: 10,
  spreadRadius: 5,
);

// Decoration for Gradient Button
final BoxDecoration gradientButton = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: kJungleGreen,
  boxShadow: const [
    BoxShadow(color: kJungleGreen, spreadRadius: 1),
  ],
);

// Decoration for Text Fields
const kFieldDecoration = InputDecoration(
  fillColor: kTuscany,
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

// EdgeInsets Constants
const k8pad = EdgeInsets.all(8.0);
const k10pad = EdgeInsets.all(10.0);
const k20pad = EdgeInsets.all(30.0);
const k3010LRpad = EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10);
const k10SizedBox = SizedBox(height: 10.0);
const k20SizedBox = SizedBox(height: 20.0);
const k24SizedBox = SizedBox(height: 24.0);

// Container for Notes App Bar
final NotesAppBarContainer = Container(
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        kJungleGreen.withOpacity(0.3),
        kOxfordBlue.withOpacity(0.9),
      ],
    ),
  ),
);

// Text Style for Buttons
const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
);

// Container for Login Button
final kLoginContainer = Container(
  height: 50,
  width: 120,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: kJungleGreen,
    boxShadow: const [
      BoxShadow(
        color: Colors.white,
        spreadRadius: 1,
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'LOGIN',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  ),
);

// Container for Register Button
final kRegisterContainer = Container(
  height: 50,
  width: 120,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: kBdazalledBlue,
    boxShadow: const [
      BoxShadow(
        color: kBdazalledBlue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'REGISTER',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  ),
);

// Text Field for Email Input
const kEmailTextField = TextField(
  enableSuggestions: false,
  autocorrect: false,
  showCursor: true,
  keyboardType: TextInputType.emailAddress,
  textAlign: TextAlign.center,
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.email),
    labelText: 'Email',
    hintText: 'Enter your email here',
  ),
);

// Container for Sending Email Verification
final kSendEmailVerificationContainer = Container(
  height: 50,
  width: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: kBdazalledBlue,
    boxShadow: const [
      BoxShadow(
        color: kBdazalledBlue,
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

// Container for Resending Verification
final kSendVerificationContainer = Container(
  height: 50,
  width: 250,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: kBdazalledBlue,
    boxShadow: const [
      BoxShadow(
        color: kBdazalledBlue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        'RESEND',
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
    ],
  ),
);

// Container for Restarting
final kRestartContainer = Container(
  height: 50,
  width: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: kBdazalledBlue,
    boxShadow: const [
      BoxShadow(
        color: kBdazalledBlue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        'RESTART',
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
    ],
  ),
);

// Container for Sending Password Reset
final kSendPasswordResetContainer = Container(
  height: 50,
  width: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: kBdazalledBlue,
    boxShadow: const [
      BoxShadow(
        color: kBdazalledBlue,
        spreadRadius: 1,
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        'Send password reset',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      SizedBox(width: 5),
      Icon(
        Icons.send_sharp,
        color: Colors.white,
        size: 20,
      ),
    ],
  ),
);

// Container for Sending Reset Link
final kSendResetLinkContainer = Container(
  decoration: const BoxDecoration(
      // add icon to the button
      ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        'Send',
        style: TextStyle(
          color: kPlatinum,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      Icon(
        Icons.send_rounded,
        color: kPlatinum,
        size: 20,
      ),
    ],
  ),
);

// Container for Back to Login
final kBackToLoginContainer = Container(
  height: 50,
  width: 200,
  constraints: const BoxConstraints(
    maxWidth: 250,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: kJungleGreen,
      width: 2,
    ),
    color: kJungleGreen,
    boxShadow: const [
      BoxShadow(
        color: kJungleGreen,
        spreadRadius: 1,
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'Back to Login',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  ),
);

// Input Decoration for Forgot Password
final kForgotPasswordContainerDecoration = InputDecoration(
  label: const Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(
      'Email',
      style: TextStyle(color: Colors.black),
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.white,
    ),
  ),
  enabledBorder: const UnderlineInputBorder(
    borderSide: BorderSide(
      color: kTuscany,
    ),
  ),
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(
      color: kTuscany,
    ),
  ),
);

// Text Style for Logout Text
const textLogoutStyle = Text(
  'Logout',
  style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
);

// Grid Constants
const gridCross = 1;
const gridCross2 = 2;
const gridCross3 = 3;
const gridCross4 = 4;

// Sliver Grid Delegate
final twoBytwo = SliverQuiltedGridDelegate(
  crossAxisCount: 2,
  mainAxisSpacing: 2,
  crossAxisSpacing: 4,
  repeatPattern: QuiltedGridRepeatPattern.inverted,
  pattern: [
    const QuiltedGridTile(1, 1),
    const QuiltedGridTile(1, 1),
  ],
);
