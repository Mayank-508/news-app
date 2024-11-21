import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_aplication/views/widgets/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * .01, vertical: screenHeight * .1),
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: screenWidth * .9,
                  height: screenHeight * .58,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/splash_pic.jpg',
                      fit: BoxFit.cover,
                      height: screenHeight * .4,
                      width: screenWidth * .8,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * .024,
                ),
                Text(
                  "Top Headlines",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                SizedBox(
                  height: screenHeight * .024,
                ),
                SpinKitChasingDots(
                  color: Colors.blue,
                  size: 50.0,
                  duration: Duration(
                    seconds: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
