import 'package:ecommerceproject/screens/authentication/screens/login.dart';
import 'package:ecommerceproject/services/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  SettingsPage({Key? key, required this.analytics}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Settings",
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () async {
              await _authService.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LogIn(
                            analytics: widget.analytics,
                          )));
            },
            title: Text("Logout"),
            trailing: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
