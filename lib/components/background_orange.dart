import 'package:flutter/material.dart';

class OrangeBackground extends StatelessWidget {
  final Widget child;

  const OrangeBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/icon/images/orange/top1.png",
                width: size.width),
          ),
          Positioned(
            top: -90,
            right: 0,
            child: Image.asset("assets/icon/images/orange/top2.png",
                width: size.width),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: Image.asset("assets/icon/images/orange/forgotpass.png",
                width: size.width * 0.45, height: 130),
          ),
          Positioned(
            bottom: -90,
            right: 10,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                "assets/icon/images/orange/bottom1.png",
                width: size.width,
                height: size.height * 0.49,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                "assets/icon/images/orange/bottom2.png",
                width: size.width,
                height: size.height * 0.13,
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
