import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/models/paymentMode.dart';
import 'package:ecommerceproject/screens/cart/enterOtp.dart';
import 'package:ecommerceproject/screens/cart/orderDetails.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceproject/api/paystackApi.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:ecommerceproject/providers/orderProvider.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  final PaymentMode paymentMode;
  final String name;
  final String phoneNumber;
  final PaymentDetails paymentDetails;
  final FirebaseAnalytics analytics;
  CheckOut(
      {Key? key,
      required this.paymentMode,
      required this.name,
      required this.phoneNumber,
      required this.analytics,
      required this.paymentDetails})
      : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String? referenceCode;
  MoMoPayments? moMoPayments;
  String? momoProvider;
  MoMoPayments? getMoMoDetails(String details) {
    if (widget.paymentMode == PaymentMode.momo) {
      moMoPayments = MoMoPayments.fromJson(details);
      if (moMoPayments!.momo.provider == 'mtn') {
        momoProvider = 'MTN';
      } else if (moMoPayments!.momo.provider == 'vod') {
        momoProvider = 'Vodafone';
      } else {
        momoProvider = 'AirtelTigo';
      }
      return moMoPayments;
    }
  }

  @override
  void initState() {
    getMoMoDetails(widget.paymentDetails.paymentDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Details',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            Text(
              'Name: ${widget.name}',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            Text(
              'PhoneNumber: ${widget.phoneNumber}',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            Text(
              '${GlobalData.address?.address} ${GlobalData.address?.gpsAddress ?? null}',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            Text(
              '${GlobalData.address?.city}, ${GlobalData.address?.region} ',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Payment',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            widget.paymentMode == PaymentMode.cash
                ? Text(
                    widget.paymentDetails.paymentDetails,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PhoneNumber: ${moMoPayments!.momo.phone}',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      ),
                      Text(
                        'Provider: ${momoProvider!}',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      )
                    ],
                  ),
            Text(
              'Amount Due: GHS ${cart.totalAmount + 10}',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Products',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(),
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(
                    '${cart.items.values.toList()[i].product.name}',
                    style: Theme.of(context).primaryTextTheme.headline2,
                  ),
                  subtitle: Text(
                    'Quantity: ${cart.items.values.toList()[i].quantity.toString()}',
                    style: TextStyle(color: Color(0xFF484848), fontSize: 12),
                  ),
                  trailing: Text(
                    cart.items.values.toList()[i].salePrice.toString(),
                    style: TextStyle(color: Color(0xFF484848), fontSize: 12),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
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
            await Provider.of<Orders>(context, listen: false).addOrder(
                cart.items.values.map((e) => e.toJson()).toList(),
                GlobalData.address,
                GlobalData.user,
                10,
                cart.totalAmount + 10,
                widget.name,
                widget.phoneNumber,
                widget.paymentDetails);
            await widget.analytics.logEcommercePurchase(
              currency: 'GHS',
              value: 432.45,
              transactionId: '${GlobalData.user?.email} - ${GlobalData.numberOfOrders + 1}',
              shipping: 10,
            );
            if (widget.paymentMode == PaymentMode.momo) {
              await PaystackApi.makePaymentMoMo(MoMoPayments.fromJson(widget.paymentDetails.paymentDetails));
              if (PaystackApi.referenceCode!.isNotEmpty) {
                setState(() {
                  referenceCode = PaystackApi.referenceCode;
                });
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EnterOtp(
                            displayText: PaystackApi.displayText!, referenceCode: PaystackApi.referenceCode!)));
              }
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
            }
            cart.clear();
            showToastMessage('Order Made');
          },
          child: Text(
            'Checkout',
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
