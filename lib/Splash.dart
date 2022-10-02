
// ignore_for_file: file_names

import 'dart:async';
import 'package:employee/plugins/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WelcomeScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);


  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => const WelcomeScreen()
              // (context) => DoctorSignIn()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          left: false,
          right: false,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.4,0.8],
                colors: [
                  Color(0xffC1272D),
                  Color(0xff651C69),
                  Color(0xff28225E),
                ],
              ),
            ),
            child:Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 45.0 *SizeConfig.heightMultiplier!,),
                  Text(
                    "WELCOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 5.3 * SizeConfig.textMultiplier!,
                      fontFamily: 'Proxima',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 7.0 *SizeConfig.heightMultiplier!,),
                  Text(
                    "Employee",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 2.5 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0 * SizeConfig.heightMultiplier!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Powered by: ",
                          style: TextStyle(
                              fontSize: 1.8 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontStyle: FontStyle.italic
                          ),
                        ),
                        Text(
                          "Al-Naqeebia SoftTech Software Developer",
                          style: TextStyle(
                              fontSize: 1.8 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

}
