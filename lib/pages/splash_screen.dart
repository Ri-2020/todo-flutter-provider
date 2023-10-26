import 'package:flutter/material.dart';
import 'package:todo/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/welcome";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isNavigated = false;

  void _goToHomePage() {
    if (!_isNavigated) {
      _isNavigated = true;
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), _goToHomePage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "TODO",
              style: TextStyle(
                color: Colors.amberAccent.shade100,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              "Provider Practice\nby Rohit Gupta",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.amberAccent.shade100,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
