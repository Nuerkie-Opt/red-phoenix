import 'package:ecommerceproject/components/errorPage.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:ecommerceproject/providers/orderProvider.dart';
import 'package:ecommerceproject/screens/authentication/screens/login.dart';
import 'package:ecommerceproject/screens/dashboard/dashboard.dart';
import 'package:ecommerceproject/screens/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() async {
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
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Error();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return SplashPage();
      },
    );
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    analytics.logAppOpen();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Lotus',
        theme: ThemeData(
          primaryColor: Color(0xFF721727),
          //  scaffoldBackgroundColor: Colors.white,
          errorColor: Color(0xFF724017),
          fontFamily: 'Proxima Nova',
          primaryTextTheme: TextTheme(
              headline1: TextStyle(color: Color(0xFF721721), fontWeight: FontWeight.w600, fontSize: 18),
              headline2: TextStyle(color: Color(0xFF484848), fontWeight: FontWeight.w600, fontSize: 18),
              headline3: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
              bodyText1: TextStyle(color: Color(0xFF721721), fontSize: 14),
              bodyText2: TextStyle(color: Color(0xFF484848), fontSize: 18, fontWeight: FontWeight.w400),
              subtitle1: TextStyle(color: Color(0xFFc2c2c2), fontWeight: FontWeight.w200, fontSize: 12)),
        ),
        home: getLandingPage(analytics),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
      ),
    );
  }
}

Widget getLandingPage(FirebaseAnalytics analytics) {
  FirebaseAuth _auth = FirebaseAuth.instance;
  return StreamBuilder<User?>(
    stream: _auth.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData && (!snapshot.data!.isAnonymous)) {
        return Dashboard(
          analytics: analytics,
        );
      }

      return LogIn(
        analytics: analytics,
      );
    },
  );
}
