import 'dart:convert';
import 'dart:io';

import 'package:ecommerceproject/models/paymentMode.dart';
import 'package:ecommerceproject/models/paystackResponse.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class PaystackApi {
  static bool? status;
  static PaystackResp? paystackResp;
  static String? referenceCode;
  static String? displayText;
  static String? submitDisplayText;
  static Future<String> makePaymentMoMo(MoMoPayments paymentDetails) async {
    var uri = Uri.parse("https://api.paystack.co/charge");
    var response;

    try {
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

      print(response.statusCode);

      if (response.statusCode == 200) {
        status = true;
        var data = json.decode(response.body);
        referenceCode = data['data']['reference'];
        displayText = data['data']['display_text'];
        print(referenceCode);

        return referenceCode!;
      } else {
        status = false;
        var data = jsonDecode(response.body);
        print(data);
      }
    } catch (e) {
      status = false;
    }
    return "";
  }

  static submitOTP(String otp, String reference) async {
    var uri = Uri.parse("https://api.paystack.co/charge/submit_otp");
    var response;
    try {
      print('trying');
      response = await http.post(uri,
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $PAYSTACK_SK",
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: json.encode({'otp': otp, 'reference': reference}));
      print('done');
      print(response.statusCode);
      if (response.statusCode == 200) {
        status = true;
        var data = jsonDecode(response.body);
        submitDisplayText = data['data']['display_text'];
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
