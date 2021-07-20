import 'package:ecommerceproject/components/noSearchAppbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountHome extends StatefulWidget {
  AccountHome({Key? key}) : super(key: key);

  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  var user;

  getUserDetails() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    user = prefs.getStringList("user");
  }

  @override
  void initState() {
    getUserDetails();
    print(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppbar(
        title: 'Account',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 20,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
