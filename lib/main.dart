import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'frontend/home.dart';
import 'frontend/login.dart';




void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:Colors.transparent, // navigation bar color
    statusBarColor: Color(0xFFFB7592), // status bar color
  ));
  runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    // home : LoginPage(),
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.white
      ),
      fontFamily: 'Poppins'
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => NavigationPage(),
      '/homescreen': (context) => HomeScreen(),
    },
  )
);
}

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return NavigationPage();
//   }
// }
