import 'package:flutter/material.dart';
class clglogo extends StatefulWidget {


  @override
  State<clglogo> createState() => _clglogoState();
}

class _clglogoState extends State<clglogo> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacementNamed(context, '/loading',
          );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset("assets/NI.jpeg"),
    );
  }
}
