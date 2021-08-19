import 'dart:io';

import 'package:ecommerceproject/components/alert.dart';
import 'package:ecommerceproject/components/noSearchAppbar.dart';
import 'package:ecommerceproject/models/userAddress.dart';
import 'package:ecommerceproject/screens/account/addLocation.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

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

  var collection = FirebaseFirestore.instance.collection('users');
  final imagePicker = ImagePicker();
  XFile? userPhoto;
  Widget? photoContainerChild;

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
      appBar: SubPageAppbar(
        title: 'Account',
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
                    subtitle: Text(
                      '${GlobalData.user?.displayName}',
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
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
                      'Phone Number',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                    ),
                    subtitle: Text(
                      '${GlobalData.user?.phoneNumber ?? " "}',
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 90.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.edit),
          focusColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
