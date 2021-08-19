import 'dart:io';
import 'package:ecommerceproject/models/order.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:path/path.dart' as p;
import 'package:ecommerceproject/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/models/userAddress.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('orders');

  Future updateUserDData(String name, String email) async {
    return await userCollection.doc(uid).set({"name": name, "email": email});
  }

  Future updateUserPhoto(String? photoUrl) async {
    return await userCollection.doc(uid).update({"photoUrl": photoUrl});
  }

  Future addLocation(UserAddress? address) async {
    return await userCollection.doc(uid).update(
      {"address": address?.toJson()},
    );
  }

  Future recentlyViewedProducts(Product product) async {
    return await userCollection.doc(uid).update({
      "recentProducts": FieldValue.arrayUnion([product.toJson()])
    });
  }

  Future<void> saveImages(String? username, File image, DocumentReference ref) async {
    String? imageURL = await uploadFile(username, image);
    ref.update({
      "photoUrl": FieldValue.arrayUnion([imageURL])
    });
  }

  Future<String?> uploadFile(String? username, File _image) async {
    final AuthService _auth = AuthService();

    String? returnURL;
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child('$username/profilePic/${p.basename(_image.path)}');
    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.whenComplete(() async {
      print('File Uploaded');

      await storageReference.getDownloadURL().then((fileURL) async {
        returnURL = fileURL;
        await _auth.updateProfilePic(returnURL);
        return returnURL;
      });
    });

    return returnURL;
  }

  Future saveOrder(Order order) async {
    return await orderCollection.doc(uid).update({
      "order": FieldValue.arrayUnion([order.toJson()])
    });
  }
}

class GetData {
  static CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  static Future<void> getData() async {
    QuerySnapshot querySnapshot = await productsCollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
  }
}
