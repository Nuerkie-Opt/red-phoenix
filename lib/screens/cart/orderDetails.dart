import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/models/userAddress.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:ecommerceproject/providers/orderProvider.dart';
import 'package:ecommerceproject/screens/account/addLocation.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var collection = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Text(
              'My Order',
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
            Icon(
              Icons.assignment_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Address',
                  style: Theme.of(context).primaryTextTheme.headline1,
                ),
                ListTile(
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
                              '${GlobalData.address?.address} ${GlobalData.address?.gpsAddress ?? null}',
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
                    label: Text('Change Address')),
                Text(
                  'Fee',
                  style: Theme.of(context).primaryTextTheme.headline1,
                ),
                Text(
                  'Delivery Fee : GHS 10.0',
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                ),
                SizedBox(height: 20),
                Text('Items', style: Theme.of(context).primaryTextTheme.headline1),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: Text(
                            '${cart.items.values.toList()[i].product.name}',
                            style: Theme.of(context).primaryTextTheme.headline2,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity: ${cart.items.values.toList()[i].quantity.toString()}',
                                style: TextStyle(color: Color(0xFF484848), fontSize: 12),
                              ),
                              Text(
                                'Colour: ${cart.items.values.toList()[i].selectedColor.toString()}',
                                style: TextStyle(color: Color(0xFF484848), fontSize: 12),
                              ),
                              Text(
                                'Size: ${cart.items.values.toList()[i].selectedSize.toString()}',
                                style: TextStyle(color: Color(0xFF484848), fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            minimumSize: Size.fromHeight(50),
                          ),
                          onPressed: () async {
                            if (GlobalData.address != null) {
                              await Provider.of<Orders>(context, listen: false)
                                  .addOrder(cart.items.values.toList(), GlobalData.address, 10, cart.totalAmount + 10);
                              cart.clear();
                              showToastMessage('Order Made');
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              showToastMessage('Please add an address');
                            }
                          },
                          child: Text(
                            'Confirm Order',
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        )),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Total:'),
                              Text(
                                'GHS: ${cart.totalAmount + 10}',
                                style: Theme.of(context).primaryTextTheme.headline1,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
