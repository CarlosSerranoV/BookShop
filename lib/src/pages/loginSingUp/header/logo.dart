import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: MediaQuery.of(context).size.width * 0.38,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)]),
        child: Align(
            alignment: Alignment.center,
            child: Text('BookShop',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5511b0)))),
      ),
    );
  }
}
