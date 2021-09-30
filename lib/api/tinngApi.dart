import 'dart:convert';
import 'dart:io';

import 'package:ecommerceproject/models/paymentMode.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class TinngApi {
  static bool? status;
  // generate access token
  static generateToken() async {
    var uri = Uri.parse("https://developer.tingg.africa/checkout/v2/custom/oauth/token");
    http.Response response;
    try {
      response = await http.post(uri,
          body: json.encode({
            "grant_type": "client_credentials",
            "client_id": TINNG_CLIENT_ID,
            "client_secret": TINNG_CLIENT_SECRET
          }));
      print(response.statusCode);
      print(response.reasonPhrase);
      if (response.statusCode == 200) {
        status = true;
        var data = json.decode(response.body);
        print(data);
      } else {
        status = false;
        var data = json.decode(response.body);

        print(data);
      }
    } catch (e) {}
  }

  static makePaymentMoMo(MoMoPayments paymentDetails) async {
    var uri = Uri.parse("https://api.paystack.co/charge");
    var response;
    try {
      print('trying');
      response = await http.post(uri,
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $PAYSTACK_SK",
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: json.encode({
            "amount": paymentDetails.amount,
            "email": paymentDetails.email,
            "currency": "GHS",
            "mobile_money": {"phone": paymentDetails.momo.phone, "provider": paymentDetails.momo.provider}
          }));
      print('done');
      print(response.statusCode);
      if (response.statusCode == 200) {
        status = true;
        var data = jsonDecode(response.body);
        print(data);
      } else {
        status = false;
        var data = jsonDecode(response.body);
        print(data);
      }
    } catch (e) {
      status = false;
    }
  }
}
