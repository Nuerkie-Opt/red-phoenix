import 'dart:io';
import 'package:ecommerceproject/models/order.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/utils/globalData.dart';
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
    return await userCollection
        .doc(uid)
        .set({"name": name, "email": email, "userType": "customer", "dateSignedUp": DateTime.now()});
  }

  Future setLastSeen() async {
    return await userCollection.doc(uid).update({"lastSeen": DateTime.now()});
  }

  Future trackOrders(int numberofOrders) async {
    return await userCollection.doc(uid).update({"numberOfOrders": numberofOrders});
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
    await DatabaseService(uid: GlobalData.user.uid)
        .trackOrders(GlobalData.numberOfOrders == null ? 1 : GlobalData.numberOfOrders + 1);

    return await orderCollection.doc().set({
      "products": order.products,
      "id": order.id,
      "date": order.date,
      "deliveryFee": order.deliveryFee,
      "amount": order.amount,
      "userData": order.userData.toJson(),
      "userAddress": order.userAddress.toJson(),
      "orderNo": order.orderNo,
      "status": order.status,
      "deliveryName": order.deliveryName,
      "phoneNumber": order.phoneNumber,
      'paymentDetails': order.paymentDetails
    });
  }
}
