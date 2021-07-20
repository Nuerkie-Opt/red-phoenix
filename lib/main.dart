import 'package:ecommerceproject/components/errorPage.dart';
import 'package:ecommerceproject/components/loading.dart';
import 'package:ecommerceproject/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LotusApp());
}

class LotusApp extends StatefulWidget {
  LotusApp({Key? key}) : super(key: key);

  @override
  _LotusAppState createState() => _LotusAppState();
}

class _LotusAppState extends State<LotusApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Error();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return loader(context);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotus',
      theme: ThemeData(
        primaryColor: Color(0xFF721727),
        scaffoldBackgroundColor: Colors.white,
        errorColor: Color(0xFF724017),
        fontFamily: 'Proxima Nova',
        primaryTextTheme: TextTheme(
            headline1: TextStyle(color: Color(0xFF721721), fontWeight: FontWeight.w600, fontSize: 18),
            headline2: TextStyle(color: Color(0xFF484848), fontWeight: FontWeight.w600, fontSize: 18),
            headline3: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
            bodyText1: TextStyle(color: Color(0xFF721721), fontSize: 14),
            bodyText2: TextStyle(color: Color(0xFF484848), fontSize: 18),
            subtitle1: TextStyle(color: Color(0xFFc2c2c2), fontWeight: FontWeight.w200, fontSize: 12)),
      ),
      home: SplashPage(),
    );
  }
}
