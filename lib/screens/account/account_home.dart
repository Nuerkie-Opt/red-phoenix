import 'dart:io';

import 'package:ecommerceproject/components/alert.dart';
import 'package:ecommerceproject/models/userAddress.dart';
import 'package:ecommerceproject/screens/account/addLocation.dart';
import 'package:ecommerceproject/screens/account/settings.dart';
import 'package:ecommerceproject/screens/notifications/notification.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AccountHome extends StatefulWidget {
  final FirebaseAnalytics analytics;
  AccountHome({Key? key, required this.analytics}) : super(key: key);

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

  var collection = FirebaseFirestore.instance.collection('users');
  final imagePicker = ImagePicker();
  XFile? userPhoto;
  Widget? photoContainerChild;
  bool editUsername = false;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    getUserDetails();
    print(user);
    print(GlobalData.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Account",
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(
                            analytics: widget.analytics,
                          )));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: GlobalData.user?.photoUrl != null
                        ? CircleAvatar(radius: 80, backgroundImage: NetworkImage("${GlobalData.user?.photoUrl}"))
                        : Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                child: photoContainerChild != null
                                    ? CircleAvatar(
                                        radius: 80,
                                        child: ClipOval(
                                          child: photoContainerChild,
                                        ))
                                    : Text('${GlobalData.user?.displayName!.split('').first}',
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                                radius: 80,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    try {
                                      userPhoto = await imagePicker.pickImage(source: ImageSource.gallery);
                                    } catch (e, s) {
                                      alert(context, '$e:$s');
                                    }
                                    if (userPhoto != null) {
                                      setState(() {
                                        photoContainerChild = Image.file(File(userPhoto!.path));
                                        DatabaseService(uid: GlobalData.user?.uid)
                                            .uploadFile(GlobalData.user?.displayName, File(userPhoto!.path));
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.black,
                                    size: 30,
                                  ))
                            ],
                          ),
                  ),
                  ListTile(
                    title: Text(
                      'Username',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                    ),
                    subtitle: editUsername
                        ? Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Username',
                                    prefixIcon: Icon(Icons.person)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    user?.updateDisplayName(nameController.text);

                                    await DatabaseService(uid: user?.uid)
                                        .updateUserDData(nameController.text, user!.email!);
                                  },
                                  child: Text("Submit"))
                            ],
                          )
                        : Text(
                            '${GlobalData.user?.displayName}',
                            style: Theme.of(context).primaryTextTheme.bodyText2,
                          ),
                    trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ),
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                    ),
                    subtitle: Text(
                      '${GlobalData.user?.email}',
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                  ),
                  ListTile(
                      title: Text(
                        'Location',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                      ),
                      subtitle: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: collection.doc(GlobalData.user?.uid).snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                          if (snapshot.hasData) {
                            var output = snapshot.data!.data();
                            var value = output!['address'];
                            if (value != null) {
                              GlobalData.address = UserAddress.fromJson(value);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${GlobalData.address?.address}',
                                    style: Theme.of(context).primaryTextTheme.bodyText2,
                                  ),
                                  Text(
                                    '${GlobalData.address?.gpsAddress ?? null}',
                                    style: Theme.of(context).primaryTextTheme.bodyText2,
                                  ),
                                  Text(
                                    '${GlobalData.address?.city}, ${GlobalData.address?.region} ',
                                    style: Theme.of(context).primaryTextTheme.bodyText2,
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                  TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return AddLocation();
                            });
                      },
                      icon: Icon(Icons.add),
                      label: Text('Add Location'))
                ],
              ),
            ),
            //Container(child: ListView.builder(itemBuilder: ),)
          ],
        ),
      ),
    );
  }
}
