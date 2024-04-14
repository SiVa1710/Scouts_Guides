import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouts and Guides',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0001cf),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icons/scouts.png',
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            CircularProgressIndicator(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              'DEVELOPED BY',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Sarabun',
                letterSpacing: 4.5,
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2.5,
              indent: MediaQuery.of(context).size.height * 0.11,
              endIndent: MediaQuery.of(context).size.height * 0.11,
            ),
            Text(
              'Sivasubramanian R', // Replace with your name
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.w200,
                color: Colors.yellow,
                fontFamily: 'Pacifico',
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
