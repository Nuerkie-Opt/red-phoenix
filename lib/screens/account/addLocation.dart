import 'package:ecommerceproject/models/userAddress.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:flutter/material.dart';

class AddLocation extends StatefulWidget {
  AddLocation({Key? key}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  UserAddress? address;
  String? dropDownValue = 'Northern';
  List<TextEditingController> controllers = List<TextEditingController>.generate(4, (index) => TextEditingController());
  List<String> regions = [
    'Northern',
    'Ashanti',
    'Western',
    'Volta',
    'Eastern',
    'Upper West',
    'Central',
    'Upper East',
    'Greater Accra',
    'Savannah',
    'North East',
    'Bono East',
    'Oti',
    'Ahafo',
    'Bono',
    'Western North'
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Add Location',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              TextFormField(
                controller: controllers[0],
                decoration:
                    InputDecoration(labelText: 'Address *', labelStyle: Theme.of(context).primaryTextTheme.bodyText1),
                validator: (value) {
                  if (controllers[0].text.isEmpty) return 'Please input field';
                },
              ),
              TextFormField(
                controller: controllers[1],
                decoration:
                    InputDecoration(labelText: 'GPS Address', labelStyle: Theme.of(context).primaryTextTheme.bodyText1),
              ),
              TextFormField(
                controller: controllers[2],
                decoration:
                    InputDecoration(labelText: 'City *', labelStyle: Theme.of(context).primaryTextTheme.bodyText1),
                validator: (value) {
                  if (controllers[2].text.isEmpty) return 'Please input field';
                },
              ),
              DropdownButtonFormField<String>(
                value: dropDownValue,
                onChanged: (newvalue) {
                  setState(() {
                    dropDownValue = newvalue;
                  });
                },
                items: regions.map((String regions) {
                  return DropdownMenuItem(
                    child: Text(regions),
                    value: regions,
                  );
                }).toList(),
                validator: (value) {
                  if (dropDownValue != value) {
                    return 'Choose region';
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    address = UserAddress(
                        address: controllers[0].text,
                        gpsAddress: controllers[1].text,
                        city: controllers[2].text,
                        region: dropDownValue);
                    await DatabaseService(uid: GlobalData.user?.uid).addLocation(address);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Location'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)),
              ),
            ],
          ),
        ));
  }
}
