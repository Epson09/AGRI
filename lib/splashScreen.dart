import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tp_app/util/fontAnim.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tp_app/util/navigate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => Navigate.gotoLogin(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
              child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(183, 88, 241, 11),
                  Color.fromARGB(255, 226, 176, 156)
                ])),
          )),
          const Positioned.fill(
              child: Opacity(
            opacity: 0.5,
            child: FontAnim(50),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/sun1.svg',
                height: 200,
                width: 200,
              ),
              const Text(
                'AGRIMETEO',
                style: TextStyle(
                    fontFamily: 'CAMBRIA', fontSize: 24, color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 12,
            child: const Padding(
                padding:
                    EdgeInsets.only(left: 0, right: 0, top: 50, bottom: 20)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Developper par:',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'DIGITAL FARM',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              Padding(padding: EdgeInsets.only(bottom: 40.0))
            ],
          )
        ],
      ),
    );
  }
}
