import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/models/paymentMode.dart';
import 'package:ecommerceproject/models/userAddress.dart';

import 'package:ecommerceproject/screens/account/addLocation.dart';
import 'package:ecommerceproject/screens/cart/checkout.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PaymentMode { momo, cash }

class OrderDetails extends StatefulWidget {
  final FirebaseAnalytics analytics;
  OrderDetails({Key? key, required this.analytics}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  PaymentMode? paymentMode;
  bool momoSelected = false;
  var provider = 'mtn';
  Map<String, String> providers = {'mtn': 'MTN', 'tgo': 'AirtelTigo', 'vod': 'Vodafone'};
  List<String> providerCodes = ['mtn', 'tgo', 'vod'];
  List<String> providerNames = ['MTN', 'AirtelTigo', 'Vodafone'];
  var collection = FirebaseFirestore.instance.collection('users');
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController momoNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PaymentDetails? paymentDetails;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Text(
              'Add Details',
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
        padding: EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
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
              SizedBox(height: 10),
              Text(
                'Delivery Details',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          hintText: 'Add name of person for delivery',
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) return "Please add name";
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          hintText: 'Add phone number of person for delivery',
                          prefixIcon: Icon(Icons.phone)),
                      validator: (value) {
                        if (value!.isEmpty) return "Please add phone number";
                        if (!value.contains(RegExp(r'^[0-9]*$'))) return "Phone number should not contain a letter";
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Select Payment Mode',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              Column(mainAxisSize: MainAxisSize.min, children: [
                RadioListTile<PaymentMode>(
                  activeColor: Color(0xFF4a5aed),
                  value: PaymentMode.cash,
                  groupValue: paymentMode,
                  onChanged: (PaymentMode? value) {
                    setState(() {
                      paymentMode = value;
                      momoSelected = false;
                    });
                  },
                  title: Text('Cash'),
                ),
                RadioListTile<PaymentMode>(
                  activeColor: Color(0xFF4a5aed),
                  value: PaymentMode.momo,
                  groupValue: paymentMode,
                  onChanged: (PaymentMode? value) {
                    setState(() {
                      paymentMode = value;
                      momoSelected = true;
                    });
                  },
                  title: Text('MoMo'),
                ),
                Visibility(
                  visible: momoSelected,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: provider,
                        onChanged: (newvalue) {
                          setState(() {
                            provider = newvalue!;
                          });
                        },
                        items: providers
                            .map((code, name) {
                              return MapEntry(
                                  code,
                                  DropdownMenuItem<String>(
                                    value: code,
                                    child: Text(name),
                                  ));
                            })
                            .values
                            .toList(),
                        validator: (value) {
                          if (provider != value) {
                            return '--Select Provider--';
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: momoNumberController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            hintText: 'Add Momo number',
                            prefixIcon: Icon(Icons.phone)),
                        validator: (value) {
                          if (value!.isEmpty) return "Please add your momo number";
                          if (!value.contains(RegExp(r'^[0-9]*$'))) return "Momo number should not contain a letter";
                        },
                      ),
                    ],
                  ),
                )
              ]),
              SizedBox(height: 10),
              Text(
                'Fee',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              Text(
                'Delivery Fee : GHS 10.0',
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            if (GlobalData.address != null && _formKey.currentState!.validate()) {
              if (paymentMode == PaymentMode.momo) {
                MoMoPayments moMoPayments = MoMoPayments(
                    amount: (cart.totalAmount + 10) * 100,
                    email: GlobalData.user?.email,
                    currency: "GHS",
                    momo: MobileMoney(phone: momoNumberController.text, provider: provider));
                paymentDetails = PaymentDetails(paymentDetails: moMoPayments.toJson());
              } else {
                paymentDetails = PaymentDetails(paymentDetails: "cash");
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOut(
                          paymentMode: paymentMode!,
                          name: nameController.text,
                          phoneNumber: phoneNumberController.text,
                          analytics: widget.analytics,
                          paymentDetails: paymentDetails!)));
            } else {
              showToastMessage('Some details are missing!');
            }
          },
          child: Text(
            'Continue',
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
