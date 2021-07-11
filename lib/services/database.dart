import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserDData(String name, String email) async {
    return await userCollection.doc(uid).set({"name": name, "email": email});
  }
}
