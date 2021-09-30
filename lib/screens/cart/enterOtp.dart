import 'package:ecommerceproject/api/paystackApi.dart';
import 'package:ecommerceproject/components/toast.dart';
import 'package:flutter/material.dart';

class EnterOtp extends StatefulWidget {
  final String displayText;
  final String referenceCode;
  EnterOtp({Key? key, required this.displayText, required this.referenceCode}) : super(key: key);

  @override
  _EnterOtpState createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter OTP',
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Center(
          child: Column(
            children: [
              Text(
                widget.displayText,
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: otpController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'OTP',
                    hintText: 'Enter OTP',
                    prefixIcon: Icon(Icons.phone)),
                validator: (value) {
                  if (value!.isEmpty) return "Please enter the otp sent to your mobile number";
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size.fromHeight(50),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    )),
                onPressed: () async {
                  await PaystackApi.submitOTP(otpController.text, widget.referenceCode);
                  if (PaystackApi.submitDisplayText != null) {
                    showToastMessage(PaystackApi.submitDisplayText);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Submit OTP',
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
